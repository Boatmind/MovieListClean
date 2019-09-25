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

  // MARK: - Subject under test

  var sut: MovieListPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMovieListPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMovieListPresenter() {
    sut = MovieListPresenter()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
