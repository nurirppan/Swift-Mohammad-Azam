//
//  UIColorTransformer.swift
//  UIColorTransformer
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import UIKit

class UIColorTransformer: ValueTransformer {
    
    // convert ui color -> return data type or data it self
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    // kebalikan yang atas
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        } catch {
            return nil
        }
    }
}
