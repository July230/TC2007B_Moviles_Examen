//
//  Covid.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation

struct Covid: Codable, Identifiable {
    var id: String { "\(country)-\(region)" } // We will use Country and region as ID
    var country: String
    var region: String
    var cases: [String: Cases] // Dictionary to store total and new
}

struct Cases: Codable {
    var total: Int
    var new: Int
}
