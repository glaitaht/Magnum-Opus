//
//  ListViewInteractor.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 27.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol ListViewInteractorProtocol: AnyObject {
    func fetchMovies(page: Int)
    func fetchGenres()
    func fetchSlider()
}

protocol ListViewInteractorOutputProtocol: AnyObject{
    func fetchMoviesOutput(result: MovieResultAlias)
    func fetchGenresOutput(result: GenreResultAlias)
    func fetchSliderOutput(result: MovieResultAlias)
}

typealias MovieResultAlias = Result<MovieResult, Error>
typealias GenreResultAlias = Result<GenreResult, Error>

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class ListViewInteractor {
    weak var presenter: ListViewInteractorOutputProtocol?
}

extension ListViewInteractor: ListViewInteractorProtocol {
    func fetchGenres() {
        moviesService.fetchGenres { [weak self] result in
            guard let self = self else { return }
            self.presenter?.fetchGenresOutput(result: result)
        }
    }
    
    func fetchMovies(page: Int) {
        moviesService.fetchMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.fetchMoviesOutput(result: result)
        }
    }
    
    func fetchSlider(){
        moviesService.fetchSlider { [weak self] result in
            guard let self = self else { return }
            self.presenter?.fetchSliderOutput(result: result)
        }
    }
}
