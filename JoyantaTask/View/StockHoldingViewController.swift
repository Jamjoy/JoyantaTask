//
//  StockHoldingViewController.swift
//  JoyantaTask
//
//  Created by Joyanta Mondal on 19/11/24.
//

import UIKit

class StockHoldingViewController: UIViewController {
    
    @IBOutlet weak var stockHoldingListTableView: UITableView!
    
    var presenter = StockHoldingPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stockHoldingListTableView.dataSource = self
        self.stockHoldingListTableView.delegate = self

        // registering Tableview Cell
        registerTableViewCell()
        initPresenter()
    }
    
    func initPresenter() {
        presenter.presenterDelegate = self
        presenter.getStockHoldingDetails()
    }
    
    func registerTableViewCell() {
        stockHoldingListTableView.register(UINib(nibName: "StockInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "StockInformationTableViewCell")
    }
}

extension StockHoldingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockHoldingListTableView.dequeueReusableCell(withIdentifier: "StockInformationTableViewCell", for: indexPath) as? StockInformationTableViewCell
        let dataSetup = presenter.dataSource()
        cell?.setupCell(dataSetup: dataSetup[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

extension StockHoldingViewController: PresenterToViewDelegate {
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.stockHoldingListTableView.reloadData()
        }
    }
}
