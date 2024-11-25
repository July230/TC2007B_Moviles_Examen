//
//  CovidListRequirement.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation

protocol CovidListRequirementProtocol {
    func getCovidList(country: String?, region: String?) async -> Covid?
}

class CovidListRequirement: CovidListRequirementProtocol {
    static let shared = CovidListRequirement()
    let covidRepository: CovidRepository
    
    init(covidRepository: CovidRepository = CovidRepository.shared) {
        self.covidRepository = covidRepository
    }
    
    func getCovidList(country: String? = nil, region: String? = nil) async -> Covid? {
        return await covidRepository.getCovidList(country: country, region: region)
    }
}
