//
//  CovidListRequirement.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation

protocol CovidListRequirementProtocol {
    func getCovidList() async -> Covid?
}

class CovidListRequirement: CovidListRequirementProtocol {
    static let shared = CovidListRequirement()
    let covidRepository: CovidRepository
    
    init(covidRepository: CovidRepository = CovidRepository.shared) {
        self.covidRepository = covidRepository
    }
    
    func getCovidList() async -> Covid? {
        return await covidRepository.getCovidList()
    }
}
