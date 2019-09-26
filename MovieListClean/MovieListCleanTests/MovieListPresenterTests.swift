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
    
    func displayMovieList(viewModel: MovieList.GetMovieList.ViewModel) {
      displayMoviesCalled = true
      displayMoviesViewModel = viewModel
    }
    
    func displayPerformGoToDetailVIew(viewModel: MovieList.SetMovieIndex.ViewModel) {
         displayMoviesCalled = true
    }
    
    func displaySetFilter(viewModel: MovieList.SetFilter.ViewModel) {
      displayMoviesCalled = true
    }
    
    func displatSetStatus(vieModel: MovieList.SetStatusRefact.ViewModel) {
      displayMoviesCalled = true
    }
    
    func displayUpdateScore(viewModel: MovieList.UpdateScore.ViewModel) {
      displayMoviesCalled = true
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
                            backdropPath: "Test backdropPath",
                            posterPath: "Test posterPath",
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
        XCTAssertEqual(data.first?.posterPath, URL(string: "Test posterPath"))
        XCTAssertEqual(data.first?.backdropPath, URL(string: "Test backdropPath"))
        XCTAssertEqual(data.first?.voteAverage, String(10.0))
        XCTAssertEqual(data.first?.score, String(10.0))
        
      case.failure( _): break
        //          XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (MovieListClean.APIError error 1.)")
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
      switch viewModel.displayedMovies {
      case .failure(let error):
        XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (MovieListClean.APIError error 1.)")
      default:
        break
      }
    }
  }
  
  func testDisplaySetFilter() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    // When
    let response = MovieList.SetFilter.Response()
    sut.setFilter(response: response)
    // Then
    XCTAssert(movieListPresenterOutputSpy.displayMoviesCalled)
    
    
  }
  
  func testDisplatSetStatus() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    // When
    let response = MovieList.SetStatusRefact.Response()
    sut.setStatus(response: response)
    // Then
    XCTAssert(movieListPresenterOutputSpy.displayMoviesCalled)
    
    
  }
  func displayUpdateScore() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    //When
    
    
    // Then
    
    
  }
  
  func testdisplayPerformGoToDetailVIew() {
    // Given
    sut.viewController = movieListPresenterOutputSpy
    
    //When
    let response = MovieList.SetMovieIndex.Response()
    sut.setMovieIndex(response: response)
    // Then
    XCTAssert(movieListPresenterOutputSpy.displayMoviesCalled)
  }
}
