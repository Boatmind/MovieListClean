//
//  MovieListDetailStore.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import Foundation

/*

 The MovieListDetailStore class implements the MovieListDetailStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class MovieListDetailStore: MovieListDetailStoreProtocol {
  
  
  func getData(movieId:Int,_ completion: @escaping (Result<DetailMovieList?, APIError>) -> Void) {
      let apiManager = APIManager()
    apiManager.getDetailMovie(movieIndex: movieId) { (result) in
      completion(result)
    }
  }
}
