//
//  MovieListDetailInteractor.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListDetailInteractorInterface {
  func getMovieDetail(request: MovieListDetail.getMovieDetail.Request)
  var model: DetailMovieList? { get }
  var movieId : Int? { get set }
}

class MovieListDetailInteractor: MovieListDetailInteractorInterface {
  
  
  var presenter: MovieListDetailPresenterInterface!
  var worker: MovieListDetailWorker?
  var model: DetailMovieList?
  var movieId: Int?
  // MARK: - Business logic
  
  func getMovieDetail(request: MovieListDetail.getMovieDetail.Request) {
    if let movieId = movieId {
      worker?.getMovieDetail(movieId: movieId) { [weak self] apiResponse in
        switch apiResponse {
        case .success(let movieDetail):
          if let movieDetail = movieDetail {
            self?.model = movieDetail
            let valueDefaults = UserDefaults.standard.integer(forKey: "\(self?.movieId ?? 0)")
            
            let response = MovieListDetail.getMovieDetail.Response(movieDetail: movieDetail, valueDefalust: valueDefaults)
            self?.presenter.presentMovieDetail(response: response)
          }
          
        case .failure(let error):
          print(error) // show error
        }
      }
    }
  }
}
