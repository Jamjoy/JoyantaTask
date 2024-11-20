//
//  StockInformationTableViewCell.swift
//  JoyantaTask
//
//  Created by Joyanta Mondal on 19/11/24.
//

import UIKit

class StockInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var stockNameLbl: UILabel!
    @IBOutlet weak var netQtyLbl: UILabel!
    @IBOutlet weak var netQtyValue: UILabel!
    @IBOutlet weak var ltpLbl: UILabel!
    @IBOutlet weak var ltpValue: UILabel!
    @IBOutlet weak var plLbl: UILabel!
    @IBOutlet weak var plValue: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(dataSetup: StockHoldingListModel, pl: Double) {
        self.stockNameLbl.text = dataSetup.symbol
        self.netQtyLbl.text = "NET QTY:"
        self.netQtyValue.text = "\(dataSetup.quantity)"
        self.ltpLbl.text = "LTP:"
        self.ltpValue.text = "₹ \(dataSetup.ltp)"
        self.plLbl.text = "P&L:"
        self.ltpValue.text = "₹ \(dataSetup.ltp)"
        self.plValue.text = "₹ \(pl)"
        
        if pl > 0 {
            self.plValue.textColor = UIColor.green
        } else if pl < 0 {
            self.plValue.textColor = UIColor.red
        } else {
            self.plValue.textColor = UIColor.black
        }
    }
}
