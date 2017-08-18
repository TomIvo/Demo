//
//  ViewController.swift
//  ABTransactions
//
//  Created by ivan.tomco on 14/08/2017.
//  Copyright © 2017 ivan.tomco. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var filterTextBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var dropDownHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    var transactions : [ABTransaction] = [ABTransaction]()
    var allTransactions : [ABTransaction] = [ABTransaction]()
    var filterList = ["All","Incoming", "Outgoing"]
    let MIN_VALUE_OF_DROP_DOWN = CGFloat(32)
    let MAX_VALUE_OF_DROP_DOWN = CGFloat(140)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        
        dropDownHeightConstraint.constant = MIN_VALUE_OF_DROP_DOWN
        filterTextBox.text = filterList[0]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? ABTransactionCell else {
            fatalError("The dequeued cell is not an instance of ABTransactionCell.")
        }
        let transaction = self.transactions[indexPath.row]
        cell.initWithTransaction(transaction: transaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTransaction = self.transactions[indexPath.row]
        performSegue(withIdentifier: "showTransDetail", sender: selectedTransaction)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Accounts"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! DetailTransactionViewController
        guest.transaction = sender as? ABTransaction
    }
    
    func refresh()
    {
        self.tableView.reloadData()
    }
    
    func loadData() {
        ABDataManager.shared.getTransactions(completionHandler: {data, error -> Void in
            guard let items = data else {
                print("Error loading data")
                return
            }
            for item in items {
                let transaction = ABTransaction(dictionary: item as! NSDictionary)
                self.allTransactions.append(transaction!)
            }
            self.transactions.append(contentsOf: self.allTransactions)
            DispatchQueue.main.async(execute: {self.refresh()})
        })
    }
    
    func filterTransactions(filter: String) {
        if filter == filterList[0] {
            self.transactions = [ABTransaction](self.allTransactions)
        } else {
            self.transactions = self.allTransactions.filter { $0.direction == filter.uppercased() }
        }
        self.refresh()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.filterList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return self.filterList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.filterTextBox.text = self.filterList[row]
        self.dropDown.isHidden = true
        dropDownHeightConstraint.constant = MIN_VALUE_OF_DROP_DOWN
        
        self.filterTransactions(filter: self.filterList[row])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.filterTextBox {
            dropDownHeightConstraint.constant = MAX_VALUE_OF_DROP_DOWN
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
    }
    
}

