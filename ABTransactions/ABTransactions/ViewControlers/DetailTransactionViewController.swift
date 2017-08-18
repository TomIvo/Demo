//
//  DetailTransactionViewController.swift
//  ABTransactions
//
//  Created by ivan.tomco on 15/08/2017.
//  Copyright © 2017 ivan.tomco. All rights reserved.
//

import UIKit

class DetailTransactionViewController: UIViewController {

    @IBOutlet weak var lblAccNumber: UILabel!
    @IBOutlet weak var lblAccName: UILabel!
    @IBOutlet weak var lblBankCode: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var directionImageView: UIImageView!
    
    var transaction: ABTransaction?
    
    var contraAccount: ABContraAccount?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.loadData()
    }
    
    func loadData() {
        guard let transactionId = self.transaction?.id else {
            print("wrong transaction id")
            return
        }
        
        ABDataManager.shared.getTransactionDetail(forTransactionId: transactionId, completionHandler: {data, error -> Void in
            guard let account = data else {
                print("Error loading data")
                return
            }
            self.contraAccount = ABContraAccount(dictionary: account)
            DispatchQueue.main.async(execute: {self.setupDetail()})
        })
    }
    
    
    func setup()
    {
        if self.transaction != nil {
            self.lblAmount.text = String(describing: self.transaction!.amountInAccountCurrency!)
            self.lblDirection.text = self.transaction!.direction
            self.directionImageView.image = UIImage(named:transaction!.direction!)
        }
        
    }
    
    func setupDetail() {
        if self.contraAccount != nil {
            self.lblAccNumber.text = self.contraAccount!.accountNumber != nil ? self.contraAccount!.accountNumber! : String()
            self.lblAccName.text = self.contraAccount!.accountName != nil ? self.contraAccount!.accountName! : String()
            self.lblBankCode.text = self.contraAccount!.bankCode != nil ? self.contraAccount!.bankCode! : String()
        }
    }

}
