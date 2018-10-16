//
//  String + Inisial.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 17/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
extension String {
    func getInisial() -> String {
        let inisials = self.split(separator: " ")
        var inisial = ""
        for i in 0..<inisials.count {
            var a = ""
            a = String (inisials[i])
            inisial += String (a[0])
        }
        return inisial
    }
}
