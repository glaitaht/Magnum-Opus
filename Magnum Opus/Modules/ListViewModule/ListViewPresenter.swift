//
//  ListViewPresenter.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 27.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol ListViewPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> Movie?
    func didSelectRowAt(index: Int, type: Bool)
    func slider(_ index: Int) -> Movie?
    func getPageInfo() -> (Int,Int)
    func fetchNewPage(page: FetchingOptions)
}

enum FetchingOptions{
    case nextPage
    case previousPage
}

final class ListViewPresenter {

    unowned var view: ListViewControllerProtocol
    let router: ListViewRouterProtocol?
    let interactor: ListViewInteractorProtocol?
    
    var activePage = 0
    private var movieResult: [MovieResult] = []
    private var sliderResult: MovieResult?
    private var genreDic: [Int:String] = [:]

    init(interactor: ListViewInteractorProtocol, router: ListViewRouterProtocol? = nil, view: ListViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        if let router = router{
            self.router = router
        }
        else{
            self.router = nil
        }
    }
    
    private func fetchMovies() {
        view.showLoadingView()
        interactor?.fetchMovies(page: activePage+1)
    }
    
    private func fetchGenres()  {
        view.showLoadingView()
        interactor?.fetchGenres()
    }
    
    private func fetchSlider() {
        view.showLoadingView()
        interactor?.fetchSlider()
    }
    
    private func genresToDictonary(genres: [Genre]){
        for genre in genres{
            if let id = genre.id, let name = genre.name{
                genreDic[id] = name
            }
        }
    }
    
    private func addGenres(){
        for i in 0..<(movieResult[activePage].results?.count ?? 0){
            if let genres = movieResult[activePage].results?[i].genreIDS{
                var genreToAdd: [String] = []
                for genre in genres{
                    genreToAdd.append(genreDic[genre] ?? "unknown")
                }
                movieResult[activePage].results?[i].genres = genreToAdd
            }
        }
    }
    
    func getView() -> ListViewController {
        return view as! ListViewController
    }
    
    private func navigateToDetail(movie: Movie){
        router?.navigateToDetail(route: .detail(movie: movie))
    }
}

extension ListViewPresenter: ListViewPresenterProtocol {
    
    func fetchNewPage(page: FetchingOptions) {
        switch page{
        case .nextPage:
            if movieResult.count > activePage+1{
                activePage += 1
                self.view.reloadData()
            }
            else if let totalPage = movieResult.first?.totalPages, movieResult.count < totalPage{
                activePage += 1
                fetchMovies()
            }
        case .previousPage:
            if activePage == 0{
                print("error: no way")
            }
            else{
                activePage -= 1
                self.view.reloadData()
            }
        }
        
    }

    func getPageInfo() -> (Int,Int) {
        return (activePage, movieResult.first?.totalPages ?? 0)
    }
    
    
    func viewDidLoad() {
        view.setupViews()
        fetchGenres()
        fetchSlider()
        fetchMovies()
    }
    
    func numberOfItems() -> Int {
        if movieResult.count > activePage, let movies = movieResult[activePage].results{
            return movies.count
        }
        return 0
    }
    
    func movie(_ index: Int) -> Movie? {
        if movieResult.count > activePage , let movies = movieResult[activePage].results{
            return movies[safe: index]
        }
        return nil
    }
    
    func slider(_ index: Int) -> Movie? {
        if let movie = sliderResult?.results![safe: index] {
            return movie
        }
        else{
            return nil
        }
    }
    
    func didSelectRowAt(index: Int, type: Bool) {
        if type{
            if let movie = movie(index) {
                navigateToDetail(movie: movie)
            }
        }
        else{//false for slider
            if let movie = slider(index) {
                navigateToDetail(movie: movie)
            }
        }
    }
    
}

extension ListViewPresenter: ListViewInteractorOutputProtocol{
    
    func fetchMoviesOutput(result: MovieResultAlias) {
        self.view.hideLoadingView()
        switch result {
        case .success(let movieResult):
            self.movieResult.append(movieResult)
            self.addGenres()
            self.view.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchGenresOutput(result: GenreResultAlias) {
        self.view.hideLoadingView()
        switch result {
        case .success(let genres):
            if let genresArray = genres.genres{
                self.genresToDictonary(genres: genresArray)
            }
        case .failure(let error):
            print(error)
        }
    }
     
    func fetchSliderOutput(result: MovieResultAlias) {
        self.view.hideLoadingView()
        switch result {
        case .success(let movies):
            self.sliderResult = movies
            view.reloadSlider()
        case .failure(let error):
            print(error)
        }
    }
    
}
