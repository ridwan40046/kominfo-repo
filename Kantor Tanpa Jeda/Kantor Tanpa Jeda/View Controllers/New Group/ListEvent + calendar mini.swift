//
//  ListEvent + calendar mini.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 25/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
extension ListEventVc {
    func setCalendarMini(){
        let widthScreen = UIScreen.main.bounds.width - 16 //left:8, right:8
        
        let labelWidth = widthScreen / 7
        let labelHeight: CGFloat = self.miniCalView.height - 2
        
        let frameR = CGRect(x: 0, y: 0, width: widthScreen + 16, height: labelHeight + 2)
        let viewR = UIView(frame: frameR)
        let idx = date!.dayOfWeek - 1
        let indexDay = idx == 0 ? 7 : idx
        viewR.backgroundColor = .white
        
        let centerIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        centerIndicator.backgroundColor = .orangeCalendar
        centerIndicator.makeRoundedRect(withCornerRadius: 10)
    
        viewR.addSubview(centerIndicator)
        
        for i in 0..<7 {
            let dt = Calendar.current.date(byAdding: DateComponents(day: (i+1) - indexDay), to: date!)
            let tgl = Calendar.current.component(.day, from: dt!)
            let fr = CGRect(x: (CGFloat(i)*labelWidth) + 8, y: 1, width: labelWidth, height: labelHeight)
            let label = UILabel(frame: fr)
            label.text = "\(tgl)"
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 0.6))
            label.textAlignment = .center
            if i == 6 {
                label.textColor = .red
            }
            
            viewR.addSubview(label)
            if i == indexDay - 1 {
                centerIndicator.center = label.center
                label.textColor = .white
            }
        }
        self.miniCalView.addSubview(viewR)
    }
}
