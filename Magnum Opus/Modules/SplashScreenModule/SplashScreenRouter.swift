//
//  SplashScreenRouter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 30.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation
import UIKit

protocol SplashScreenRouterProtocol: AnyObject {
    func navigateToController(route: SplashScreenRoutes)
}

enum SplashScreenRoutes {
    case main
    case noConnection
}


final class SplashScreenRouter: NSObject {

    weak var view: SplashScreenViewController!

    static func setupModule() -> SplashScreenViewController {
        let vc = SplashScreenViewController()
        let interactor = SplashScreenInteractor()
        let router = SplashScreenRouter()
        let presenter = SplashScreenPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.view = vc
        interactor.presenter = presenter
        return vc
    }
}

extension SplashScreenRouter: SplashScreenRouterProtocol {
    
    func navigateToController(route: SplashScreenRoutes) {
        switch route {
        case .main:
            let listVC = ListViewRouter.setupModule()
            listVC.navigationItem.hidesBackButton = true
            view?.navigationController?.pushViewController(listVC, animated: true)
        case .noConnection:
            let noConnectionVC = NoConnectionAlert()
            noConnectionVC.navigationItem.hidesBackButton = true
            view?.navigationController?.pushViewController(noConnectionVC, animated: true)
        }
    }
    

}

