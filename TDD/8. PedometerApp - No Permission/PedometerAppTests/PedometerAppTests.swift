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
    
    func test_PedometerAuthorized_ShouldBeInProgress() {
        
        let mockPedometer = MockPedometer()
        mockPedometer.permissionDeclined = false
        
        let pedometerVM = PedometerViewModel(pedometer: mockPedometer)
        
        pedometerVM.startPedometer()
        
        XCTAssertEqual(pedometerVM.appState, .inProgress)
        
    }
    
    func test_PedometerNotAuthorized_DoesNotStart() {
        
        let mockPedometer = MockPedometer()
        mockPedometer.permissionDeclined = true
        
        let pedometerVM = PedometerViewModel(pedometer: mockPedometer)
        
        pedometerVM.startPedometer()
        
        XCTAssertEqual(pedometerVM.appState, .notStarted)
        
    }
    
    func test_PedometerNotAvailable_DoesNotStart() {
        
        let mockPedometer = MockPedometer()
        mockPedometer.pedometerAvailable = false
        
        let pedometerVM = PedometerViewModel(pedometer: mockPedometer)
        
        pedometerVM.startPedometer()
        
        XCTAssertEqual(pedometerVM.appState, .notStarted)
        
    }
  

}
