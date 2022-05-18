//
//  UIView.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 27.04.2022.
//

import Foundation
import UIKit

extension UIView{
    func fixSharping(view: UIView,
                     type: CALayerCornerCurve = .continuous,
                     radius: CGFloat = 15,
                     color: UIColor,
                     width: CGFloat = 3
    ) {
        view.layer.cornerCurve = type
        view.layer.cornerRadius = radius
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
    }
    
    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
            self.alpha = 0
            self.isHidden = false
            UIView.animate(withDuration: duration!,
                           animations: { self.alpha = 1 },
                           completion: { (value: Bool) in
                              if let complete = onCompletion { complete() }
                           }
            )
        }
}
