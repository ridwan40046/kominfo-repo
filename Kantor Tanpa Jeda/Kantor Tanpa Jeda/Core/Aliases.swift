//
//  Aliases.swift
//  Family Tree
//
//  Created by Martin Tjandra on 1/29/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation

typealias ModelReturn = ((JsonObject?)->Void)

enum ResponseStatus {
    case success200
    case unauthorized401
    case notFound404
    case methodNotAllowed405
    case internalServerError500
    case badGateway502
    case serviceUnavailable503
    case requestTimeout504
    
    case noInternetConnection
    case cannotParseJSON
    case noContent
    case other
    case custom
}

var arrBulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
]
//enum SearchType: String { case event; case attendee}
//struct SearchResult {
//    var event: EventsObj?;
//    var attendee: SearchObj?
//}
