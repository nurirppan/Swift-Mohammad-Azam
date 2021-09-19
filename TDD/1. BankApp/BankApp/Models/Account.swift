//
//  Account.swift
//  BankApp
//
//  Created by Mohammad Azam on 3/29/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

struct Account {
    var balance: Double = 0.0
    
    mutating func deposit(_ amount: Double)
    {
        self.balance += amount
    }}
