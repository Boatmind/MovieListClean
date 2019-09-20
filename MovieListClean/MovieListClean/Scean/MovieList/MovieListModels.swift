//
//  MovieListModels.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

struct MovieList {
  /// This structure represents a use case
  struct GetMovieList {
    /// Data struct sent to Interactor
    struct Request {
      
    }
    /// Data struct sent to Presenter
    struct Response {
      let movie : [Movie]
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      struct Movie {
        let title :String
        let id:Int
        let popularity :Double
        let posterPath:String?
        let backdropPath:String?
        let voteAverage:Double
        let voteCount:Int
      }
    }
  }
  
  struct SetMovieIndex {
    /// Data struct sent to Interactor
    struct Request {
      let movieIndex :Int
    }
    /// Data struct sent to Presenter
    struct Response {
      
    }
    /// Data struct sent to ViewController
    struct ViewModel {
    }
  }
}
