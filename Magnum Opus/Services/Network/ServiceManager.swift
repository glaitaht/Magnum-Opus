//
//  ServiceManager.swift
//  ViperNews
//
//  Created by Egitim on 22.04.2022.
//

import Foundation


protocol MoviesServiceProtocol {
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResultAlias) -> ())
    func fetchGenres(completionHandler: @escaping (GenreResultAlias) -> ())
    func fetchSlider(completionHandler: @escaping (MovieResultAlias) -> ())
    func fetchSearchedMovies(name: String,completionHandler: @escaping (MovieResultAlias) -> ())
    func fetchMovieDetail(ID: Int,completionHandler: @escaping (MovieDetailResultAlias) -> ())
    func fetchSimilarMovies(ID: Int,completionHandler: @escaping (MovieResultAlias) -> ())
}

struct MoviesService: MoviesServiceProtocol {
    
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResultAlias) -> ()) {
        NetworkManager.shared.request(Router.upcoming(page: page), decodeToType: MovieResult.self, completionHandler: completionHandler)
    }
    
    func fetchGenres(completionHandler: @escaping (GenreResultAlias) -> ()) {
        NetworkManager.shared.request(Router.genre, decodeToType: GenreResult.self, completionHandler: completionHandler)
    }
    func fetchSlider(completionHandler: @escaping (MovieResultAlias) -> ()) {
        NetworkManager.shared.request(Router.sliderNowplaying, decodeToType: MovieResult.self, completionHandler: completionHandler)
    }
    func fetchSearchedMovies(name: String, completionHandler: @escaping (MovieResultAlias) -> ()) {
        NetworkManager.shared.request(Router.searchedMovie(name: name), decodeToType: MovieResult.self, completionHandler: completionHandler)
    }
    
    func fetchMovieDetail(ID: Int, completionHandler: @escaping (MovieDetailResultAlias) -> ()) {
        NetworkManager.shared.request(Router.movieDetail(movieID: ID), decodeToType: MovieDetailResult.self, completionHandler: completionHandler)
    }
    
    func fetchSimilarMovies(ID: Int, completionHandler: @escaping (MovieResultAlias) -> ()) {
        NetworkManager.shared.request(Router.movieDetailSimilar(movieID: ID), decodeToType: MovieResult.self, completionHandler: completionHandler)
    }
    
    
}
