//
//  Magnum_OpusUITests.swift
//  Magnum OpusUITests
//
//  Created by Cem Kılıç on 27.04.2022.
//

import XCTest

class Magnum_OpusUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("***** UITest: Began ******")
        print("***** UITest: Began ******")
    }

    func splashScreenCheck(){
        XCTAssertTrue(app.isMagnumCatchPrDisplayed)
        XCTAssertTrue(app.isSplashImageDisplayed)
    }
    
    func homePageCheck(){
        XCTAssertTrue(app.isSliderDisplayed)
        XCTAssertTrue(app.isMovieCVOfHomePageDisplayed)
        XCTAssertTrue(app.isMovieCVOfHomePageCellOneDisplayed)
        XCTAssertTrue(app.isSliderCellOneDisplayed)
        XCTAssertTrue(app.isSearchbarDisplayed)
    }
    
    func detailPageCheck(){
        XCTAssertTrue(app.isNameOfMovieDisplayed)
        XCTAssertTrue(app.isMovieCVOfDetailPageDisplayed)
        XCTAssertTrue(app.isMovieCVOfDetailPageCellOneDisplayed)
    }
    
    func searchbarCheck(){
        XCTAssertTrue(app.isMovieCVOfSearchbarDisplayed)
        XCTAssertTrue(app.isMovieCVOfSearchbarCellOneDisplayed)
    }
    
    func test_SplashScreen() throws {
        app.launch()
        
        splashScreenCheck()
        
        sleep(4)
        
        homePageCheck()
        
        app.sliderCellOne.tap()
        
        sleep(2)
        
        detailPageCheck()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        sleep(2)
        
        homePageCheck()
        
        app.movieCVOfHomePageCellOne.tap()
        
        sleep(2)
        
        detailPageCheck()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        sleep(2)
        
        homePageCheck()
        
        app.searchbar.tap()
        
        sleep(1)
        
        app.searchbar.typeText("Batman")
        
        searchbarCheck()
        
        app.movieCVOfSearchbarCellOne.tap()
        
        sleep(1)
        
        detailPageCheck()
        
        XCTAssertTrue(app.nameEqualty)
        
        app.movieCVOfDetailPageCellOne.tap()
        
        sleep(1)
        
        detailPageCheck()
        
        app.launchArguments.append("***** UITest: Seccesfuly Ended ******")
        print("***** UITest: Seccesfuly Ended ******")
    }
}

extension XCUIApplication {
    var magnumCatchPr: XCUIElement! {
        staticTexts.matching(identifier: "magnumCatchPr").element
    }
    
    var isMagnumCatchPrDisplayed: Bool {
        magnumCatchPr.exists
    }
    
    var splashImage: XCUIElement! {
        images.element(matching: .image, identifier: "splashImage")
    }
    
    var isSplashImageDisplayed: Bool {
        splashImage.exists
    }
    
    var slider: XCUIElement! {
        collectionViews.element(matching: .collectionView, identifier: "slider")
    }
    
    var isSliderDisplayed: Bool {
        slider.exists
    }
    
    var sliderCellOne: XCUIElement! {
        slider.cells.element(boundBy: 0)
    }
    
    var isSliderCellOneDisplayed: Bool {
        sliderCellOne.exists
    }
    
    var movieCVOfHomePage: XCUIElement! {
        collectionViews.element(matching: .collectionView, identifier: "movieCVOfHomePage")
    }
    
    var isMovieCVOfHomePageDisplayed: Bool {
        movieCVOfHomePage.exists
    }
    
    var movieCVOfHomePageCellOne: XCUIElement! {
        movieCVOfHomePage.cells.element(boundBy: 0)
    }
    
    var isMovieCVOfHomePageCellOneDisplayed: Bool {
        movieCVOfHomePageCellOne.exists
    }
    
    var nameOfMovie: XCUIElement! {
        staticTexts.matching(identifier: "nameOfMovie").element
    }
    
    var isNameOfMovieDisplayed: Bool {
        nameOfMovie.exists
    }
    
    var searchbar: XCUIElement!{
        otherElements["searchbar"]
    }
    
    var isSearchbarDisplayed: Bool{
        searchbar.exists
    }
    
    var nameEqualty: Bool{
        return nameOfMovie.label.lowercased().contains("batman")
    }
    
    var movieCVOfSearchbar: XCUIElement!{
        collectionViews.element(matching: .collectionView, identifier: "movieCVOfSearchbar")
    }
    
    var isMovieCVOfSearchbarDisplayed: Bool{
        movieCVOfSearchbar.exists
    }
    
    var movieCVOfSearchbarCellOne: XCUIElement!{
        movieCVOfSearchbar.cells.element(boundBy: 0)
    }
    
    var isMovieCVOfSearchbarCellOneDisplayed: Bool{
        movieCVOfSearchbarCellOne.exists
    }
    
    var movieCVOfDetailPage: XCUIElement!{
        collectionViews.element(matching: .collectionView, identifier: "movieCVOfDetailPage")
    }
    
    var isMovieCVOfDetailPageDisplayed: Bool{
        movieCVOfDetailPage.exists
    }
    
    var movieCVOfDetailPageCellOne: XCUIElement!{
        movieCVOfDetailPage.cells.element(boundBy: 0)
    }
    
    var isMovieCVOfDetailPageCellOneDisplayed: Bool{
        movieCVOfDetailPageCellOne.exists
    }
}
