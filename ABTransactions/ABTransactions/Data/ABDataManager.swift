//
//  ABDataManager.swift
//  ABTransactions
//
//  Created by ivan.tomco on 17/08/2017.
//  Copyright © 2017 ivan.tomco. All rights reserved.
//

import UIKit

protocol DataManagerProtocol {
    func getTransactions(completionHandler: @escaping (NSArray?, Error?) -> Void);
    func getTransactionDetail(forTransactionId transId: Int, completionHandler: @escaping (NSDictionary?, Error?) -> Void);
}

class ABDataManager {
    
    var delegate: DataManagerProtocol?
    
    private init() {
        delegate = ABRemoteDataManager()
    }
    
    func getTransactions(completionHandler: @escaping (NSArray?, Error?) -> Void){
        delegate?.getTransactions(completionHandler: { (data, error) in
            return completionHandler(data, error)
        })
    }
    
    func getTransactionDetail(forTransactionId transId: Int, completionHandler: @escaping (NSDictionary?, Error?) -> Void){
        delegate?.getTransactionDetail(forTransactionId: transId, completionHandler: { (data, error) in
            return completionHandler(data, error)
        })
    }
    
    static let shared = ABDataManager()
}
