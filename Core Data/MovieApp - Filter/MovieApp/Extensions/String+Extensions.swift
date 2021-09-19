//
//  String+Extensions.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/19/21.
//

import Foundation

extension String {
    
    func asDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: self)
    }
}
