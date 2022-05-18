//
//  LoadingView.swift
//  ViperNews
//
//  Created by Egitim on 23.04.2022.
//

import UIKit

class LoadingView {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()

    private init() {
        configure()
    }

    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .Theme.darkPurple3
        blurView.contentView.addSubview(activityIndicator)
    }

    func startLoading(_ view: UIView? = nil) {
        if let view = view{
            view.addSubview(blurView)
            activityIndicator.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        }
        else{
            UIApplication.shared.windows.first?.addSubview(blurView)
            activityIndicator.center = blurView.center
        }
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        blurView.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
