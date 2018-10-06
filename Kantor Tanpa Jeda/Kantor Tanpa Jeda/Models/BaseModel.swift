//
//  BaseModel.swift
//  iOPS
//
//  Created by Martin Tjandra on 8/30/16.
//  Copyright © 2016 Martin Darma Kusuma Tjandra. All rights reserved.
//

import Foundation

class BaseModel : JsonObject {
    
    var id : Int? { return self[#function] as? Int }
    
    var parentLookup : BaseModel? {
        var cur = self.parent;
        while cur != nil {
            if cur?.id != nil { return cur; }
            cur = cur?.parent;
        }
        return nil;
    }
    var parentLookupId : Int? { return parentLookup?.id; }
    
    subscript (key: String)->Any? {
        get {
            var d : Dict?
            if dict != nil { d = dict; } else
                if dict == nil && arr != nil { d = arr?[safe: 0]; } else
            { print ("\(type(of:self)) Model: No key \(key) exist"); return nil; }
            return d?[key];
        }
        set {
            var temp = dict ?? Dict();
            temp[key] = newValue;
            rawData = temp as AnyObject;
        }
    }
    
    func save (key: String? = nil) {
        var usedKey = key;
        if usedKey == nil { usedKey = String(describing: type(of: self)).snake; }
        print ("\n\nJSON SAVING to: \(usedKey!)");
        locker.store[usedKey!] = NSKeyedArchiver.archivedData(withRootObject: rawData!) as AnyObject?;
        locker.store.synchronize();
    }

    func load (key: String? = nil) {
        var usedKey = key;
        if usedKey == nil { usedKey = String(describing: type(of: self)).snake; }
        if let data = locker.store[usedKey!] as? Data {
            print ("\n\nJSON LOAD from: \(usedKey!)");
            rawData = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?;
        }
        else {
            print ("\n\nJSON LOAD from: \(usedKey!) attempt is failure because nil.")
        }
    }
    
    /*
    var createdAt : String? {
        get { if let d = self[(#function.snake)] as? String { return d; }
              else { print ("\(type(of:self)) Model: No key \(#function.snake) exist"); return nil; } }
        set { self[(#function.snake)] = newValue as AnyObject; }
    }
    var updatedAt : String? {
        get { if let d = self[(#function.snake)] as? String { return d; }
              else { print ("\(type(of:self)) Model: No key \(#function.snake) exist"); return nil; } }
        set { self[(#function.snake)] = newValue as AnyObject; }
    }*/
    
}

class BaseModels : JsonObject {
    
    subscript (key: Int?)->BaseModel? {
        get {
            guard let key = key else { return nil; }
            if (arr == nil || key >= arr!.count) { return nil; }
            else { return BaseModel(arr![safe: key] as AnyObject, parent: self.parent); }
        }
//        set {
//            guard let key = key, var arr = arr, let data = newValue?.dict else { return; }
//            arr[key] = data;
//            rawData = arr as Any;
//        }
    }
    
    func get(id: Int?)->BaseModel? {
        guard let id = id, let arr = arr else { return nil; }
        for dict in arr {
            if let curId = dict["id"] as? Int, curId == id {
                return BaseModel(dict, parent: self.parent);
            }
        }
        return nil;
    }
    
    func set(id: Int?, newValue: BaseModel?) {
        guard let id = id, var arr = arr, let data = newValue?.dict else { return; }
        for (idx, dict) in arr.enumerated() {
            if let curId = dict["id"] as? Int, curId == id {
                arr[idx] = data;
            }
        }
        rawData = arr as Any;
    }
    
    func get(idx: Int?) -> BaseModel? {
        guard let idx = idx else { return nil; }
        if (arr == nil || idx >= arr!.count) { return nil; }
        else { return BaseModel(arr![safe: idx] as AnyObject, parent: self.parent); }
    }
    
    func set(idx: Int?, newValue: BaseModel?) {
        guard let idx = idx, var arr = arr, idx < arr.count, let data = newValue?.dict else { return; }
        arr[idx] = data;
        rawData = arr as Any;
    }
    
    func changeBase(idx: Int?, changed: Change<BaseModel?>?) {
        set(idx: idx, newValue: changed?(get(idx: idx)));
    }
    func changeBase(id: Int?, changed: Change<BaseModel?>?) {
        set(id: id, newValue: changed?(get(id: id)));
    }

    func remove(id: Int?) {
        guard let id = id, let arr = arr else { return; }
        for (idx, el) in arr.enumerated() {
            if let targetId = el["id"] as? Int, targetId == id { self.remove(idx: idx); return; }
        }
    }
    
    func remove(idx: Int?) {
        guard let idx = idx, var arr = arr else { return; }
        arr.remove(at: idx);
        self.rawData = arr as Any;
    }
//    subscript (key: String?)->BaseModel? {
//        get {
//            guard let key = key else { return nil; }
//            if arr == nil { return nil; }
//            let idx = arr!.index { el in
//                guard let id = el["id"] as? String else { return false; }
//                return id == key;
//            };
//            if idx == nil { return nil; }
//            else { return BaseModel (arr![safe: idx!] as AnyObject, parent: self.parent); }
//        }
//    }
    
    func reversed() -> BaseModels? {
        guard let arr = arr else { return nil; }
        return BaseModels (arr.reversed() as AnyObject, parent: self.parent);
    }
    
    func reverse() {
        guard let arr = arr else { return; }
        rawData = arr.reversed() as AnyObject;
    }
    
    /** does not check for duplicate id */
    func append (newElement: AnyObject?) {
        if let obj = newElement as? Dict { appendDict(newElement: obj); }
        else if let obj = newElement as? Arr { appendArr(newElement: obj); }
        else if let obj = newElement as? BaseModel { appendDict(newElement: obj.dict); }
        else if let obj = newElement as? BaseModels { appendArr(newElement: obj.arr); }
    }
    
    /** does not check for duplicate id */
    func appendDict (newElement: Dict?, primaryKey: String = "id") {
        guard let newElement = newElement else { return; }
        var result = arr ?? Arr();
        result.append (newElement);
        rawData = result as AnyObject;
    }

    /** does not check for duplicate id */
    func appendArr (newElement: Arr?) {
        guard let newElement = newElement else { return; }
        var result = arr ?? Arr();
        for el in newElement { result.append(el); }
        rawData = result as AnyObject;
    }
    
    func merge (newElement: AnyObject?) {
        if let obj = newElement as? Dict { mergeDict(newElement: obj); }
        else if let obj = newElement as? Arr { mergeArr(newElement: obj); }
        else if let obj = newElement as? BaseModel { mergeDict(newElement: obj.dict); }
        else if let obj = newElement as? BaseModels { mergeArr(newElement: obj.arr); }
    }
    
    private func mergeDict (newElement: Dict?, primaryKey: String = "id") {
        let new = BaseModel(json: newElement as AnyObject, parent: self.parent);
        if new?[primaryKey] == nil { return; }
        var isExist = false;
        if let dict = dict {
            for _old in dict {
                let old = BaseModel(json: _old as AnyObject);
                if (old?[primaryKey] as? String == new?[primaryKey] as? String) { isExist = true; break; }
            }
        }
        if (!isExist) { appendDict(newElement: newElement); }
    }
    
    private func mergeArr (newElement: Arr?) {
        for new in newElement! { mergeDict (newElement: new); }
    }

    var count : Int {
        get { if (arr == nil) { return 0; } else { return arr!.count; } }
    }
    
    func filter (key: String, value: String, searchSubstring: Bool = false, invertResult: Bool = false)->BaseModels? {
        if (arr == nil) { return nil; }
        else {
            let filteredData = arr?.filter() { el in
                if let comp = el[key] as? String {
                    if (searchSubstring) {
                        if comp.lowercased().contains(value.lowercased())
                        { return true ^ invertResult; } else { return false ^ invertResult; }
                    }
                    else if (!searchSubstring) {
                        if comp.lowercased() == value.lowercased()
                        { return true ^ invertResult; } else { return false ^ invertResult; }
                    }
                }
                return false;
            }
            return BaseModels(json: filteredData as AnyObject?, parent: self.parent);
        }
        
    }
    
    func filter (by string: String?) -> BaseModels? {
        guard let arr = arr, let string = string else { return nil; }
        var result = Arr();
        for el in arr {
            for value in el.values {
                if let valueStr = value as? String, valueStr.contains(string) {
                    result.append(el); break;
                }
            }
        }
        return BaseModels(json: result as AnyObject, parent: self.parent);
    }
    
    func contains (id: String?) -> Bool? {
        guard let arr = arr, let id = id else { return nil; }
        for el in arr {
            guard let value = el["id"] as? String else { continue; }
            if value == id { return true; }
        }
        return false;
    }
    
    /** equals to "upsert" */
    func merge (obj: BaseModels?, basedOnKey key: String = "id") {
        guard let _arr = obj?.arr else { return; }
        if (arr == nil && _arr.count > 0) { arr = []; }
        for el in _arr {
            var found = false;
            for base in arr! { if el[key] as? String == base[key] as? String { found = true; } }
            if !found { arr?.append(el); }
        }
    }
    
    
    var parentLookup : BaseModel? {
        var cur = self.parent;
        while cur != nil {
            if cur?.id != nil { return cur; }
            cur = cur?.parent;
        }
        return nil;
    }
    var parentLookupId : Int? { return parentLookup?.id; }

    var smallestId: Int? {
        var result : Int? = nil;
        for i in 0..<count {
            if result == nil { result = self[i]?.id; }
            else if let _result = result, let id = self[i]?.id, _result >= id { result = id; }
        }
        return result;
    }
    
    var biggestId: Int? {
        var result : Int? = nil;
        for i in 0..<count {
            if result == nil { result = self[i]?.id; }
            else if let _result = result, let id = self[i]?.id, _result <= id { result = id; }
        }
        return result;
    }
    
}

