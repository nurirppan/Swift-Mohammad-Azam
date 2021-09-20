//
//  PedometerAppTests.swift
//  PedometerAppTests
//
//  Created by Mohammad Azam on 4/4/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import XCTest
import CoreMotion

// this must run in real device

class PedometerAppTests: XCTestCase {

    func test_CMPedometer_LoadingHistorialData() {
        
        let now = Date()
        var data: CMPedometerData?
        let then = now.addingTimeInterval(-1000)
        let exp = expectation(description: "Pedometer query returns...")
        
        let pedometer = CMPedometer()
        pedometer.queryPedometerData(from: now, to: then) { (pedometerData, error) in
            
            data = pedometerData
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertNotNil(data)
        if let steps = data?.numberOfSteps {
            XCTAssertTrue(steps.intValue > 0)
        }
        
    }

}
