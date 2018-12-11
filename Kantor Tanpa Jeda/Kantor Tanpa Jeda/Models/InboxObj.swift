//
//  InboxObj.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/11/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class InboxObj: BaseModel {
    
    var inboxes: InboxesObj? { return InboxesObj(self[#function.snake], parent: self)}
}

class InboxesObj: BaseModel {
    
    var list: ListsObj? { return ListsObj(self[#function.snake], parent: self)}
    var meta: MetaObj? { return MetaObj(self[#function.snake], parent: self)}
}
