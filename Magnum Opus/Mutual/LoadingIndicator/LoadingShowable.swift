//
//  LoadingShowable.swift
//  ViperNews
//
//  Created by Egitim on 23.04.2022.
//

import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading(_ view: UIView?)
    func hideLoading()
}

extension LoadingShowable {
    func showLoading(_ view: UIView? = nil) {
        LoadingView.shared.startLoading(view)
    }

    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}
