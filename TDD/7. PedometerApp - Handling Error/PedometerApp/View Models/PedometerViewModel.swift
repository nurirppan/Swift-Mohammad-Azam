//
//  PedometerViewModel.swift
//  PedometerApp
//
//  Created by Mohammad Azam on 4/5/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

enum AppState {
    case notStarted
    case inProgress
}

class PedometerViewModel {
    
    var pedometer: Pedometer
    var appState: AppState = .notStarted
    
    init(pedometer: Pedometer) {
        self.pedometer = pedometer
    }
    
    func startPedometer() {
        
        guard self.pedometer.pedometerAvailable else {
            self.appState = .notStarted
            return 
        }
        
        self.pedometer.start()
    }
    
}
