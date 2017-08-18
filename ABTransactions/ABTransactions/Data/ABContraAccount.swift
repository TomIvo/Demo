//
//  ABContraAccount.swift
//  ABTransactions
//
//  Created by ivan.tomco on 15/08/2017.
//  Copyright © 2017 ivan.tomco. All rights reserved.
//

import UIKit
public class ABContraAccount {
    public var accountNumber : String?
    public var accountName : String?
    public var bankCode : String?
    
    required public init?(dictionary: NSDictionary) {
        
        self.accountNumber = dictionary["accountNumber"] as? String
        self.accountName = dictionary["accountName"] as? String
        self.bankCode = dictionary["bankCode"] as? String
    }
}
