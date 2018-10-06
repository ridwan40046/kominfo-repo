//
//  UIView+Animate.swift
//  LearnFlux
//
//  Created by Martin Tjandra on 9/25/17.
//  Copyright © 2017 Martin Darma Kusuma Tjandra. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    static func animate (withDuration: TimeInterval, delay: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: withDuration, delay: delay, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: animations, completion: completion);
    }
    
    func animateShake (withDuration: TimeInterval = 0.03, repeatCount: Float = 4) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = withDuration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
    
    func animateJump (withDuration: TimeInterval = 0.05, scaledBy: CGFloat = 1.3) {
        let curTransform = self.transform;
        UIView.animate(withDuration: withDuration, delay: 0, options: [.autoreverse], animations: {
            self.transform = CGAffineTransform.init(scaleX: scaledBy, y: scaledBy);
        }) { (done) in
            self.transform = curTransform;
        }
    }
}
