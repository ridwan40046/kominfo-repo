//
//  CGFloat+Stars.swift
//  Choose My Story
//
//  Created by Martin Tjandra on 03/07/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    var stars: String {
        var ratingString = self.floored.int.repeat(string: "");
        let decimals = self.decimals;
        if decimals < 0.33 { ratingString += ""; }
        else if decimals < 0.67 { ratingString += "" }
        else { ratingString += ""; }
        ratingString += (5 - ratingString.count).repeat(string: "");
        return ratingString;
    }
    
    var color: UIColor {
        return UIColor.init(red: self, green: self, blue: self, alpha: 1);
    }
}
