//
//  MovieListDetailModels.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

struct MovieListDetail {
  /// This structure represents a use case
  struct GetMovieDetail {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let movieDetail : DetailMovieList?
      let scoreRating : Double
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let displayedMovieDetail: DisplayedMovieDetail
      struct DisplayedMovieDetail {
        let originalTitle:String
        let overview:String?
        let genres:String
        let posterPath: URL?
        let originalLanguage: String?
        let voteAverage:Double?
        var voteCount:Double?
        let scoreRating: Double
      }
    }
  }
  
  struct SetScore {
    /// Data struct sent to Interactor
    struct Request {
        let score :Int
    }
    /// Data struct sent to Presenter
    struct Response {
      let movieId : Int
      let scoreSumAvg : Double
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let movieId :Int
      let scoreSumAvg :Double
    }
  }
  
}
