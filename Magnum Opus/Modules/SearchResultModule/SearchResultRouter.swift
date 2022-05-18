//
//  SearchResultRouter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 28.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation
import UIKit

protocol SearchResultRouterProtocol: AnyObject {
    func navigateToDetail(route: SearchResultRoutes)
}

enum SearchResultRoutes {
    case detail(movie: Movie)
}

final class SearchResultRouter: NSObject {

    weak var view: SearchResultViewController?
    weak var superview: ListViewController?

    static func setupModule(superview: ListViewController) -> SearchResultViewController {
        let vc = SearchResultViewController()
        let interactor = SearchResultInteractor()
        let router = SearchResultRouter()
        let presenter = SearchResultPresenter(interactor: interactor, router: router, view: vc)
        router.superview = superview
        vc.presenter = presenter
        router.view = vc
        interactor.presenter = presenter
        return vc
    }
}

extension SearchResultRouter: SearchResultRouterProtocol {
    func navigateToDetail(route: SearchResultRoutes){
        switch route {
        case .detail(let movie):
            let detailVC = ShowDetailRouter.setupModule(movie: movie)
            superview?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

