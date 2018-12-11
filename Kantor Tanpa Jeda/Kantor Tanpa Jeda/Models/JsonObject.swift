//
//  Response.swift
//  toiletfeedback
//
//  Created by Martin Tjandra on 1/13/17.
//  Copyright © 2017 idesolusi. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class JsonObject : CustomStringConvertible, CustomDebugStringConvertible {
    
    var oriData : Any?;
    var rawData : Any?;// { didSet { if needUnwrap(data: rawData) { rawData = unwrapResponse(data: rawData); } } }
    var xmlData : XMLIndexer?;
    var xmlRaw : String?;
    var errorHttp : Error?;
    private var errorInfo : String?;
    var response : HTTPURLResponse?;
    var responseStatus : ResponseStatus?;
    var parent : BaseModel?;
    var error : ErrorObj? { return ErrorObj(self.dict?[#function.snake]); }

    init?(json: Any?, response: HTTPURLResponse? = nil, errorInfo: String? = nil, parent: BaseModel? = nil) {
        if json == nil && response == nil && errorInfo == nil { return nil; }
        
        if let data = json as? Dict { rawData = data as AnyObject; }
        else if let data = json as? Arr { rawData = data as AnyObject; }
        else if let data = json as? ArrString { rawData = data as AnyObject; }
        else if let sjson = json as? String {
            if let data = sjson.jsonToDict { rawData = data as AnyObject; }
            else if let data = sjson.jsonToArr { rawData = data as AnyObject; }
        }

        self.response = response;
        self.errorInfo = errorInfo;
        self.parent = parent;
    }
    
    init?(obj: JsonObject?, parent: BaseModel? = nil) {
        guard let obj = obj else { return nil; }
        self.oriData = obj.oriData;
        self.rawData = obj.rawData;
        self.response = obj.response;
        self.errorInfo = obj.errorInfo;
        self.errorHttp = obj.errorHttp;
        self.responseStatus = obj.responseStatus;
        self.parent = parent ?? obj.parent;
    }
    
    init() { rawData = [:] as AnyObject; }
    
    /** The ultimate initializer. Accept everything. */
    init?(_ any: Any?, response: HTTPURLResponse? = nil, errorInfo: String? = nil, parent: BaseModel? = nil) {
        if let obj = any as? JsonObject {
            self.oriData = obj.oriData;
            self.rawData = obj.rawData;
            self.response = obj.response;
            self.errorInfo = obj.errorInfo;
            self.errorHttp = obj.errorHttp;
            self.responseStatus = obj.responseStatus;
            self.parent = parent ?? obj.parent;
        }
        else {
            let json = any;
            if json == nil && response == nil && errorInfo == nil { return nil; }
            
            if let data = json as? Dict { rawData = data as AnyObject; }
            else if let data = json as? Arr { rawData = data as AnyObject; }
            else if let data = json as? ArrString { rawData = data as AnyObject; }
            else if let sjson = json as? String {
                if let data = sjson.jsonToDict { rawData = data as AnyObject; }
                else if let data = sjson.jsonToArr { rawData = data as AnyObject; }
            }
            
            self.response = response;
            self.errorInfo = errorInfo;
            self.parent = parent;
        }
    }
    
    init (data: Data?, response: URLResponse?, error: Error?, param: DictString? = nil) {
        
        self.errorHttp = error as NSError?;
        self.errorInfo = self.errorHttp?.localizedDescription;
        guard let res = response as? HTTPURLResponse else { responseStatus = .noContent; return; }
        self.response = res;
        if data == nil { return; }

        do {
            if res.statusCode == 404 {
                responseStatus = ResponseStatus.notFound404;
                errorInfo = "Error 404 Not Found: The resources this app trying to access at \(res.url!) cannot be found.";
                rawData = nil;
                return;
            }
            
            oriData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as AnyObject;
            rawData = oriData;
            
            if let dict = rawData as? Dict, let data = dict["Data"] { rawData = data; }
            if let dict = oriData as? Dict, let message = dict["Message"] as? String {
                self.errorInfo = message;
            }
            
            if (res.statusCode == 401) {
                responseStatus = ResponseStatus.unauthorized401;
                errorInfo = "Token Error: Error occured while trying to authenticated with the server.";
            }
            else if (error != nil) {
                responseStatus = ResponseStatus.other;
                errorInfo = "Error \(res.statusCode) in \(error!._domain): \(error?.localizedDescription ?? "nil")";
            }
            else if (dict != nil && dict!["error_message"] != nil) {
                responseStatus = ResponseStatus.custom;
                if let err = dict?["error_message"] as? String {
                    errorInfo = "Error: \(err)";
                }
                else if let err = dict?["error_message"] as? Dict {
                    if let errInfo = err["errorInfo"] as? [Any] {
                        errorInfo = errInfo[2] as? String;
                    }
                    else {
                        errorInfo = "\(err)";
                    }
                }
                else {
                    errorInfo = "Error: nil";
                }
            }
            else if (res.statusCode >= 200 && res.statusCode < 300) {
                responseStatus = ResponseStatus.success200;
//                errorInfo = nil;
            }
            else {
                responseStatus = ResponseStatus.other;
                errorInfo = "Unknown Error";
            }
        } catch _ as NSError {
            if (res.statusCode == 405) {
                responseStatus = ResponseStatus.methodNotAllowed405;
                errorInfo = "Error 405 Method Not Allowed: The method the app want to use to access resource \(res.url!) is invalid.";
            }
            else {
                responseStatus = ResponseStatus.cannotParseJSON;
                let body = String.init(data: data!, encoding: .utf8);
                xmlRaw = body;
                xmlData = SWXMLHash.parse(body!);
                
                errorInfo = "The app has problem when communicating with server. Please contact administrator.";
//                let body = String.init(data: data!, encoding: .utf8);
                print ("Cannot parse JSON, HTTP status code: \(res.statusCode)"); //", body = \n\(body ?? "nil")");
                print ("RAW DATA: \(data?.string ?? "nil")");
            }
        }
    }
    
    init (alamofireResponse response: Alamofire.DataResponse<Any>?) {

        if let json = response?.result.value {
            let dataArr = json as? Arr;
            let dataDict = json as? Dict;
            if dataArr != nil || dataDict != nil { rawData = json as AnyObject; }
        }
        self.response = response?.response;
        self.errorHttp = response?.error;
    }
    
    func needUnwrap(data: AnyObject?) -> Bool {
        if let dict = data as? Dict, (dict["response"] as? Dict) != nil { return true; } else { return false; }
    }
    
    func unwrapResponse(data: AnyObject?) -> AnyObject? {
        if let dict = data as? Dict, let response = dict["response"] as? Dict {
            for key in dict.keys {
                if key != "response" {
                    if var _dict = dict[key] as? Dict {
                        _dict += response;
                        return _dict as AnyObject;
                    }
                    else if let _arr = dict[key] as? Arr {
                        return _arr as AnyObject;
                    }
                }
            }
            return response as AnyObject;
        }
        return data;
    }
    
    func copy (obj: JsonObject?, parent: BaseModel? = nil) {
        guard let obj = obj else { return; }
        self.rawData = obj.rawData;
        self.response = obj.response;
        self.errorInfo = obj.errorInfo;
        self.errorHttp = obj.errorHttp;
        self.responseStatus = obj.responseStatus;
        self.parent = parent ?? obj.parent;
    }
    
    func copyStatus (obj: JsonObject?) {
        guard let obj = obj else { return; }
        self.response = obj.response;
        self.errorInfo = obj.errorInfo;
        self.errorHttp = obj.errorHttp;
        self.responseStatus = obj.responseStatus;
    }
    
    func copyResult (obj: JsonObject?) {
        guard let obj = obj else { return; }
        copyStatus(obj: obj);
        self.rawData = obj.rawData;
    }
    
    var dict : Dict? {
        get { if let dict = rawData as? Dict {
            if let dictData = dict["data"] as? Dict { return dictData; } else { return dict; } }
        else { return nil; }
        }
        set { rawData = newValue as AnyObject?; }
    }
    
    var dictStr : DictString? {
        get { if let dict = rawData as? Dict {
            if let dictData = dict["data"] as? DictString { return dictData; } else { return dict as? DictString; } }
        else { return nil; }
        }
        set { rawData = newValue as AnyObject?; }
    }
    
    var arr : Arr? {
        get { if let arr = rawData as? Arr { return arr; } else { return nil; } }
        set { rawData = newValue as AnyObject?; }
    }
    
    var arrString : ArrString? {
        get { if let arrString = rawData as? ArrString { return arrString; } else { return nil; } }
        set { rawData = newValue as AnyObject?; }
    }

    var errorMessage : String? {
        if errorInfo != nil { return errorInfo; } else { return nil; }
        
//        if let error = ErrorObj(obj: self)?.details { return error; }
        var result : String?;
        if let dictForm = rawData as? Dict {
            if dictForm["message"] != nil, dictForm["hint"] != nil, dictForm["error"] != nil {
                result = "API issue.\(dictForm.summary)";
            }
            else {
                if let errorMessage = dictForm["error_message"] as? String {
                    result = errorMessage.trim();
                }
                else if let errorMessage = dictForm["error_message"] as? Dict,
                    let errorInfo = errorMessage["errorInfo"] as? [Any] {
                    result = "\n\(errorInfo[2])";
                }
                result = result?.trim();
            }
        }
        if result == nil, let msg = errorInfo { result? += "\n\(msg)"; }
        if result == nil, let msg = errorHttp?.localizedDescription { result? += "\n\(msg)"; }
        if result == "" { return nil; }
        return result?.trim();
    }
    
    func clear () { dict = nil; }
    
    var isSuccess : Bool {
        if OAuthObj(self)?.authorization?.apiToken != nil { return true; }
        if let status = status, status == "SUCCESS" { return true; }
        if errorInfo != nil { return false; }
        return true;

//        if errorMessage != nil { return false; }
//        if let statusCode = response?.statusCode, !(200...299 ~= statusCode) { return false; }
//        if status == "failed" { return false; }
//        return true;
    }
    
    var isPermissionDenied : Bool {
        return (response?.statusCode ?? -1) == 400;
    }
    
    var isAccessTokenExpired : Bool {
        return (response?.statusCode ?? -1) == 401;
    }
    
    var hasData : Bool {
        if (rawData as? Dict) != nil || (rawData as? Arr) != nil { return true; } else { return false; }
    }
    
    var className: String { return NSStringFromClass(type(of: self)) }
    
    var debugDescription: String {
        if let dict = dict { return ("Content of \(self.className): Dictionary \n\(dict)") }
        else if let arr = arr { return ("Content of \(self.className): Array \n\(arr)") }
        else if let rawData = rawData { return ("Content of \(self.className): AnyObject \n\(rawData)") }
        else { return ("Content of \(self.className): nil") }
    }
    
    var description: String { return debugDescription; }
    
    func printClassName () { print (String(describing: self)); }
    
}

extension JsonObject {
    
    var status: String? { return (self.oriData as? Dict)?[#function.capitalized] as? String; }
    var message: String? { return (self.oriData as? Dict)?[#function.capitalized] as? String; }
    
}


