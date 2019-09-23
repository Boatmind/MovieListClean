//
//  MovieListModels.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

struct MovieList {
  struct ViewModel {
    struct Movie {
      let title :String
      let id:Int
      let popularity :Double
      let posterPath:String?
      let backdropPath:String?
      let voteAverage:Double
      let voteCount:Int
      var score:Double
    }
    struct Page {
      let page:Int
    }
    
  }
  /// This structure represents a use case
  struct GetMovieList {
    /// Data struct sent to Interactor
    struct Request {
      
    }
    /// Data struct sent to Presenter
    struct Response {
      let movie : [Movie]
      let page: Int
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
  
  struct SetFilter {
    /// Data struct sent to Interactor
    struct Request {
      let filter :String
    }
    /// Data struct sent to Presenter
    struct Response {
      
    }
    /// Data struct sent to ViewController
    struct ViewModel {
    }
  }
  struct SetStatusRefact {
    /// Data struct sent to Interactor
    struct Request {
      let status :String
    }
    /// Data struct sent to Presenter
    struct Response {
      
    }
    /// Data struct sent to ViewController
    struct ViewModel {
    }
  }
  
  struct ReloadTableMovieListAtIndex {
    struct Request {
      let movieId:Int
      let scoreSumAvg:Int
    }
    
    struct Response {
      let movie :[Movie]?
      let movieId:Int
      let scoreSumAvg:Int
    }

  }

}
