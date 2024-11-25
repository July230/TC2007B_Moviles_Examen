//
//  CovidViewModel.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation

class CovidViewModel: ObservableObject {
    @Published var covidList = [Covid]()
    
    var covidListRequirement: CovidListRequirementProtocol
    
    init(covidListRequirement: CovidListRequirementProtocol = CovidListRequirement.shared) {
        self.covidListRequirement = covidListRequirement
    }
    
    @MainActor
    func getCovidList() async {
        guard let result = await covidListRequirement.getCovidList() else {
            print("Failed to fetch Covid data")
            return
        }
        
        // Add complete data to the list
        self.covidList = [result]
    }
}
