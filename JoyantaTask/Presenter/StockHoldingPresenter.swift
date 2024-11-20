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
    
    // calculatiion for Profit And Loss
    
    func calculateEachStockPL(stockInformation: StockHoldingListModel) -> (currentValue: Double, investment: Double, pl: Double, plToday: Double) {
        let currentValue = stockInformation.ltp * Double(stockInformation.quantity)
        let investment = stockInformation.avgPrice * Double(stockInformation.quantity)
        let pl = currentValue - investment
        let plToday = (stockInformation.close - stockInformation.ltp) * Double(stockInformation.quantity)
        
        return (currentValue, investment, pl, plToday)
    }
    
    func calculateAllStockPL() -> (totalCurrentValue: Double, totalInvestment: Double, totalPLToday: Double, toalPL: Double) {
        
        var totalCurrentValue = 0.0
        var totalInvestment = 0.0
        var totalPLToday = 0.0

        for eachStock in holdingStockDetails {
            totalCurrentValue += calculateEachStockPL(stockInformation: eachStock).currentValue
            totalInvestment += calculateEachStockPL(stockInformation: eachStock).investment
            
            totalPLToday += calculateEachStockPL(stockInformation: eachStock).plToday
        }
        
        let toalPL = totalCurrentValue - totalInvestment
        
        return (totalCurrentValue, totalInvestment, totalPLToday, toalPL)
    }
    
}

extension StockHoldingPresenter {
    func getStockHoldingInformation(holdingStockInfo: [StockHoldingListModel]) {
        holdingStockDetails = holdingStockInfo
    }
}
