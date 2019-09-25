//
//  MovieListModels.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

struct MovieList {
  
  struct DisplayedMovie {
    let title :String
    let id:Int
    let popularity: String
    let posterPath: URL?
    let backdropPath: URL?
    let voteAverage: String
    let voteCount: String
    var score: String
  }
  
  /// This structure represents a use case
  struct GetMovieList {
    /// Data struct sent to Interactor
    struct Request {
    }
    /// Data struct sent to Presenter
    struct Response {
      let movie : Result<[Movie], Error>
      let page: Int
    }
    
    struct ViewModel {
      let displayedMovies: Result<[DisplayedMovie], Error>
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
     
    }
    /// Data struct sent to Presenter
    struct Response {
      
    }
    /// Data struct sent to ViewController
    struct ViewModel {
    }
  }
  
  struct UpdateScore {
    struct Request {
      let movieId:Int
      let scoreSumAvg:Double
    }
    
    struct Response {
      let movie : Movie
      let score : Double
    }

    struct ViewModel {
      let displayedMovie: DisplayedMovie
    }
  }

}
