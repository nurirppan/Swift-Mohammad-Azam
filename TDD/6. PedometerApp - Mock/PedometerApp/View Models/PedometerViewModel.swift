//
//  PedometerViewModel.swift
//  PedometerApp
//
//  Created by Mohammad Azam on 4/5/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

class PedometerViewModel {
    
    var pedometer: Pedometer
    
    init(pedometer: Pedometer) {
        self.pedometer = pedometer
    }
    
    func startPedometer() {
        self.pedometer.start()
    }
    
}
