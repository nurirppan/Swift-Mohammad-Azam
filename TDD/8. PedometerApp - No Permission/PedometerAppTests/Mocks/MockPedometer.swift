//
//  MockPedometer.swift
//  PedometerAppTests
//
//  Created by Mohammad Azam on 4/5/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
@testable import PedometerApp

class MockPedometer: Pedometer {
    
    var pedometerAvailable: Bool = true
    var permissionDeclined: Bool = false
    
    private (set) var started: Bool = false
    
    func start() {
        self.started = true 
    }
    
}
