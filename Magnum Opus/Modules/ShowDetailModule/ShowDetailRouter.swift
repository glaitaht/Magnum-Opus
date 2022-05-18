//
//  ShowDetailRouter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 29.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation
import UIKit

protocol ShowDetailRouterProtocol: AnyObject {
    func navigateToAnotherDetail(route: ShowDetailRoutes)
}

enum ShowDetailRoutes {
    case detail(movie: Movie)
}

final class ShowDetailRouter: NSObject {

    weak var view: ShowDetailViewController!

    static func setupModule(movie: Movie) -> ShowDetailViewController {
        let vc = ShowDetailViewController()
        let interactor = ShowDetailInteractor()
        let router = ShowDetailRouter()
        let presenter = ShowDetailPresenter(interactor: interactor, router: router, view: vc)
        
        presenter.movieToShow = movie
        vc.presenter = presenter
        router.view = vc
        interactor.presenter = presenter
        return vc
    }
}

extension ShowDetailRouter: ShowDetailRouterProtocol {
    
    func navigateToAnotherDetail(route: ShowDetailRoutes) {
        switch route {
        case .detail(let movie):
            let detailVC = ShowDetailRouter.setupModule(movie: movie)
            view?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

