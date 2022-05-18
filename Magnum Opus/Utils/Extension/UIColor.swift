//
//  String.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 26.04.2022.
//

import Foundation
import UIKit 


extension UIColor{
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    struct Theme {
        static var black: UIColor  { return hexStringToUIColor(hex:"#09020B") } //09020B
        static var darkPurple1: UIColor { return hexStringToUIColor(hex:"#601575") } //601575
        static var darkPurple2: UIColor { return hexStringToUIColor(hex:"#9521B5") } //9521B5
        static var darkPurple3: UIColor { return hexStringToUIColor(hex:"#B427DB") } //B427DB
        static var pink: UIColor { return hexStringToUIColor(hex:"#C92CF5") } //C92CF5
    }
}
