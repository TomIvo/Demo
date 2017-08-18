//
//  ABRemoteDataManager.swift
//  ABTransactions
//
//  Created by ivan.tomco on 16/08/2017.
//  Copyright © 2017 ivan.tomco. All rights reserved.
//

import UIKit
class ABRemoteDataManager: DataManagerProtocol {
    func getTransactions(completionHandler: @escaping (NSArray?, Error?) -> Void){
        // url request
        let endpoint: String = "http://demo0569565.mockable.io/transactions"
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
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
                return completionHandler(nil, error)
            }
            
            //check if status code is ok (is equal 200)
            let status = (response as! HTTPURLResponse).statusCode
            guard status == 200 else {
                print("error calling GET on /transactions status code = \(status)")
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
                return completionHandler(items, nil)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
    
    func getTransactionDetail(forTransactionId transId: Int, completionHandler: @escaping (NSDictionary?, Error?) -> Void){
        // url request
        let endpoint: String = "http://demo0569565.mockable.io/transactions"
        guard var url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        url.appendPathComponent(String(describing: transId))
        let urlRequest = URLRequest(url: url)
        
        // session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /transactions/transactionId")
                return completionHandler(nil, error)
            }
            
            let status = (response as! HTTPURLResponse).statusCode
            guard status == 200 else {
                print("error calling GET on /transactions/transactionId status code = \(status)")
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
                guard let account = json["contraAccount"] as? NSDictionary else {
                    print("error in JSON - contraAccount")
                    return
                }
                return completionHandler(account, nil)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }

}
