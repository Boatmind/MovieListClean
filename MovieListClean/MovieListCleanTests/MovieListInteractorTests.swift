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
    var presentMovieListCalled = false
    var setIndexCalled = false
    var setFilterCalled = false
    var setStatusRefectCalled = false
    var updateMovieScoreCalled = false
    
    func presentMovieList(response: MovieList.GetMovieList.Response) {
      presentMovieListCalled = true
     
    }
    
    func setMovieIndex(response: MovieList.SetMovieIndex.Response) {
      setIndexCalled = true
    }
    
    func setFilter(response: MovieList.SetFilter.Response) {
      setFilterCalled = true
    }
    
    func setStatus(response: MovieList.SetStatusRefact.Response) {
      setStatusRefectCalled = true
    }
    
    func presentUpdateScore(response: MovieList.UpdateScore.Response) {
      updateMovieScoreCalled = true
    }
    
  }
  
  class MovieListWorkerOutputSpy : MovieListWorker{
    
    var doSomeWorkCalledBySuceess = false
    var doSomeWorkCalledByFaild = false
    var forcesError = false
    
    override func doSomeWork(page: Int, fiter: Filter, _ completion: @escaping (Result<Entity?, APIError>) -> Void) {
    
      if forcesError {
        doSomeWorkCalledByFaild = true
        completion(Result<Entity?,APIError>.failure(APIError.invalidData))
      } else {
        doSomeWorkCalledBySuceess = true
        completion(Result<Entity?,APIError>.success(Entity(page: 0,
                                                           totalPages: 0,
                                                           results: [Movie(popularity: 0.0,
                                                                           id: 0,
                                                                           video: true,
                                                                           voteCount: 0,
                                                                           voteAverage: 0.0,
                                                                           title: "",
                                                                           releaseDate: "",
                                                                           originalLanguage: "",
                                                                           originalTitle: "",
                                                                           genreIds: [0],
                                                                           backdropPath: "",
                                                                           posterPath: "",
                                                                           adult: true,
                                                                           overview: "")])))
      }
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
  
  func testInteractorShouldPresentMovieListBySuscees() {
    
    // Given
    sut.worker = movieListWorkerOutputSpy
    sut.presenter = movieListPresenterOutputSpy
    movieListWorkerOutputSpy.forcesError = false
    // When
    let request = MovieList.GetMovieList.Request()
    sut.getMovieList(request: request)
    
    // Then
    XCTAssert(movieListWorkerOutputSpy.doSomeWorkCalledBySuceess)
    XCTAssert(movieListPresenterOutputSpy.presentMovieListCalled)
    
  }
  func testInteractorShouldPresentMovieListByfaild() {
    
    // Given
    sut.worker = movieListWorkerOutputSpy
    sut.presenter = movieListPresenterOutputSpy
    movieListWorkerOutputSpy.forcesError = true
    // When
    let request = MovieList.GetMovieList.Request()
    sut.getMovieList(request: request)
    
    // Then
    XCTAssert(movieListWorkerOutputSpy.doSomeWorkCalledByFaild)
    XCTAssert(movieListPresenterOutputSpy.presentMovieListCalled)
    
  }
  
  func testInteractorShouldPresentSetMovieIndex() {
    // Given
    sut.presenter = movieListPresenterOutputSpy
    
    // When
    
    let request = MovieList.SetMovieIndex.Request(movieIndex: 0)
    sut.setIndexForPerform(request: request)
    
    // then
    XCTAssert(movieListPresenterOutputSpy.setIndexCalled)
  }
  func testInteractorShouldPresentSetFilterIsDesc() {
    // Given
    sut.presenter = movieListPresenterOutputSpy
    
    // When
    
    let request = MovieList.SetFilter.Request(filter: "desc")
    sut.setFilter(request: request)
    
    // then
    XCTAssert(movieListPresenterOutputSpy.setFilterCalled)
  }
  func testInteractorShouldPresentSetFilterIsAsc() {
    // Given
    sut.presenter = movieListPresenterOutputSpy
    
    // When
    
    let request = MovieList.SetFilter.Request(filter: "asc")
    sut.setFilter(request: request)
    
    // then
    XCTAssert(movieListPresenterOutputSpy.setFilterCalled)
  }
  
  func testInteractorShouldPresentSetStatusRefectCalled() {
    // Given
    sut.presenter = movieListPresenterOutputSpy
    
    // When
    let request = MovieList.SetStatusRefact.Request()
    sut.setStatusRefect(request: request)
    
    // Then
    XCTAssert(movieListPresenterOutputSpy.setStatusRefectCalled)
  }
  
  func testInteractorShouldPresentUpdateMovieScore() {
    // Given
    sut.presenter = movieListPresenterOutputSpy
    sut.model = [Movie(popularity: 0.2,
                       id: 194079,
                       video: false,
                       voteCount: 1,
                       voteAverage: 10.0,
                       title: "TestUpdateInteractor",
                       releaseDate: "2016",
                       originalLanguage: "en",
                       originalTitle: "Title",
                       genreIds: [2],
                       backdropPath: "back.jpg",
                       posterPath: "post.jpg",
                       adult: true,
                       overview: "overview")]
    
    // When
    let request = MovieList.UpdateScore.Request(movieId: 194079, scoreSumAvg: 9)
    sut.updateMovieScore(request: request)
    
    // Then
    XCTAssert(movieListPresenterOutputSpy.updateMovieScoreCalled)
  }
  
}
