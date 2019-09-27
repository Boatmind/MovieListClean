//
//  MovieListDetailInteractorTests.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 27/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

@testable import MovieListClean
import XCTest
enum isCheckTypeError : String {
  case invalidJSON
  case invalidData
}
class MovieListDetailInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var interactor: MovieListDetailInteractor!
  var movieListDetailWorkerOutputSpy : MovieListDetailWorkerOutputSpy!
  var movieListDetailPresenterOutputSpy : MovieListDetailPresenterOutputSpy!
  // MARK: - Test lifecycle
  
  class MovieListDetailPresenterOutputSpy : MovieListDetailPresenterInterface {
    var presentMovieListDetailCalled = false
    var presentMovieScoreCalled = false
    
    func presentMovieDetail(response: MovieListDetail.GetMovieDetail.Response) {
         presentMovieListDetailCalled = true
    }
    
    func presentMovieScore(response: MovieListDetail.SetScore.Response) {
         presentMovieScoreCalled = true
    }
    
    
  }
  class MovieListDetailWorkerOutputSpy : MovieListDetailWorker {
    var getMovieDetailCalledSuceess = false
    var getMovieDetailCalledFailue = false
    var isError = false
    var isTypeError : isCheckTypeError = .invalidData
    override func getMovieDetail(movieId: Int, _ completion: @escaping (Result<DetailMovieList?, APIError>) -> Void) {
      
      if isError{
        getMovieDetailCalledFailue = true
        switch isTypeError {
        case .invalidData:
          completion(.failure(APIError.invalidData))
        case .invalidJSON:
          completion(.failure(APIError.invalidJSON))
        }
        // End if isError
      }else {
        getMovieDetailCalledSuceess = true
        completion(Result<DetailMovieList?, APIError>.success(DetailMovieList(
          originalTitle: "TestOriginalTitile",
          overview: "TestOverView",
          genres: [genresDetail(name: "Catagory")],
          posterPath: "Testposter.jpg",
          originalLanguage: "TestoriginalLanguage",
          voteAverage: 10.0,
          voteCount: 1.0)))
      }
    }
  }
  
  override func setUp() {
    super.setUp()
    setupMovieListDetailInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupMovieListDetailInteractor() {
    interactor = MovieListDetailInteractor()
    movieListDetailWorkerOutputSpy = MovieListDetailWorkerOutputSpy(store: MovieListDetailStore())
    movieListDetailPresenterOutputSpy = MovieListDetailPresenterOutputSpy()
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testInteractorShouldPresentMovieDetailBySuceess() {
    // Given
    interactor.worker = movieListDetailWorkerOutputSpy
    interactor.presenter = movieListDetailPresenterOutputSpy
    movieListDetailWorkerOutputSpy.isError = false
    interactor.movieId = 194079
    
    // When
    
    let request = MovieListDetail.GetMovieDetail.Request()
    interactor.getMovieDetail(request: request)
    
    // Then
    XCTAssert(movieListDetailWorkerOutputSpy.getMovieDetailCalledSuceess)
    XCTAssert(movieListDetailPresenterOutputSpy.presentMovieListDetailCalled)
  }
  
  func testInteractorShouldPresentMovieScore() {
    
    //Given
    interactor.presenter = movieListDetailPresenterOutputSpy
    interactor.model = DetailMovieList(originalTitle: "TestoriginalTitle",
                                       overview: "Test", genres: [genresDetail(name: "Th")], posterPath: "TestPosterparth",
                                       originalLanguage: "TestOriginalLanguage",
                                       voteAverage: 10.0,
                                       voteCount: 1.0)
    interactor.movieId = 194079
    
    
    // When
    let request = MovieListDetail.SetScore.Request(score: 8)
    interactor.setMovieScore(request: request)
    
    // Then
    
    XCTAssert(movieListDetailPresenterOutputSpy.presentMovieScoreCalled)
  }
}
