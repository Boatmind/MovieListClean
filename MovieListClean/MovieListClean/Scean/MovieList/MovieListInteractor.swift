//
//  MovieListInteractor.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListInteractorInterface {
  func getMovieList(request: MovieList.GetMovieList.Request)
  func setIndexForPerform(request: MovieList.SetMovieIndex.Request)
  func setFilter(request: MovieList.SetFilter.Request)
  func setStatusRefect(request:MovieList.SetStatusRefact.Request)
  func reLoadMovieListAtIndex(request:MovieList.ReloadTableMovieListAtIndex.Request)
  var model: [Movie] { get }
  var movieIndex: Int? { get }
}

class MovieListInteractor: MovieListInteractorInterface {
 
  var presenter: MovieListPresenterInterface!
  var worker: MovieListWorker?
  var model: [Movie] = []
  var movieIndex :Int?
  var page :Int = 1
  var filter:Filter? = nil
  var status:Status = .off
  
  // MARK: - Business logic

  func getMovieList(request: MovieList.GetMovieList.Request) {
    worker?.doSomeWork(page: page, fiter: filter ?? .desc) { [weak self] apiResponse in
      switch apiResponse {
      case .success(let movie):
        if let movie = movie {
          self?.status = .off
          if self?.page == 1{
             self?.model = movie.results
          }else {
             self?.model.append(contentsOf: movie.results)
          }
          
          
           let response = MovieList.GetMovieList.Response(movie: movie.results, page: self?.page ?? 0)
           self?.presenter.presentMovieList(response: response)
           self?.page += 1
        }
        
      case .failure(let error):
        print(error) // show error
      }
    }
  }
  
  func setIndexForPerform(request: MovieList.SetMovieIndex.Request) {
      self.movieIndex = request.movieIndex
      
      let response = MovieList.SetMovieIndex.Response()
      self.presenter.setMovieIndex(response:response)
  }
  
  func setFilter(request: MovieList.SetFilter.Request) {
    
    if request.filter == "desc"{
       self.filter = .desc
       self.page = 1
    }else{
       self.filter = .asc
       self.page = 1
    }
    let response = MovieList.SetFilter.Response()
    presenter.setFilter(response: response)
  }
  
  func setStatusRefect(request: MovieList.SetStatusRefact.Request) {
    if request.status == "on"{
       self.status = .on
       self.page = 1
    }else{
       self.status = .off
    }
    let response = MovieList.SetStatusRefact.Response()
    presenter.setStatus(response: response)
  }
  func reLoadMovieListAtIndex(request: MovieList.ReloadTableMovieListAtIndex.Request) {
    let response = MovieList.ReloadTableMovieListAtIndex.Response(movie: self.model, movieId: request.movieId, scoreSumAvg: request.scoreSumAvg)
    self.presenter.reLoadMovieListAtIndex(response: response)
  }
  
  
}
