//
//  UIColor.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/03.
//

import Foundation
import UIKit

extension UIColor {
    ///#39D353 40%
    static let green01 = UIColor(named: "green01")
    ///#39D353 90%
    static let green02 = UIColor(named: "green02")
    ///#016D32
    static let green03 = UIColor(named: "green03")
    ///#26A641
    static let green04 = UIColor(named: "green04")
    ///#3AD353
    static let green05 = UIColor(named: "green05")
    ///#7ADC4B
    static let green06 = UIColor(named: "green06")
    ///#0D1117
    static let black01 = UIColor(named: "black01")
    ///#181B21
    static let black02 = UIColor(named: "black02")
    ///#272C33
    static let black03 = UIColor(named: "black03")
    ///#C5C5C5
    static let grey01  = UIColor(named: "grey01")
    ///#EB7A7A
    static let red01   = UIColor(named: "red01")
    ///#9BB9F2
    static let blue01  = UIColor(named: "blue01")
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
}
