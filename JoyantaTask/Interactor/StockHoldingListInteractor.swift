//
//  StockHoldingListInteractor.swift
//  JoyantaTask
//
//  Created by Joyanta Mondal on 19/11/24.
//

import Foundation

protocol InteractorToPresenterProtocol: AnyObject {
    func getStockHoldingInformation(holdingStockInfo: [StockHoldingListModel])
}

class StockHoldingListInteractor {
    
    weak var interactorDelegate: InteractorToPresenterProtocol?

    func fetchStockHoldingList() {
        Task {
            do {
                let holdingStockInfo = try await APIHandler().fetchStockHoldingData()
                
                interactorDelegate?.getStockHoldingInformation(holdingStockInfo: holdingStockInfo)
            } catch {
                print(error)
            }
        }
    }
    
}
