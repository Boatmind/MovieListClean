//
//  MoVieList2InteractorTests.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 26/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

@testable import MovieListClean
import XCTest

class MovieListInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: MovieListInteractor!
  var movieListPresenterOutputSpy: MovieListInteractorOutputSpy!
  var movieListWorkerOutputSpy: MovieListWorkerOutputSpy!
  
  class MovieListInteractorOutputSpy: MovieListPresenterInterface {
    var presenterMoviesCalled = false
    
    func presentMovieList(response: MovieList.GetMovieList.Response) {
         presenterMoviesCalled = true
      
    }
    
    func setMovieIndex(response: MovieList.SetMovieIndex.Response) {
      //
    }
    
    func setFilter(response: MovieList.SetFilter.Response) {
      //
    }
    
    func setStatus(response: MovieList.SetStatusRefact.Response) {
      //
    }
    
    func presentUpdateScore(response: MovieList.UpdateScore.Response) {
      //
    }
    
  }
  
  class MovieListWorkerOutputSpy : MovieListWorker{
    
    var doSomeWorkCalled = false
    override func doSomeWork(page: Int, fiter: Filter, _ completion: @escaping (Result<Entity?, APIError>) -> Void) {
      doSomeWorkCalled = true
      completion(Result<Entity?, APIError>.success(Entity(page: 0, totalPages: 0, results: [Movie(popularity: 0.0, id: 0, video: true, voteCount: 0, voteAverage: 0.0, title: "", releaseDate: "", originalLanguage: "", originalTitle: "", genreIds: [0], backdropPath: "", posterPath: "", adult: true, overview: "")])))
    }
  }
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupMovieListInteractor()
    
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupMovieListInteractor() {
    sut = MovieListInteractor()
    movieListPresenterOutputSpy = MovieListInteractorOutputSpy()
    movieListWorkerOutputSpy = MovieListWorkerOutputSpy(store: MovieListStore())
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testSomething() {
    // Given
    sut.worker = movieListWorkerOutputSpy
    sut.presenter = movieListPresenterOutputSpy
    // When
    let request = MovieList.GetMovieList.Request()
    sut.getMovieList(request: request)
    
    // Then
    XCTAssert(movieListWorkerOutputSpy.doSomeWorkCalled)
    XCTAssert(movieListPresenterOutputSpy.presenterMoviesCalled)
  }
}
