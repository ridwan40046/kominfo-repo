//
//  Singleton+OAuth.swift
//  Family Tree
//
//  Created by Martin Tjandra on 2/5/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension Singleton {
    
    var oauth: OAuthObj? {
        get { return OAuthObj(json: loadCollection(key: #function.snake)); }
        set { saveCollection(key: #function.snake, collection: newValue?.rawData); }
    }
}
