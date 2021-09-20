//
//  AlertManager.swift
//  TestingMultipleExpectations
//
//  Created by Mohammad Azam on 5/8/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

class AlertManager {
    
    func postAlert() {
        NotificationCenter.default.post(name: Notification.Name.alertNotification, object: self)
    }
}
