//
//  NetworkAPIService.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import Foundation
import Alamofire

class NetworkAPIService {
    static let shared = NetworkAPIService() // Singleton, only one instance
    
    // fetchCovidData gets the JSON from API Ninjas
    func fetchCovidData(url: URL, apiKey: String) async -> [Covid]? {
        // Add header with API
        let headers: HTTPHeaders = [
            "X-API-Key": apiKey
        ]
        
        // Print URL and headers for debugging
        print("Fetching data from URL: \(url)")
        print("Headers: \(headers)")
        
        // GET method with headers
        let taskRequest = AF.request(url, method: .get, headers: headers).validate()
        let response = await taskRequest.serializingData().response
        
        switch response.result {
        case .success(let data):
            do {
                print("Data fetched successfully")
                // JSONDecoder, object that decodifies istances of JSONs with decode
                let covidData = try JSONDecoder().decode([Covid].self, from: data)
                return covidData
            } catch {
                print("Error decoding JSON: \(error)")
                return nil
            }
        case let .failure(error):
            if let httpResponse = response.response {
                print("HTTP Status Code: \(httpResponse.statusCode)") // Print error
            }
            print("Request Error: \(error.localizedDescription)")
            return nil
        }
    }
}
