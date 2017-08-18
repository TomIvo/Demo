//
//  ABTransactionCell.swift
//  ABTransactions
//
//  Created by ivan.tomco on 14/08/2017.
//  Copyright © 2017 ivan.tomco. All rights reserved.
//

import UIKit
class ABTransactionCell: UITableViewCell {
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var directionImageView: UIImageView!
    
    var transactionId: Int?
    
    func initWithTransaction(transaction: ABTransaction) {
        self.lblAmount.text = String(describing: transaction.amountInAccountCurrency!)
        self.lblDirection.text = transaction.direction
        self.transactionId = transaction.id
        self.directionImageView.image = UIImage(named:transaction.direction!)
    }
    
}
