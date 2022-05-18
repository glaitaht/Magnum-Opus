//
//  ShowDetailPresenter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 29.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol ShowDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> Movie?
    func didSelectRowAt(index: Int)
    func favClicked()
}


final class ShowDetailPresenter {

    unowned var view: ShowDetailViewControllerProtocol
    let router: ShowDetailRouterProtocol?
    let interactor: ShowDetailInteractorProtocol?

    var movieToShow: Movie!
    private var movieDetail: MovieDetailResult?
    private var similarMovies: MovieResult?
    private var isItFavorite: Bool = false
    
    init(interactor: ShowDetailInteractorProtocol, router: ShowDetailRouterProtocol, view: ShowDetailViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func fetchMovieDetail(){
        if let movieID = movieToShow.id {
            interactor?.fetchMovieDetail(ID: movieID)
        }
    }
    
    func fetchSimilarMovies(){
        if let movieID = movieToShow.id {
            interactor?.fetchSimilarMovies(ID: movieID)
        }
    }
    
    func navigateToAnotherDetail(movie: Movie){
        router?.navigateToAnotherDetail(route: .detail(movie: movie))
    }
    
    func isFavorite() -> Bool {
        if let id = movieToShow.id {
            if let isIt = UserDefaults.getFavouriteGamesFromUserDefault(forKey: "favMovies")?.contains(id){
                if isIt{
                    return true
                }
            }
        }
        return false
    }
}

extension ShowDetailPresenter: ShowDetailPresenterProtocol {
    
    func viewDidLoad() {
        view.showLoadingView()
        if let title = movieToShow.title{
            view.setTitle(title: title)
        }
        if isFavorite() {
            self.isItFavorite = true
            view.setFav(isItFav: isItFavorite)
        }
        view.setupViews()
        fetchMovieDetail()
        fetchSimilarMovies()
    }
    
    func numberOfItems() -> Int {
        if self.similarMovies?.results?.count == 0 {
            return 0
        }
        if let movies = similarMovies?.results {
            return movies.count
        }
        return 0
    }
    
    func movie(_ index: Int) -> Movie? {
        if let movies = similarMovies?.results {
            return movies[safe: index]
        }
        return nil
    }
    
    func didSelectRowAt(index: Int) {
        if let movie = movie(index) {
            navigateToAnotherDetail(movie: movie)
        }
    }
    
    func favClicked() {
        if isItFavorite{
            isItFavorite = false
            view.setFav(isItFav: isItFavorite)
            if let id = movieToShow.id{
                UserDefaults.setFavouriteGameToUserDefault(forKey: "favMovies", add: false, ID: id)
            }
        }
        else{
            isItFavorite = true
            view.setFav(isItFav: isItFavorite)
            if let id = movieToShow.id{
                UserDefaults.setFavouriteGameToUserDefault(forKey: "favMovies", add: true, ID: id)
            }
        }
    }
}

extension ShowDetailPresenter: ShowDetailInteractorOutputProtocol {
    
    func fetchSimilarMoviesOutput(result: MovieResultAlias) {
        switch result {
        case .success(let similarMovies):
            self.similarMovies = similarMovies
            self.view.reloadData()
            view.hideLoadingView()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchMovieDetailOutput(result: MovieDetailResultAlias) {
        switch result {
        case .success(let movieDetail):
            self.movieDetail = movieDetail
            self.view.setupMovieDetail(movieDetail: movieDetail)
        case .failure(let error):
            print(error)
        }
    }
    
}
