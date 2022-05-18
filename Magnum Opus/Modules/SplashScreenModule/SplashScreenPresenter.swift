//
//  SplashScreenPresenter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 30.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol SplashScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class SplashScreenPresenter {

    unowned var view: SplashScreenViewControllerProtocol
    let router: SplashScreenRouterProtocol?
    let interactor: SplashScreenInteractorProtocol?

    init(interactor: SplashScreenInteractorProtocol, router: SplashScreenRouterProtocol, view: SplashScreenViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SplashScreenPresenter: SplashScreenPresenterProtocol {
    func viewDidLoad(){
        self.view.setupViews()
        if !(NetworkManager.shared.isConnectedToInternet()){
            router?.navigateToController(route: .noConnection)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            self.router?.navigateToController(route: .main)
        }
    }
}
