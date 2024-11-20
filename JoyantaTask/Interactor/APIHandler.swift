//
//  APIHandler.swift
//  JoyantaTask
//
//  Created by Joyanta Mondal on 19/11/24.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}

class APIHandler {
    let domain = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"
    
    func fetchStockHoldingData() async throws -> [StockHoldingListModel] {
        guard let url = URL(string: domain) else {
            throw NetworkError.badUrl
        }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        try resonseCheck(response: response)
        guard let usersData = try? JSONDecoder().decode(StockHoldingModel.self, from: data) else {
            throw NetworkError.decodingError
        }
        return usersData.data.userHolding
    }
    
    // checking respose
    func resonseCheck(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
    }
    
}
