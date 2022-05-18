//
//  ListViewMockInteractor.swift
//  Magnum OpusTests
//
//  Created by Cem Kılıç on 2.05.2022.
//

import Foundation
@testable import Magnum_Opus

final class ListViewMockInteractor: ListViewInteractorProtocol {
    
    var invokedFetchMovie = false
    var invokedFetchGenres = false
    var invokedFetchSliders = false
    var invokedFetchMovieCount = 0
    
    func fetchMovies(page: Int) {
        self.invokedFetchMovie = true
    }
    
    func fetchGenres() {
        self.invokedFetchGenres = true
    }
    
    func fetchSlider() {
        self.invokedFetchSliders = true
    }
    
    
}
