//
//  EventsObj.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 11/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
class EventObj {
    var start: Date
    var end: Date
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String, start: Date, end: Date) {
        self.title = title
        self.subtitle = subtitle
        self.start = start
        self.end = end
    }
}
