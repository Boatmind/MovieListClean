//
//  MovieListWorker.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListStoreProtocol {
  func getData(page:Int,filter:Filter,_ completion: @escaping (Result<Entity?, APIError>) -> Void)
}

class MovieListWorker {

  var store: MovieListStoreProtocol

  init(store: MovieListStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(page:Int,fiter:Filter,_ completion: @escaping (Result<Entity?, APIError>) -> Void) {
    // NOTE: Do the work
    store.getData(page: page, filter: fiter) { result in
      completion(result)
    }
    
  }
}
