//
//  ListObj.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/11/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class ListObj: BaseModel {
    
    var letterCode : String? { return self[#function] as? String; }
    var letterNumber : String? { return self[#function] as? String; }
    var letterSubject : String? { return self[#function] as? String; }
    var letterType : String? { return self[#function] as? String; }
    var letterCharacter : String? { return self[#function] as? String; }
    var file : String? { return self[#function] as? String; }
    var sender : String? { return self[#function] as? String; }
    var postedAt : String? { return self[#function] as? String; }
    var receiver : String? { return self[#function] as? String; }
    var isDisposition : Bool? { return self[#function] as? Bool; }
    var isActionable : Bool? { return self[#function] as? Bool; }
    var letterStatus : String? { return self[#function] as? String; }
    
}

class ListsObj : BaseModels {
    
    typealias Single = ListObj;
    override subscript (key: Int?)->Single? { return Single (super[key]); }
    override func get(id: Int?)->Single? { return Single(super.get(id: id)); }
    override func get(idx: Int?)->Single? { return Single(super.get(idx: idx)); }
    func change(id: Int?, changed: Change<Single?>?) { set(id: id, newValue: changed?(get(id: id))); }
    func change(idx: Int?, changed: Change<Single?>?) { set(idx: idx, newValue: changed?(get(idx: idx))); }
    
}
