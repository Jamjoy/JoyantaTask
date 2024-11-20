//
//  StockHoldingPresenter.swift
//  JoyantaTask
//
//  Created by Joyanta Mondal on 19/11/24.
//

import Foundation

protocol PresenterToViewDelegate: AnyObject {
    func reloadTableView()
}

class StockHoldingPresenter: InteractorToPresenterProtocol {
        
    // It will be called everytime when postWithUserDetails value will be updated.
    var holdingStockDetails: [StockHoldingListModel] = [] {
        didSet {
            // reloading tableView.
            self.presenterDelegate?.reloadTableView()
        }
    }
    
    weak var presenterDelegate: PresenterToViewDelegate?
    
    func getStockHoldingDetails() {
       let APIManager = StockHoldingListInteractor()
       APIManager.interactorDelegate = self
       APIManager.fetchStockHoldingList()
   }
}

extension StockHoldingPresenter {
    // number of rows we have to show.
    func numberOfRows() -> Int {
        return holdingStockDetails.count
    }
    
    // data to display (stock details)
    func dataSource() -> [StockHoldingListModel] {
        return holdingStockDetails
    }
}

extension StockHoldingPresenter {
    func getStockHoldingInformation(holdingStockInfo: [StockHoldingListModel]) {
        holdingStockDetails = holdingStockInfo
    }
}
