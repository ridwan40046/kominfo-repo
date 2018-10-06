//
//  UIImage+Resize.swift
//  LearnFlux
//
//  Created by Martin Tjandra on 12/15/17.
//  Copyright © 2017 Martin Darma Kusuma Tjandra. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resize(_ maxWidth: CGFloat?, _ maxHeight: CGFloat?)->UIImage? {
        guard let maxWidth = maxWidth, let maxHeight = maxHeight else { return self; }
        return resize(targetSize: CGSize(width: maxWidth, height: maxHeight));
    }
    
    func resize(targetSize: CGSize?)->UIImage? {
        guard let targetSize = targetSize else { return self; }
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if (widthRatio > heightRatio) {
            newSize = CGSize.init(width: size.width * heightRatio, height: size.height * heightRatio)
        }
        else { newSize = CGSize.init(width: size.width * widthRatio, height: size.height * widthRatio) }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height);
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage;
    }
    
}
