//
//  AgendasObj.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 11/12/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class AgendaModel: BaseModel {
    var headAgenda: AgendasObj?  { return self[#function] as? AgendasObj; }
}

class AgendaObj: BaseModel {

    var title: String? { return self[#function] as? String; }
    var sender: String? { return self[#function] as? String; }
    var receiver: String? { return self[#function] as? String; }
    var copyTo: String? { return self[#function] as? String; }
    var venue: String? { return self[#function] as? String; }
    var start: String? { return self[#function] as? String; }
    var end: String? { return self[#function] as? String; }
    var file: String? { return self[#function] as? String; }
    
    var startDate: Date? {
        guard let s = start else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return formatter.date(from: s)
    }
    
    var endDate: Date? {
        guard let e = end else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return formatter.date(from: e)
    }
}


class AgendasObj: BaseModels {
    typealias Single = AgendaObj;
    override subscript (key: Int?)->Single? { return Single (super[key]); }
    override func get(id: Int?)->Single? { return Single(super.get(id: id)); }
    override func get(idx: Int?)->Single? { return Single(super.get(idx: idx)); }
    func change(id: Int?, changed: Change<Single?>?) { set(id: id, newValue: changed?(get(id: id))); }
    func change(idx: Int?, changed: Change<Single?>?) { set(idx: idx, newValue: changed?(get(idx: idx))); }
}
