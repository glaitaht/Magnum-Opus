//
//  ListViewRouter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 27.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewRouterProtocol: AnyObject {
    func navigateToDetail(route: ListViewRoutes)
}

enum ListViewRoutes {
    case detail(movie: Movie)
}

final class ListViewRouter: NSObject {

    weak var view: ListViewController?

    static func setupModule() -> ListViewController {
        let vc = ListViewController()
        let interactor = ListViewInteractor()
        let router = ListViewRouter()
        let presenter = ListViewPresenter(interactor: interactor, router: router, view: vc)

        vc.searchResultView = SearchResultRouter.setupModule(superview: vc)
         
        vc.presenter = presenter
        router.view = vc
        interactor.presenter = presenter
        return vc
    }
}

extension ListViewRouter: ListViewRouterProtocol {
    
    func navigateToDetail(route: ListViewRoutes) {
        switch route {
        case .detail(let movie):
            let detailVC = ShowDetailRouter.setupModule(movie: movie)
            view?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    

}

