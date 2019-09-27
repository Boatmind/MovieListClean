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
  func updateMovieScore(request: MovieList.UpdateScore.Request)
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
          let response = MovieList.GetMovieList.Response(movie: .success(self?.model ?? []), page: self?.page ?? 0)
          
          self?.presenter.presentMovieList(response: response)
          self?.page += 1
        }
        
      case .failure(let error):
        
        let response = MovieList.GetMovieList.Response(movie: .failure(error), page: self?.page ?? 0)
        self?.presenter.presentMovieList(response: response)
      }
    }
  }
  
  func setIndexForPerform(request: MovieList.SetMovieIndex.Request) {
    movieIndex = request.movieIndex
    
    let response = MovieList.SetMovieIndex.Response()
    presenter.setMovieIndex(response:response)
  }
  
  func setFilter(request: MovieList.SetFilter.Request) {

    if request.filter == "desc"{
      filter = .desc
      page = 1
    }else{
      filter = .asc
      page = 1
    }
    let response = MovieList.SetFilter.Response()
    presenter.setFilter(response: response)
  }
  
  func setStatusRefect(request: MovieList.SetStatusRefact.Request) {
    
    status = .on
    page = 1
    let response = MovieList.SetStatusRefact.Response()
    presenter.setStatus(response: response)
  }
  
  func updateMovieScore(request: MovieList.UpdateScore.Request) {
    let scoreSumAvg = request.scoreSumAvg
    
    guard let movie = model.first(where: { $0.id == request.movieId }) else { return }
    let response = MovieList.UpdateScore.Response(movie: movie, score: scoreSumAvg)
    presenter.presentUpdateScore(response: response)
  }
  
}
