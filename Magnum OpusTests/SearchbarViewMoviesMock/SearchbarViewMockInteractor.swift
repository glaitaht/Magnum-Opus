//
//  SearchbarViewMockInteractor.swift
//  Magnum OpusTests
//
//  Created by Cem Kılıç on 2.05.2022.
//

import Foundation
@testable import Magnum_Opus

final class SearchbarViewMockInteractor: SearchResultInteractorProtocol {
    
    func fetchSearchedMovie(movieName: String) {
        self.invokedFetchSearchedMovie = true
    }
    var invokedFetchSearchedMovie = false
    var invokedFetchMovieCount = 0
    
}
