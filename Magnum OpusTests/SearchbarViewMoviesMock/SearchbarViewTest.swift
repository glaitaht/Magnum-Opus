//
//  Magnum_OpusTests.swift
//  Magnum OpusTests
//
//  Created by Cem Kılıç on 27.04.2022.
//

import XCTest
@testable import Magnum_Opus

class SearchbarViewTest: XCTestCase {
    
    var presenter: SearchResultPresenter!
    var view: SearchbarViewController!
    var interactor: SearchbarViewMockInteractor!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        presenter = .init(interactor: interactor, view: view)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
    }
    
    func test_viewWillAppear_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertFalse(view.isInvokedHideLoading)
    }
    
    func test_SearchMovie(){
        presenter.fetchSearchedMovie(movieName: "Batman")
        XCTAssertTrue(view.isInvokedShowLoading)
        XCTAssertTrue(interactor.invokedFetchSearchedMovie)
        presenter.fetchSearchedOutput(result: .success(MovieResult.searchbar_response))
        XCTAssertEqual(presenter.movie(0)?.title, "The Batman")
        XCTAssertEqual(presenter.numberOfItems(), 20)
    }
    
}

extension MovieResult {
    static var searchbar_response: MovieResult {
        let bundle = Bundle(for: SearchbarViewTest.self)
        let path = bundle.path(forResource: "Mock", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MovieResult.self, from: data)
        return movieResponse
    }
}

