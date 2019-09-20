//
//  MovieListDetailWorker.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListDetailStoreProtocol {
  func getData(movieId:Int,_ completion: @escaping (Result<DetailMovieList?, APIError>) -> Void)
}

class MovieListDetailWorker {

  var store: MovieListDetailStoreProtocol

  init(store: MovieListDetailStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(movieId:Int,_ completion: @escaping (Result<DetailMovieList?, APIError>) -> Void) {
    // NOTE: Do the work
    store.getData(movieId: movieId) { result in
      // The worker may perform some small business logic before returning the result to the Interactor
      completion(result)
    }
  }
}
