//
//  UIColor+Constants.swift
//  LearnFlux
//
//  Created by Martin Tjandra on 9/28/17.
//  Copyright © 2017 Martin Darma Kusuma Tjandra. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /** The color of a tooltip */
    static var yellowPale : UIColor { return UIColor.init(red: 1, green: 1, blue: 202.0/255.0, alpha: 1); }
    static var greenButton : UIColor { return UIColor.init(red: 124.0/255.0, green: 191.0/255.0, blue: 49.0/255.0, alpha: 1); }
    static var redTabBar : UIColor { return UIColor.init(red: 214.0/255.0, green: 86.0/255.0, blue: 121.0/255.0, alpha: 1); }
    static var blueButton : UIColor { return UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1); }
    
    static func white(opacity: CGFloat) -> UIColor { return UIColor.init(red: 1, green: 1, blue: 1, alpha: opacity); }
}
