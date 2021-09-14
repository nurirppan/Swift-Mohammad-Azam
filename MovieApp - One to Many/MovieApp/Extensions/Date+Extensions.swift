//
//  Date+Extensions.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/24/21.
//

import Foundation

extension Date {
    
    func asFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
}
