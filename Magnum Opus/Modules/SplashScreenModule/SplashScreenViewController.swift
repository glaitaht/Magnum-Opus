//
//  SplashScreenViewController.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 30.04.2022.
//

import UIKit

protocol SplashScreenViewControllerProtocol: AnyObject {
    func setupViews()
}

final class SplashScreenViewController: UIViewController {
    @IBOutlet weak var splashImage: UIImageView!
    @IBOutlet weak var magnumTitle: UILabel!
    @IBOutlet weak var magnumCatchpr: UILabel!
    @IBOutlet weak var rosebud: UILabel!
    
    
    
    var presenter: SplashScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}

extension SplashScreenViewController: SplashScreenViewControllerProtocol {
    func setupViews() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.magnumTitle.transform = CGAffineTransform(translationX: -25, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.magnumTitle.alpha = 0
                self.magnumTitle.transform = self.magnumTitle.transform.translatedBy(x: 0, y: -200)
            }, completion: nil)
        }
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.magnumCatchpr.transform = CGAffineTransform(translationX: +25, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.magnumCatchpr.alpha = 0
                self.magnumCatchpr.transform = self.magnumCatchpr.transform.translatedBy(x: 0, y: +200)
            }, completion: nil)
        }
        UIView.animate(withDuration: 1, delay: 0, animations: {() -> Void in
            self.splashImage?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 2, animations: {() -> Void in
                self.splashImage.alpha = 1
                self.rosebud.alpha = 1
                self.splashImage?.transform = CGAffineTransform(scaleX: 5, y: 5)
            })
        })
        /*UIView.animate(withDuration: 1, delay: 2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .transitionFlipFromBottom, animations: {
            self.rosebud.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .transitionFlipFromBottom, animations: {
                self.splashImage.alpha = 1
            }, completion: nil)
        }*/
    }
}
