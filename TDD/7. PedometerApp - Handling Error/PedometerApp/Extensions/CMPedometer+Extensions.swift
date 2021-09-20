//
//  CMPedometer+Extensions.swift
//  PedometerApp
//
//  Created by Mohammad Azam on 4/5/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import CoreMotion

extension CMPedometer: Pedometer {
    
    var pedometerAvailable: Bool {
        return CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable()
        && CMPedometer.authorizationStatus() != .restricted
    }
    
    func start() {
        
    }
    
}
