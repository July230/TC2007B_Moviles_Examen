//
//  Covid.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation

struct Covid: Codable {
    var country: String
    var region: String
    var cases: [String: Cases] // Dictionary to store total and new
}

struct Cases: Codable {
    var total: Int
    var new: Int
}
