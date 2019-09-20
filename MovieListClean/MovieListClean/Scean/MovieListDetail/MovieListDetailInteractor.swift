//
//  MovieListDetailInteractor.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListDetailInteractorInterface {
  func doSomething(request: MovieListDetail.Something.Request)
  var model: DetailMovieList? { get }
}

class MovieListDetailInteractor: MovieListDetailInteractorInterface {
  var presenter: MovieListDetailPresenterInterface!
  var worker: MovieListDetailWorker?
  var model: DetailMovieList?
  var movieIndex :Int?
  // MARK: - Business logic

  func doSomething(request: MovieListDetail.Something.Request) {
    worker?.doSomeWork(movieId: movieIndex ?? 0) { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }

      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = MovieListDetail.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
}
