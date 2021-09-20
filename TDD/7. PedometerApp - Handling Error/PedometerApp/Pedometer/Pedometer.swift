//
//  Pedometer.swift
//  PedometerApp
//
//  Created by Mohammad Azam on 4/5/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

protocol Pedometer {
    
    var pedometerAvailable: Bool { get }
    func start() 
}
