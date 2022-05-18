//
//  SearchResultPresenter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 28.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol SearchResultPresenterProtocol: AnyObject {
    func fetchSearchedMovie(movieName: String)
    func viewDidLoad()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> Movie?
    func didSelectRowAt(index: Int)
}

final class SearchResultPresenter {

    unowned var view: SearchResultViewControllerProtocol
    let router: SearchResultRouterProtocol?
    let interactor: SearchResultInteractorProtocol?

    private var searchedResult: MovieResult?
    
    init(interactor: SearchResultInteractorProtocol, router: SearchResultRouterProtocol? = nil, view: SearchResultViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        if let router = router{
            self.router = router
        }
        else{
            self.router = nil
        }
    }
    
    func navigateToDetail(movie: Movie){
        router?.navigateToDetail(route: .detail(movie: movie))
    }
}

extension SearchResultPresenter: SearchResultPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func numberOfItems() -> Int {
        if let count = searchedResult?.results?.count{
            return count
        }
        return 0
    }
    
    func movie(_ index: Int) -> Movie? {
        if let movie = searchedResult?.results?[safe: index] {
            return movie
        }
        return nil
    }
    
    func didSelectRowAt(index: Int) {
        if let movie = movie(index){
            navigateToDetail(movie: movie)
        }
    }
    
    func fetchSearchedMovie(movieName: String){
        view.showLoadingView()
        interactor?.fetchSearchedMovie(movieName: movieName)
    }
}

extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    func fetchSearchedOutput(result: MovieResultAlias){
        switch result {
        case .success(let movies):
            self.searchedResult = movies
            self.view.hideLoadingView()
            view.reloadData()
        case .failure(let error):
            print(error)
        }
    }
}
