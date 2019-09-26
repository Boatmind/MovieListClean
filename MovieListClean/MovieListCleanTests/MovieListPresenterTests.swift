//
//  MovieListPresenterTests.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 25/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

@testable import MovieListClean
import XCTest

class MovieListPresenterTests: XCTestCase {

  
  var sut: MovieListPresenter!
  var movieListPresenterOutputSpy: MovieListPresenterOutputSpy!
  
  class MovieListPresenterOutputSpy: MovieListViewControllerInterface {
    var displayMoviesCalled = false
    var displayPerformGoToDetailCalled = false
    var displaySetFilterCalled = false
    var displatSetStatusCalled = false
    var displayUpdateScoreCalled = false
    
    var displayMoviesViewModel : MovieList.GetMovieList.ViewModel?
    var displayMoviesViewUpdate : MovieList.UpdateScore.ViewModel?
    
    func displayMovieList(viewModel: MovieList.GetMovieList.ViewModel) {
      displayMoviesCalled = true
      displayMoviesViewModel = viewModel
    }
    
    func displayPerformGoToDetailVIew(viewModel: MovieList.SetMovieIndex.ViewModel) {
      displayPerformGoToDetailCalled = true
    }
    
    func displaySetFilter(viewModel: MovieList.SetFilter.ViewModel) {
      displaySetFilterCalled = true
    }
    
    func displatSetStatus(vieModel: MovieList.SetStatusRefact.ViewModel) {
      displatSetStatusCalled = true
    }
    
    func displayUpdateScore(viewModel: MovieList.UpdateScore.ViewModel) {
      displayUpdateScoreCalled = true
      displayMoviesViewUpdate = viewModel
    }
    
    // MARK: - Test lifecycle
  }
  override func setUp() {
    super.setUp()
    setupMovieListInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupMovieListInteractor() {
    sut = MovieListPresenter()
    movieListPresenterOutputSpy = MovieListPresenterOutputSpy()
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testDisplayMovieListSuccess() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    // When
    let movieLists = [Movie(popularity: 0.6,
                            id: 1234,
                            video: false,
                            voteCount: 1,
                            voteAverage: 10.0,
                            title: "Test MovieList",
                            releaseDate: "2016-12-31",
                            originalLanguage: "en",
                            originalTitle: "Test originalTitle MovieList",
                            genreIds: [35],
                            backdropPath: "/TestbackdropPath.jpg",
                            posterPath: "/TestposterPath.jpg",
                            adult: false,
                            overview: "Test Overview")]
    
    let response = MovieList.GetMovieList.Response(movie: .success(movieLists), page: 1)
    sut.presentMovieList(response: response)
    
    // Then
    XCTAssert(movieListPresenterOutputSpy.displayMoviesCalled)
    
    if let viewModel = movieListPresenterOutputSpy.displayMoviesViewModel {
      switch viewModel.displayedMovies {
        
      case .success(let data):
        XCTAssertEqual(data.first?.id, 1234)
        XCTAssertEqual(data.first?.popularity, String(0.6))
        XCTAssertEqual(data.first?.voteCount, String(1))
        XCTAssertEqual(data.first?.title, "Test MovieList")
        XCTAssertEqual(data.first?.posterPath, URL(string: "https://image.tmdb.org/t/p/original/TestposterPath.jpg"))
        XCTAssertEqual(data.first?.backdropPath, URL(string: "https://image.tmdb.org/t/p/original/TestbackdropPath.jpg"))
        XCTAssertEqual(data.first?.voteAverage, String(10.0))
        
      case.failure( _):
        XCTFail()
      }
    }
  }
  
  func testDisplayMovieListFailData() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    // When
    
    let request = MovieList.GetMovieList.Response(movie: .failure(APIError.invalidData), page: 1)
    sut.presentMovieList(response: request)
    
    // Then
    XCTAssert(movieListPresenterOutputSpy.displayMoviesCalled)
    if let viewModel = movieListPresenterOutputSpy.displayMoviesViewModel {
      var isFail = false
      switch viewModel.displayedMovies {
      case .failure:
        isFail = true
      default:
        isFail = false
      }
      XCTAssertTrue(isFail)
    }
  }
  func testDisplayMovieListFailJson() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    // When
    
    let request = MovieList.GetMovieList.Response(movie: .failure(APIError.invalidJSON), page: 1)
    sut.presentMovieList(response: request)
    
    // Then
    XCTAssert(movieListPresenterOutputSpy.displayMoviesCalled)
    if let viewModel = movieListPresenterOutputSpy.displayMoviesViewModel {
      var isFail = false
      switch viewModel.displayedMovies {
      case .failure:
        isFail = true
      default:
        isFail = false
      }
      XCTAssertTrue(isFail)
    }
  }
  
  func testDisplaySetFilter() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    // When
    let response = MovieList.SetFilter.Response()
    sut.setFilter(response: response)
    // Then
    XCTAssert(movieListPresenterOutputSpy.displaySetFilterCalled)
    
    
  }
  
  func testDisplaySetStatus() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    // When
    let response = MovieList.SetStatusRefact.Response()
    sut.setStatus(response: response)
    // Then
    XCTAssert(movieListPresenterOutputSpy.displatSetStatusCalled)
    
    
  }
  func testdisplayUpdateScore() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    //When
    let movieAtIndex = Movie(popularity: 0.9,
                             id: 123,
                             video: false,
                             voteCount: 1,
                             voteAverage: 13,
                             title: "TestUpdate title",
                             releaseDate: "updatereleseData",
                             originalLanguage: "en",
                             originalTitle: "TestUpdate original",
                             genreIds: [2],
                             backdropPath: "/TestUpdatebackdrop.jpg",
                             posterPath: "/TestUpdatePosterParth.jpg",
                             adult: true,
                             overview: "TestOverview")
    
    let response = MovieList.UpdateScore.Response(movie: movieAtIndex, score: 8)
    sut.presentUpdateScore(response: response)
    
    // Then
    XCTAssertTrue(movieListPresenterOutputSpy.displayUpdateScoreCalled)
    if let viewModel = movieListPresenterOutputSpy.displayMoviesViewUpdate {
       let movieData = viewModel.displayedMovie
           XCTAssertEqual(movieData.id, 123)
           XCTAssertEqual(movieData.popularity, String(0.9))
           XCTAssertEqual(movieData.voteCount, String(1))
           XCTAssertEqual(movieData.title, "TestUpdate title")
           XCTAssertEqual(movieData.posterPath, URL(string: "https://image.tmdb.org/t/p/original/TestUpdatePosterParth.jpg"))
           XCTAssertEqual(movieData.backdropPath, URL(string: "https://image.tmdb.org/t/p/original/TestUpdatebackdrop.jpg"))
           XCTAssertEqual(movieData.voteAverage, String(13.0))
           XCTAssertEqual(movieData.score, String(8.0))
      
    }
  }
  
  func testdisplayPerformGoToDetailVIew() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    //When
    let response = MovieList.SetMovieIndex.Response()
    sut.setMovieIndex(response: response)
    // Then
    XCTAssert(movieListPresenterOutputSpy.displayPerformGoToDetailCalled)
  }
}
