//
//  String+HTMLEntities.swift
//  toiletfeedback
//
//  Created by Martin Tjandra on 7/12/17.
//  Copyright © 2017 idesolusi. All rights reserved.
//

import Foundation

extension String {
    
    var escaped : String {
        return self.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? self;
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
