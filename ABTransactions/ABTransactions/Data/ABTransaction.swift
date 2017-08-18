//
//  ABTransaction.swift
//  ABTransactions
//
//  Created by ivan.tomco on 14/08/2017.
//  Copyright © 2017 ivan.tomco. All rights reserved.
//

import UIKit
class ABTransaction {
    var id: Int?
    var amountInAccountCurrency: Int?
    var direction: String?
    
    static func loadAllTransactions() -> [ABTransaction]? {
        var transactions = [ABTransaction]()
        
        // url request
        let endpoint: String = "http://demo0569565.mockable.io/transactions"
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return nil
        }
        let urlRequest = URLRequest(url: url)
        
        // session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /transactions")
                return
            }
            // check if got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                guard let items = json["items"] as? NSArray else {
                    print("error in JSON - items")
                    return
                }
                
                for item in items {
                    let transaction = ABTransaction(dictionary: item as! NSDictionary)
                    transactions.append(transaction!)
                }
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        return transactions
    }
    
    required public init?(dictionary: NSDictionary) {
        
        self.id = dictionary["id"] as? Int
        self.amountInAccountCurrency = dictionary["amountInAccountCurrency"] as? Int
        self.direction = dictionary["direction"] as? String
    }
}


