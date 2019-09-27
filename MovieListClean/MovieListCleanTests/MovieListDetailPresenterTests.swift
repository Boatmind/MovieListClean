//
//  MovieListDetailPresenterTests.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 27/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

@testable import MovieListClean
import XCTest

class MovieListDetailPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: MovieListDetailPresenter!
  var movieListDetailViewControllerOutputSpy : MovieListDetailViewControllerOutputSpy!

  // MARK: - Test lifecycle
  
  class MovieListDetailViewControllerOutputSpy : MovieListDetailViewControllerInterface {
    var displayMovieDetailCalled = false
    var displaySetMovieScoreCalled = false
  
    var displayMovieDetail : MovieListDetail.GetMovieDetail.ViewModel?
    var displaySetMovieScore : MovieListDetail.SetScore.ViewModel?
    func displayMovieDetail(viewModel: MovieListDetail.GetMovieDetail.ViewModel) {
         displayMovieDetailCalled = true
         displayMovieDetail = viewModel
    }
    
    func displaySetMovieScore(viewModel: MovieListDetail.SetScore.ViewModel) {
         displaySetMovieScoreCalled = true
         displaySetMovieScore = viewModel
    }
    
    
  }

  override func setUp() {
    super.setUp()
    setupMovieListDetailPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMovieListDetailPresenter() {
    presenter = MovieListDetailPresenter()
    movieListDetailViewControllerOutputSpy = MovieListDetailViewControllerOutputSpy()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testPesenterShouldDisplayMovieDetail() {
    // Given
    presenter.viewController = movieListDetailViewControllerOutputSpy
    // When
    
    let movieDetail = DetailMovieList(originalTitle: "TestDetail", overview: "TestDetailOverview", genres: [genresDetail(name: "TH")], posterPath: "/TestPosterPath", originalLanguage: "TestOriginal", voteAverage: 10.0, voteCount: 1.0)
    
    let response = MovieListDetail.GetMovieDetail.Response(movieDetail: .success(movieDetail), scoreRating: 4.0)
    presenter.presentMovieDetail(response: response)

    // Then
    XCTAssert(movieListDetailViewControllerOutputSpy.displayMovieDetailCalled)
    if let viewModel = movieListDetailViewControllerOutputSpy.displayMovieDetail {
      switch viewModel.displayedMovieDetail {
      case .success(let movieListDetail) :
           XCTAssertEqual(movieListDetail.originalTitle, "TestDetail")
           XCTAssertEqual(movieListDetail.overview, "TestDetailOverview")
           XCTAssertEqual(movieListDetail.genres, "TH")
        XCTAssertEqual(movieListDetail.posterPath,  URL(string: "https://image.tmdb.org/t/p/original/TestPosterPath"))
        XCTAssertEqual(movieListDetail.voteAverage, 10.0)
        XCTAssertEqual(movieListDetail.scoreRating, 4.0)
        XCTAssertEqual(movieListDetail.originalLanguage, "TestOriginal")
      default :
        XCTFail()
      }
    }
    
  }
  
  func testPesenterShouldDisplaySetMovieScore() {
    //Given
    presenter.viewController = movieListDetailViewControllerOutputSpy
    
    // When
    let response = MovieListDetail.SetScore.Response(movieId: 194079, scoreSumAvg: 9.0)
    presenter.presentMovieScore(response: response)
    
    // Then
    XCTAssert(movieListDetailViewControllerOutputSpy.displaySetMovieScoreCalled)
    if let viewModel = movieListDetailViewControllerOutputSpy.displaySetMovieScore {
       XCTAssertEqual(viewModel.movieId, 194079)
       XCTAssertEqual(viewModel.scoreSumAvg, 9.0)
    }
  }
  
}
