//
//  UIString+Date.swift
//  UBM
//
//  Created by Ridwan Surya Putra on 8/8/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
extension String {
    func convertDateWithHour() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: self){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let day = dateFormatter.string(from: date).capitalized
            
            let hasil = "\(day), \(dateFormatterPrint.string(from: date))"
            print(dateFormatterPrint.string(from: date))
            return hasil
        }
        else {
            print("There was an error decoding the string")
            return "-"
        }
    }
    func convertDateWithHourToDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd"
        
        if let date = dateFormatterGet.date(from: self){
            let hasil = "\(dateFormatterPrint.string(from: date))"
            print(dateFormatterPrint.string(from: date))
            return hasil
        }
        else {
            print("There was an error decoding the string")
            return "-"
        }
    }
    func convertDateWithHourToMonth() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM"
        
        if let date = dateFormatterGet.date(from: self){
            let hasil = "\(dateFormatterPrint.string(from: date))"
            print(dateFormatterPrint.string(from: date))
            return hasil
        }
        else {
            print("There was an error decoding the string")
            return "-"
        }
    }
    func convertDateWithHourToYear() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: self){
            let hasil = "\(dateFormatterPrint.string(from: date))"
            print(dateFormatterPrint.string(from: date))
            return hasil
        }
        else {
            print("There was an error decoding the string")
            return "-"
        }
    }
    
    func convertDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: self){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let day = dateFormatter.string(from: date).capitalized
            
            let hasil = "\(day), \(dateFormatterPrint.string(from: date))"
            print(dateFormatterPrint.string(from: date))
            return hasil
        }
        else {
            print("There was an error decoding the string")
            return "-"
        }
    }
}
