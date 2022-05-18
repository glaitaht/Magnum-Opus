//
//  SearchResultInteractor.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 28.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol SearchResultInteractorProtocol: AnyObject {
    func fetchSearchedMovie(movieName: String)
}

protocol SearchResultInteractorOutputProtocol: AnyObject {
    func fetchSearchedOutput(result: MovieResultAlias)
}

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class SearchResultInteractor {
    weak var presenter: SearchResultInteractorOutputProtocol?
}

extension SearchResultInteractor: SearchResultInteractorProtocol {
    func fetchSearchedMovie(movieName: String){
        moviesService.fetchSearchedMovies(name: movieName) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.fetchSearchedOutput(result: result)
        }
    }
}
