//
//  MovieListInteractor.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListInteractorInterface {
  func doSomething(request: MovieList.GetMovieList.Request)
  var model: Movie? { get }
}

class MovieListInteractor: MovieListInteractorInterface {
  var presenter: MovieListPresenterInterface!
  var worker: MovieListWorker?
  var model: Movie?

  // MARK: - Business logic

  func doSomething(request: MovieList.GetMovieList.Request) {
    
    worker?.doSomeWork() { [weak self] apiResponse in
      switch apiResponse {
      case .success(let movie):
        if let movie = movie {
          
          
           let response = MovieList.GetMovieList.Response(movie: movie.results)
           self?.presenter.presentMovieList(response: response)
        }
        
       
      case .failure(let error):
        print(error) // show error
      }
    }
  }
}
