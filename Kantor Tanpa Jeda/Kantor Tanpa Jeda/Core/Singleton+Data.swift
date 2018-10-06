////
////  Singleton+Data.swift
////  Wedding Event
////
////  Created by Martin Tjandra on 20/07/18.
////  Copyright © 2018 idesolusiasia. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension Singleton {
//
//    var username: String? {
//        get { return store[#function] as? String; }
//        set { store[#function] = newValue as AnyObject }
//    }
//
//    var password: String? {
//        get { return store[#function] as? String; }
//        set { store[#function] = newValue as AnyObject }
//    }
//
//}
//
//extension Singleton {
//
//    var me: UserObj? {
//        get { return UserObj(json: loadCollection(key: #function.snake)); }
//        set { saveCollection(key: #function.snake, collection: newValue?.rawData); }
//    }
//
//    var events: EventsObj? {
//        get { return EventsObj(json: loadCollection(key: #function.snake)); }
//        set { saveCollection(key: #function.snake, collection: newValue?.rawData); }
//    }
//
//}
