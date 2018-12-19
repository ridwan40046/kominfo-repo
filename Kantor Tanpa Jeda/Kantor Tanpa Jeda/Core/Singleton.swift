//
//  Singleton.swift
//  Family Tree
//
//  Created by Martin Tjandra on 1/29/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation

let locker = Singleton.sharedInstance;

class Singleton {
    
    static let sharedInstance = Singleton();
    private init () {}
    
    var store = UserDefaults.standard;
    
}

extension Singleton {
    
    subscript (key: String)->Any? {
        get { return store[key]; }
        set { if newValue != nil { store[key] = newValue! as AnyObject; } }
    }
    
    func saveCollection (key: String?, collection: Any?) {
        if let json = collection, let _key = key {
            store[_key] = nil;
            store.synchronize();
            store[_key] = NSKeyedArchiver.archivedData(withRootObject: json) as AnyObject;
            store.synchronize();
        }
    }
    
    func loadCollection (key: String?) -> Any? {
        if let _key = key, let data = store[_key] as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as Any;
        }
        return nil;
    }
    
}

extension Singleton {
    
    func clear () {
        store.removePersistentDomain(forName: Bundle.main.bundleIdentifier!);
        store.synchronize();
    }
    
    var oauth : OAuthObj? {
        get { return OAuthObj (json: loadCollection(key: #function)); }
        set { saveCollection(key: #function, collection: newValue?.rawData); }
    }
    
}
