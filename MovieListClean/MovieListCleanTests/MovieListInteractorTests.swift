//
//  MovieListInteractorTests.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 25/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

@testable import MovieListClean
import XCTest

class MovieListInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: MovieListPresenter!
  var movieListPresenterOutputSpy: MovieListPresenterOutputSpy!
  
  class MovieListPresenterOutputSpy: MovieListViewControllerInterface {
    var displayMoviesCalled = false
    var displaySelectedIndexCalled = false
    var displayMoviesViewModel : MovieList.GetMovieList.ViewModel?
    var checkSuceessAndFail : SucessAndFail = .success
    func displayMovieList(viewModel: MovieList.GetMovieList.ViewModel) {
      displayMoviesCalled = true
      displayMoviesViewModel = viewModel
    }
    
    func displayPerformGoToDetailVIew(viewModel: MovieList.SetMovieIndex.ViewModel) {
      
    }
    
    func displaySetFilter(viewModel: MovieList.SetFilter.ViewModel) {
      displayMoviesCalled = true
    }
    
    func displatSetStatus(vieModel: MovieList.SetStatusRefact.ViewModel) {
      displayMoviesCalled = true
    }
    
    func displayUpdateScore(viewModel: MovieList.UpdateScore.ViewModel) {
      
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
        //  XCTAssertEqual(data.first?.popularity, 0.6)
          
        case.failure(let _): break
//          XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (MovieListClean.APIError error 1.)")
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
}

