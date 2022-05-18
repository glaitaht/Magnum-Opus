//
//  Magnum_OpusTests.swift
//  Magnum OpusTests
//
//  Created by Cem Kılıç on 27.04.2022.
//

import XCTest
@testable import Magnum_Opus

class ListViewTest: XCTestCase {
    
    var presenter: ListViewPresenter!
    var view: ListViewMockController!
    var interactor: ListViewMockInteractor!
    
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
        presenter.viewDidLoad()
        XCTAssertTrue(view.isInvokedShowLoading)
        XCTAssertTrue(view.isInvokedSetupViews)
        XCTAssertTrue(interactor.invokedFetchMovie)
        XCTAssertTrue(interactor.invokedFetchSliders)
        XCTAssertTrue(interactor.invokedFetchGenres)
    }
    
    func test_fetchMovies(){
        XCTAssertNil(presenter.movie(0)?.title)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        presenter.fetchMoviesOutput(result: .success(MovieResult.vertical_response))
        presenter.fetchSliderOutput(result: .success(MovieResult.horizontal_response))
        XCTAssertEqual(presenter.movie(0)?.title, "The Outfit")
        XCTAssertEqual(presenter.numberOfItems(), 20)
        XCTAssertEqual(presenter.slider(0)?.title, "Uncharted")
    }
    
}

extension MovieResult {
    static var vertical_response: MovieResult {
        let bundle = Bundle(for: ListViewTest.self)
        let path = bundle.path(forResource: "Vertical", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MovieResult.self, from: data)
        return movieResponse
    }
    
    static var horizontal_response: MovieResult {
        let bundle = Bundle(for: ListViewTest.self)
        let path = bundle.path(forResource: "Horizontal", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MovieResult.self, from: data)
        return movieResponse
    }
}
