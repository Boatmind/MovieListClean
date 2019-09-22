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
  struct getMovieDetail {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let movieDetail : DetailMovieList?
      let valueDefalust :Int
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      
      struct MovieDetail {
        let originalTitle:String
        let overview:String?
        let genres:[genresDetail]?
        let posterPath:String?
        let originalLanguage: String?
        let voteAverage:Double?
        var voteCount:Double?
        
      }
    }
  }
  
  struct SetscoreValueDefault {
    /// Data struct sent to Interactor
    struct Request {
           let score :Int
    }
    /// Data struct sent to Presenter
    struct Response {
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      
    }
  }
  struct ShowScoreRating {
    /// Data struct sent to Interactor
    struct Request {
    }
    /// Data struct sent to Presenter
    struct Response {
      let scoreRating : Int
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      struct Score {
             let scoreRating :Int
      }
      
      
    }
  }
  
  struct GetMovieId {
    /// Data struct sent to Interactor
    struct Request {
    }
    /// Data struct sent to Presenter
    struct Response {
      let movieId : Int
      let delegate: MovieListReloadTableViewAtIndex?
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      struct GetMovieIdAndDelegate {
        let movieId :Int
        let delegate: MovieListReloadTableViewAtIndex?
      }
    }
  }
}
