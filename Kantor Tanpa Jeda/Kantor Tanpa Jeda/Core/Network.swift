//
//  Network.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let net = Network.sharedInstance;

class Network {
    
    static let sharedInstance = Network();
    private init () {}
    
}

extension Network {
    
    enum Method : String { case post; case get; case put; case delete; }
    
    /** This is to generate necessary request consists of headers, url + query string, and body */
    internal func urlRequest (method: Alamofire.HTTPMethod = .get, url: String, param: Dict? = nil) -> URLRequest {
        //        var headers = [ "cache-control": "no-cache"]
        var headers = DictString();
        if param?["client_id"] == nil {
            headers["Authorization"] = "Bearer \(locker.oauth?.authorization?.apiToken ?? "")";
            print("INI HEADER AUTH: \(headers["Authorization"])")
            headers["Content-Type"] = "application/json";
            headers["Accept"] = "application/json";
        }
        else {
            headers["Content-Type"] = "application/x-www-form-urlencoded";
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = method.rawValue.uppercased();
        request.allHTTPHeaderFields = headers
        //        let paramString = param?.map({ return "\($0)=\($1)"; }).joined(separator: "&");
        //        request.httpBody = paramString?.data(using: String.Encoding.utf8) ?? Data();
        if let paramData = param?.jsonData { request.httpBody = paramData; }
        if url.contains("oauth") { print ("\nOAUTH REQUEST >>>>>>>"); } else { print ("\nNETWORK REQUEST >>>>>>>"); }
        print ("Url: \(url)");
        print ("Method: \(method.rawValue)");
        print ("Param: \(param?.summary ?? "nil")");
        print ("Header:\(headers.summary)\n")
        return request as URLRequest;
    }
    
    internal func printStatus (url: String, jsonData: JsonObject?, param: Dict?) {
        let code = "(\(jsonData?.response?.statusCode ?? -1))";
        if url.contains("oauth") { print ("\n<<<<<< OAUTH RESPONSE \(code)"); } else { print ("\n<<<<<< NETWORK RESPONSE \(code)"); }
        print ("Url: \(url)");
        if let msg = jsonData?.errorMessage { print ("ERROR MESSAGE: \(msg)"); }
        else if let d = jsonData?.response?.statusCode, !(200...299 ~= d) {
            if d == 500 {
                print ("ERROR: SERVER ERROR (500)");
                if let raw = jsonData?.xmlRaw, raw.contains(substring: "SQLSTATE") {
                    if raw.contains("</p>") {
                        let result1 = String(raw[raw.index(of: "SQLSTATE")!...]);
                        let result2 = String(result1[...result1.index(before: result1.index(of: "</p>")!)]);
                        print ("SQL ERROR: \(result2)");
                    }
                    else {
                        print ("SQL ERROR: \(raw)");
                    }
                }
                else if let raw = jsonData?.xmlRaw, raw.contains(substring: "Whoops") {
                    print ("LARAVEL ERROR: Whoops, looks like something went wrong.");
                }
                else {
                    let xmlErrorTable = jsonData?.xmlData?["html"]["body"]["div"][1]["div"]["table"];
                    let xmlErrorTitle = xmlErrorTable?["thead"]["tr"]["th"];
                    let xmlErrorSource = xmlErrorTable?["tbody"]["tr"][0]["td"]["span"];
                    
                    
                    let errorTitle = xmlErrorTitle?["h3"]["span"][1]["abbr"].element?.text ?? "nil";
                    let errorDescription = xmlErrorTitle?["p"].element?.text ?? "nil";
                    let firstError = xmlErrorSource?[0]["a"]["strong"].element?.text ??
                        xmlErrorSource?[4]["a"]["strong"].element?.text ?? "nil";
                    let firstErrorLine = xmlErrorSource?[0]["a"].element?.text ??
                        xmlErrorSource?[0]["a"].element?.text ?? "nil";
                    print ("LARAVEL ERROR: \(errorTitle)\n\(errorDescription)\nIn \(firstError) \(firstErrorLine)");
                }
            }
            else { print ("ERROR: UNHANDLED, NO DATA"); }
            print ("\nPOSTMAN BULK EDIT:\(param?.postmanBulkEdit ?? "nil")\n")
        }
        else if let d = jsonData?.arr { print ("Result array: \(d.summary)"); }
        else if let d = jsonData?.dict { print ("Result dict: \(d.summary)"); }
        else if let d = jsonData?.arrString { print ("Result array of String: \(d.summary)"); }
        else if let d = jsonData?.rawData { print ("Result data: \(d)"); }
        else { print ("Result data: empty"); }
        //        print ("FULL JSON: \(jsonData?.dict ?? [:])")
    }
    
    /** This is the very basic of network call. No response handler. */
    internal func requestNative (method: Alamofire.HTTPMethod = .get, url: String, param: Dict? = nil, callback: ModelReturn?) {
        let request = urlRequest(method: method, url: url, param: param);
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            Util.mainThread {
                let jsonData = JsonObject.init(data: data, response: response, error: error);
                self.printStatus(url: url, jsonData: jsonData, param: param);
                callback?(jsonData);
            }
        };
        dataTask.resume()
    }
    
    
    internal func requestAlamo (method: Alamofire.HTTPMethod = .get, url: String, param: Dict? = nil, callback: ModelReturn?) {
        var param = param;
        let request = urlRequest(method: method, url: url, param: param);
        let newParam = request.httpBody?.json;
        var encoding : ParameterEncoding!
        if param?["client_id"] != nil {
            encoding = URLEncoding()
        }
        else {
            encoding = JSONEncoding(options: .prettyPrinted);
            print(encoding)
        }
        Alamofire.request(request.url!.absoluteString,
                          method: method,
                          parameters: newParam ?? [:],
                          encoding: encoding,
                          headers: request.allHTTPHeaderFields)
            .response { result in
                //                let jsonData = JsonObject.init(alamofireResponse: response);
                let jsonData = JsonObject.init(data: result.data, response: result.response, error: result.error);
                self.printStatus(url: url, jsonData: jsonData, param: param);
                callback?(jsonData);
        }
        //        .responseJSON { response in
        //            let jsonData = JsonObject.init(alamofireResponse: response);
        //            self.printStatus(url: url, jsonData: jsonData);
        //            callback?(jsonData);
        //        }
    }
    
    internal func requestBase (method: Alamofire.HTTPMethod = .get, url: String, param: Dict? = nil, callback: ModelReturn?) {
        requestAlamo(method: method, url: url, param: param, callback: callback);
    }
    
    /** This is the handler of response of network call. */
    internal func requestHandler (method: Alamofire.HTTPMethod = .get, url: String, param: Dict? = nil, callback: ModelReturn?) {
        
        func retryAfterOAuth() {
            requestNative(method: method, url: url, param: param) { jsonData in
                if jsonData?.isAccessTokenExpired ?? false { toast ("Unresolved OAuth", color: .orange); }
                else if jsonData?.isSuccess ?? false { }
                else { toast(jsonData?.errorMessage ?? "Unknown error (\(jsonData?.response?.statusCode ?? 0))", color: UIColor.red); }
                callback?(jsonData);
            }
        }
        
        func retryWithOAuth(jsonData: JsonObject?) {
            newOAuth { oauthData in
                if oauthData?.isAccessTokenExpired ?? false { toast("OAuth failure", color: .red); callback?(jsonData); }
                else if oauthData?.isSuccess ?? false { retryAfterOAuth(); }
                else { toast(oauthData?.errorMessage ?? "OAuth error", color: UIColor.orange); callback?(jsonData); }
            }
        }
        
        func begin() {
            requestBase(method: method, url: url, param: param) { jsonData in
                if jsonData?.isAccessTokenExpired ?? false { retryWithOAuth(jsonData: jsonData); }
                else if jsonData?.isSuccess ?? false { callback?(jsonData); }
                else { toast(jsonData?.errorMessage ?? "Unknown error (\(jsonData?.response?.statusCode ?? 0))", color: .red); callback?(jsonData); }
            }
        }
        
        func beginWithOAuth() {
            newOAuth { oauthData in
                if oauthData?.isAccessTokenExpired ?? false { toast("OAuth failure", color: .red); callback?(oauthData); }
                else if oauthData?.isSuccess ?? false { retryAfterOAuth(); }
                else { toast(oauthData?.errorMessage ?? "OAuth error", color: UIColor.orange); callback?(oauthData); }
            }
        }
        
        begin();
//        beginWithOAuth();
        //        if locker.oauth?.expiresDate?.isExpired ?? true {
        //            newOAuth { response in
        //                if response?.isSuccess ?? false { begin(); }
        //                else { callback?(response); }
        //            }
        //        }
        //        else { begin(); }
    }
    
    /** This is the main call. Use this. */
    func request (method: Alamofire.HTTPMethod = .get, url: String?, param: Dict? = nil, callback: ModelReturn?) {
        guard let url = url else { callback?(nil); return; }
        if !networkIsReachable() {
            whistle("No Internet Connection");
            topViewController().view?.removeIndicator()
            return;
        }
        Util.showNetworkIndicator();
        requestHandler(method: method, url: url, param: param) { response in
            Util.hideNetworkIndicator();
            Util.mainThread { callback?(response); }
        }
    }
    
}
