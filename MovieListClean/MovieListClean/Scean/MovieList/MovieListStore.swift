//
//  MovieListStore.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import Foundation

/*

 The MovieListStore class implements the MovieListStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class MovieListStore: MovieListStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity?, APIError>) -> Void) {
    let apiManager = APIManager()
    apiManager.getMovie() { (result) in
      DispatchQueue.main.sync {
        completion(result)
      }
    }
  
  }
}
