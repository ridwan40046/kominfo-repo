//
//  FSCameraVC.swift
//  YPImgePicker
//
//  Created by Sacha Durand Saint Omer on 25/10/16.
//  Copyright © 2016 Yummypets. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

public class FSCameraVC: UIViewController, UIGestureRecognizerDelegate {
    
    public var didCapturePhoto: ((UIImage) -> Void)?
    private let sessionQueue = DispatchQueue(label: "FSCameraVCSerialQueue")
    let session = AVCaptureSession()
    var device: AVCaptureDevice? {
        return videoInput?.device
    }
    var videoInput: AVCaptureDeviceInput!
    let imageOutput = AVCaptureStillImageOutput()
    let focusView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    var v = FSCameraView()
    var isPreviewSetup = false
    
    override public func loadView() { view = v }
    
    private let configuration: YPImagePickerConfiguration!
    public required init(configuration: YPImagePickerConfiguration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
        title = fsLocalized("YPImagePickerPhoto")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        v.flashButton.isHidden = true
        v.flashButton.addTarget(self, action: #selector(flashButtonTapped), for: .touchUpInside)
        v.shotButton.addTarget(self, action: #selector(shotButtonTapped), for: .touchUpInside)
        v.flipButton.addTarget(self, action: #selector(flipButtonTapped), for: .touchUpInside)
        sessionQueue.async { [unowned self] in
            self.setupCaptureSession()
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isPreviewSetup {
            setupPreview()
            isPreviewSetup = true
        }
        refreshFlashButton()
    }
    
    func setupPreview() {
        let videoLayer = AVCaptureVideoPreviewLayer(session: session)
        videoLayer.frame = v.previewViewContainer.bounds
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        v.previewViewContainer.layer.addSublayer(videoLayer)
        let tapRecognizer = UITapGestureRecognizer(target: self, action:#selector(focusTapped(_:)))
        tapRecognizer.delegate = self
        v.previewViewContainer.addGestureRecognizer(tapRecognizer)
    }
    
    private func setupCaptureSession() {
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.photo
        let cameraPosition: AVCaptureDevice.Position = self.configuration.usesFrontCamera ? .front : .back
        let aDevice = deviceForPosition(cameraPosition)
        if let d = aDevice {
            videoInput = try? AVCaptureDeviceInput(device: d)
        }
        if let videoInput = videoInput {
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            }
            if session.canAddOutput(imageOutput) {
                session.addOutput(imageOutput)
            }
        }
        session.commitConfiguration()
    }
    
    @objc
    func focusTapped(_ recognizer: UITapGestureRecognizer) {
        doAfterPermissionCheck { [weak self] in
            self?.focus(recognizer: recognizer)
        }
    }
    
    func focus(recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: v.previewViewContainer)
        let viewsize = v.previewViewContainer.bounds.size
        let newPoint = CGPoint(x:point.x/viewsize.width, y:point.y/viewsize.height)
        setFocusPointOnDevice(device: device!, point: newPoint)
        focusView.center = point
        configureFocusView(focusView)
        v.addSubview(focusView)
        animateFocusView(focusView)
    }
    
    func startCamera() {
        if !session.isRunning {
            sessionQueue.async { [unowned self] in
                // Re-apply session preset
                self.session.sessionPreset = AVCaptureSession.Preset.photo
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                switch status {
                case .notDetermined, .restricted, .denied:
                    self.session.stopRunning()
                case .authorized:
                    self.session.startRunning()
                }
            }
        }
    }
    
    func stopCamera() {
        if session.isRunning {
            sessionQueue.async { [unowned self] in
                self.session.stopRunning()
            }
        }
    }
    
    @objc
    func flipButtonTapped() {
        doAfterPermissionCheck { [weak self] in
            self?.flip()
        }
    }
    
    func flip() {
        sessionQueue.async { [unowned self] in
            self.session.resetInputs()
            self.videoInput = flippedDeviceInputForInput(self.videoInput)
            if self.session.canAddInput(self.videoInput) {
                self.session.addInput(self.videoInput)
            }
            DispatchQueue.main.async {
                self.refreshFlashButton()
            }
        }
    }

    @objc
    func shotButtonTapped() {
        doAfterPermissionCheck { [weak self] in
            self?.shoot()
        }
    }
    
    func shoot() {
        // Prevent from tapping multiple times in a row
        // causing a crash
        v.shotButton.isEnabled = false
        
        DispatchQueue.global(qos: .default).async {
            let videoConnection = self.imageOutput.connection(with: AVMediaType.video)
            let orientation: UIDeviceOrientation = UIDevice.current.orientation
            switch orientation {
            case .portrait:
                videoConnection?.videoOrientation = .portrait
            case .portraitUpsideDown:
                videoConnection?.videoOrientation = .portraitUpsideDown
            case .landscapeRight:
                videoConnection?.videoOrientation = .landscapeLeft
            case .landscapeLeft:
                videoConnection?.videoOrientation = .landscapeRight
            default:
                videoConnection?.videoOrientation = .portrait
            }
            
            self.imageOutput.captureStillImageAsynchronously(from: videoConnection!) { buffer, _ in
                self.session.stopRunning()
                let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer!)
                if var image = UIImage(data: data!) {
                    
                    // Crop the image if the output needs to be square.
                    if self.configuration.onlySquareImagesFromCamera {
                        image = self.cropImageToSquare(image)
                    }
                    
                    // Flip image if taken form the front camera.
                    if let device = self.device, let cgImg = image.cgImage, device.position == .front {
                        image = self.flipImage(image: image)
                    }
                    
                    DispatchQueue.main.async {
                        self.didCapturePhoto?(image)
                    }
                }
            }
        }
    }
    
    func cropImageToSquare(_ image: UIImage) -> UIImage {
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        var imageWidth = image.size.width
        var imageHeight = image.size.height
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            // Swap width and height if orientation is landscape
            imageWidth = image.size.height
            imageHeight = image.size.width
        default:
            break
        }
        
        // The center coordinate along Y axis
        let rcy = imageHeight * 0.5
        let rect = CGRect(x: rcy - imageWidth * 0.5, y: 0, width: imageWidth, height: imageWidth)
        let imageRef = image.cgImage?.cropping(to: rect)
        return UIImage(cgImage: imageRef!, scale: 1.0, orientation: image.imageOrientation)
    }
    
    // Used when image is taken from the front camera.
    func flipImage(image: UIImage!) -> UIImage! {
        let imageSize: CGSize = image.size
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 1.0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.rotate(by: CGFloat(Double.pi/2.0))
        ctx.translateBy(x: 0, y: -imageSize.width)
        ctx.scaleBy(x: imageSize.height/imageSize.width, y: imageSize.width/imageSize.height)
        ctx.draw(image.cgImage!, in: CGRect(x:0.0,
                                            y:0.0,
                                            width:imageSize.width,
                                            height:imageSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @objc
    func flashButtonTapped() {
        device?.tryToggleFlash()
        refreshFlashButton()
    }
    
    func refreshFlashButton() {
        if let device = device {
            v.flashButton.setImage(flashImage(forAVCaptureFlashMode:device.flashMode), for: .normal)
            v.flashButton.isHidden = !device.hasFlash
        }
    }

    func flashImage(forAVCaptureFlashMode: AVCaptureDevice.FlashMode) -> UIImage {
        switch forAVCaptureFlashMode {
        case .on: return flashOnImage!
        case .off: return flashOffImage!
        default: return flashOffImage!
        }
    }
}

class YPPermissionDeniedPopup {
    
    static func popup(cancelBlock: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: fsLocalized("YPImagePickerPermissionDeniedPopupTitle"),
                                      message: fsLocalized("YPImagePickerPermissionDeniedPopupMessage"),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: fsLocalized("YPImagePickerPermissionDeniedPopupCancel"),
                                      style: UIAlertActionStyle.cancel,
                                      handler: { _ in
                                        cancelBlock()
        }))
        alert.addAction(UIAlertAction(title: fsLocalized("YPImagePickerPermissionDeniedPopupGrantPermission"),
                                      style: .default,
                                      handler: { _ in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
            } else {
                UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
            }
        }))
        return alert
    }
}

extension FSCameraVC: PermissionCheckable {
    
    func checkPermission() {
        checkPermissionToAccessVideo { _ in }
    }
    
    func doAfterPermissionCheck(block:@escaping () -> Void) {
        checkPermissionToAccessVideo { hasPermission in
            if hasPermission {
                block()
            }
        }
    }
    
    // Async beacause will prompt permission if .notDetermined
    // and ask custom popup if denied.
    func checkPermissionToAccessVideo(block: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            block(true)
        case .restricted, .denied:
            let alert = YPPermissionDeniedPopup.popup(cancelBlock: {
                block(false)
            })
            present(alert, animated: true, completion: nil)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                DispatchQueue.main.async {
                    block(granted)
                }
            })
        }
    }
}
