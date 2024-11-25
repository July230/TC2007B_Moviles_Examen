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
    func fetchCovidData(url: URL, apiKey: String) async -> Covid? {
        // Add header with API
        let headers: HTTPHeaders = [
            "X-API-Key": "+7l2Lo/qihXFewHndOYmbQ==PZn2JWF1uk3vHXOs"
        ]
        
        // GET method with headers
        let taskRequest = AF.request(url, method: .get, headers: headers).validate()
        let response = await taskRequest.serializingData().response
        
        switch response.result {
        case .success(let data):
            do {
                // JSONDecoder, object that decodifies istances of JSONs with decode
                return try JSONDecoder().decode(Covid.self, from: data)
            } catch {
                return nil
            }
        case let .failure(error):
            debugPrint(error.localizedDescription) // Print error
            return nil
        }
    }
}
