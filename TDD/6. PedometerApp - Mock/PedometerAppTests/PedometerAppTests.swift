//
//  PedometerAppTests.swift
//  PedometerAppTests
//
//  Created by Mohammad Azam on 4/4/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import XCTest
import CoreMotion
@testable import PedometerApp

class PedometerAppTests: XCTestCase {

    func test_StartsPedometer() {
            
        let mockPedometer = MockPedometer() 
        let pedometerVM = PedometerViewModel(pedometer: mockPedometer)
        
        pedometerVM.startPedometer()
        
        XCTAssertTrue(mockPedometer.started)
        
    }

}
