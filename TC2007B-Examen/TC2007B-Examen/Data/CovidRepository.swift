//
//  CovidRepository.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation

struct API {
    static let baseURL = "https://api.api-ninjas.com/v1"
    
    struct routes {
        static let covid = "/covid19"
    }
}

protocol CovidAPIProtocol {
    // "https://api.api-ninjas.com/v1/covid19"
    func getCovidList() async -> Covid?
}

class CovidRepository: CovidAPIProtocol {
    static let shared = CovidRepository()
    let nservice: NetworkAPIService
    private var apiKey: String?
    
    init(nservice: NetworkAPIService = NetworkAPIService.shared) {
        self.nservice = nservice
        
        // Retrieve API_KEY from Secrets.xcconfig
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
            self.apiKey = apiKey
            print("API Key retrieved: \(apiKey)")  // Imprime el token en consola
        } else {
            print("API Key not found in Info.plist!")
        }
    }
    
    func getCovidList() async -> Covid? {
        guard let apiKey = apiKey else {
            print("API key is missing")
            return nil
        }
        
        guard let url = URL(string: "\(API.baseURL)\(API.routes.covid)") else {
            print("Invalid URL")
            return nil
        }
        
        return await nservice.fetchCovidData(url: url, apiKey: apiKey)
    }
}

