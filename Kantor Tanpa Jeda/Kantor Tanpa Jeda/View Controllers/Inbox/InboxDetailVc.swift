//
//  InboxDetailVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 13/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class InboxDetailVc: BaseVc , UIDocumentInteractionControllerDelegate{
    @IBOutlet weak var tblView: UITableView!
    var jenisSurat : String?;
    var nomorSurat : String?;
    var tanggalSurat: String?;
    var dari: String?;
    var sifat: String?;
    var perihal: String?;
    var file: String?;
    var isActionable: Bool?
    var isDisposition: Bool?
    
    func show(currentVc: UIViewController, letterType: String?,letterNumber: String?,letterDate: String?,sender: String?,letterCharacter: String?,letterSubject: String?, file: String?,  isActionable: Bool?, isDisposition: Bool?){
        self.jenisSurat = letterType;
        self.nomorSurat = letterNumber;
        self.tanggalSurat = letterDate;
        self.dari = sender;
        self.sifat = letterCharacter;
        self.perihal = letterSubject;
        self.file = file;
        self.isDisposition = isDisposition;
        self.isActionable = isActionable;
        currentVc.navigationController?.pushViewController(self, animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLaporan.makeRoundedRect(withCornerRadius: 5)
        btnDisposisi.makeRoundedRect(withCornerRadius: 5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    
    @IBOutlet weak var btnDisposisi: UIButton!
    @IBOutlet weak var btnLaporan: UIButton!
    
    @IBAction func disposisiTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "DisposisiVc") as? DisposisiVc
        if sender.tag == 101 {
            vc?.show(currentVc: self, isMessageShown: true)
        }
        else {
            vc?.show(currentVc: self, isMessageShown: false)
        }
    }
    
    @IBAction func laporanTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "LaporanVc") as? LaporanVc
        vc?.show(currentVc: self)
    }
    
    @IBAction func downloadTapped(_ sender: UIButton){
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentsURL.appendingPathComponent((self.file)!)
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Util.showIndicatorDarkOverlay(self.view, message: " ")
        if let url = URL(string: self.file ?? "") {
            Alamofire.download(
                url,
                method: .get,
                encoding: JSONEncoding.default,
                headers: nil,
                to: destination).downloadProgress(closure: { (progress) in
                    print((String)(progress.fractionCompleted))
                }).response(completionHandler: { (DefaultDownloadResponse) in
                    Util.stopIndicator(self.view)
                    print("DOWNLOAD COMPLETED")
                    let manager = FileManager.default
                    if manager.fileExists(atPath: fileUrl.path){
                        print("FILE / DIRECTORY EXIST")
                        let documentController = UIDocumentInteractionController.init(url: fileUrl)
                        documentController.delegate = self
                        documentController.presentPreview(animated: true)
                    }
                    else {
                        print("FILE / DIRECTORY NOT EXIST")
                    }
                })
        }
    }
    
    func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        print("WILL BEGIN SENDING TO APPLICATION")
    }
    
    func documentInteractionControllerWillBeginPreview(_ controller: UIDocumentInteractionController) {
        print("WILL BEGIN PREVIEW")
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        print("jsja")
        return self.navigationController!;
    }
}

extension InboxDetailVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1:if isDisposition == true { return 1} else { return 0}
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  self.tableView(tableView, cellForRowAt: indexPath).height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.cell("header")!
            cell.View(666).makeRoundedRect(withCornerRadius: 10)
            let jenis = cell.label(1)
            jenis?.text = self.jenisSurat
            let nomorSurat = cell.label(2)
            nomorSurat?.text = self.nomorSurat
            let tanggalSurat = cell.label(3)
            tanggalSurat?.text = self.tanggalSurat?.convertDateWithHour()
            let sender = cell.label(4)
            sender?.text = self.dari
            let sifat = cell.label(5)
            sifat?.text = self.sifat
            let perihal = cell.label(6)
            perihal?.text = self.perihal
            let file = cell.label(7)
            file?.text = self.file
            return cell
        case (1, 0):
            let cell = tableView.cell("message")!
            let judul = cell.Label(1)
            judul.textColor = UIColor.blue
            judul.text = "Disposisi"
            
            let tanggal = cell.Label(2)
            tanggal.textColor = UIColor.blue
            
            let view = cell.View(666)
            view.makeRoundedRect(withCornerRadius: 10)
            
            let btnDisposisi = cell.Button(101)
            btnDisposisi.makeRoundedRect(withCornerRadius: 5)
            
            let btnLaporan = cell.Button(102)
            btnLaporan.makeRoundedRect(withCornerRadius: 5)
            return cell
//        case (2, 0):
//            let cell = tableView.cell("message")!
//            let judul = cell.Label(1)
//            judul.textColor = UIColor.green
//            judul.text = "Komentar"
//
//            let tanggal = cell.Label(2)
//            tanggal.textColor = UIColor.green
//
//            let view = cell.View(666)
//            view.makeRoundedRect(withCornerRadius: 10)
//
//            let btnDisposisi = cell.Button(101)
//            btnDisposisi.makeRoundedRect(withCornerRadius: 5)
//
//            let btnLaporan = cell.Button(102)
//            btnLaporan.makeRoundedRect(withCornerRadius: 5)
//            return cell
//
//        case (3, 0):
//            let cell = tableView.cell("message")!
//            let judul = cell.Label(1)
//            judul.textColor = UIColor.red
//            judul.text = "Laporan"
//
//            let tanggal = cell.Label(2)
//            tanggal.textColor = UIColor.red
//
//            let view = cell.View(666)
//            view.makeRoundedRect(withCornerRadius: 10)
//
//            let btnDisposisi = cell.Button(101)
//            btnDisposisi.makeRoundedRect(withCornerRadius: 5)
//
//            let btnLaporan = cell.Button(102)
//            btnLaporan.makeRoundedRect(withCornerRadius: 5)
//            return cell
        case (_, 1):
            let cell = tableView.cell("separator")!
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
