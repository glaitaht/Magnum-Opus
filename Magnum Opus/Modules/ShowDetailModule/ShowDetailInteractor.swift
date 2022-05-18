//
//  ShowDetailInteractor.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 29.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol ShowDetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(ID: Int)
    func fetchSimilarMovies(ID: Int)
}

protocol ShowDetailInteractorOutputProtocol: AnyObject{
    func fetchMovieDetailOutput(result: MovieDetailResultAlias)
    func fetchSimilarMoviesOutput(result: MovieResultAlias)
}

typealias MovieDetailResultAlias = Result<MovieDetailResult,Error> 

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class ShowDetailInteractor {
    weak var presenter: ShowDetailInteractorOutputProtocol?
}

extension ShowDetailInteractor: ShowDetailInteractorProtocol {
    
    func fetchMovieDetail(ID: Int) {
        moviesService.fetchMovieDetail(ID: ID) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.fetchMovieDetailOutput(result: result)
        }
    }
    
    func fetchSimilarMovies(ID: Int) {
        moviesService.fetchSimilarMovies(ID: ID) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.fetchSimilarMoviesOutput(result: result)
        }
    }

}
