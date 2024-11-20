//
//  StockHoldingModel.swift
//  JoyantaTask
//
//  Created by Joyanta Mondal on 19/11/24.
//

import Foundation

struct StockHoldingModel: Codable {
    let data: UserHoldingModel
}

struct UserHoldingModel: Codable {
    let userHolding: [StockHoldingListModel]
}

struct StockHoldingListModel: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
}
