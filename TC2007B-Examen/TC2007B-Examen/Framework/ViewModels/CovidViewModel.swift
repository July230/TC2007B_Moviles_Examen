//
//  CovidViewModel.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation

class CovidViewModel: ObservableObject {
    @Published var covidList = [CovidBase]()
    
    var covidListRequirement: CovidListRequirementProtocol
    
    init(covidListRequirement: CovidListRequirementProtocol = CovidListRequirement.shared) {
        self.covidListRequirement = covidListRequirement
    }
    
    @MainActor
    func getCovidList(country: String? = nil, region: String? = nil) async {
        guard let result = await covidListRequirement.getCovidList(country: country, region: region) else {
            print("Failed to fetch Covid data")
            return
        }
        
        var tempList = [CovidBase]()
        for (date, caseDate) in result.cases {
            let tempCovid = Covid(country: result.country, region: result.region, cases: [date: caseDate])
            let covidBase = CovidBase(covid: tempCovid)
            // Add created object to tempList
            tempList.append(covidBase)
        }
        self.covidList = tempList
    }
}
