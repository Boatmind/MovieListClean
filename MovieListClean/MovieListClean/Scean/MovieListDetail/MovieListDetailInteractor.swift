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
  func showScoreRating(request: MovieListDetail.ShowScoreRating.Request)
  func setScoreValueDefault(request: MovieListDetail.SetscoreValueDefault.Request)
  func getMovieId(request: MovieListDetail.GetMovieId.Request)
  var model: DetailMovieList? { get }
  var movieId : Int? { get set }
  var delegate :MovieListReloadTableViewAtIndex? {get set}
}

class MovieListDetailInteractor: MovieListDetailInteractorInterface {

  var presenter: MovieListDetailPresenterInterface!
  var worker: MovieListDetailWorker?
  var model: DetailMovieList?
  var movieId: Int?
  var delegate :MovieListReloadTableViewAtIndex?
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
  
  func setScoreValueDefault(request: MovieListDetail.SetscoreValueDefault.Request){
    let scoreRating = request.score
    if let model = model, let movieId = movieId {
      if scoreRating != 0 {
        let sumratting1 = (Int(model.voteAverage ?? 0) * Int(model.voteCount ?? 0)) + Int(scoreRating * 2)
        let sumratting2 = Int(model.voteCount ?? 0) + 1
        let ansScore = sumratting1 / sumratting2
        // set Score Average at forkey is movieId
        UserDefaults.standard.set(ansScore, forKey: "\(movieId)")
      }
    }
    
  }
  
  func showScoreRating(request: MovieListDetail.ShowScoreRating.Request){
    if let movieId = movieId {
      
      let scoreRating = UserDefaults.standard.integer(forKey: "\(movieId)")
      
      if  scoreRating == 0 {
        let response = MovieListDetail.ShowScoreRating.Response(scoreRating: scoreRating)
        presenter.presentShowScore(response: response)
      }else {
        let sumratting1 = scoreRating * (Int(model?.voteCount ?? 0) + 1)
        let sumratting2 = (Int(model?.voteAverage ?? 0) * Int(model?.voteCount ?? 0))
        let ansShowScore = (sumratting1 - sumratting2) / 2
        let response = MovieListDetail.ShowScoreRating.Response(scoreRating: ansShowScore)
        presenter.presentShowScore(response: response)
        
      }
    }
  }
  
  func getMovieId(request: MovieListDetail.GetMovieId.Request) {
    if let movieId = movieId , let delegate = delegate {
      let scoreRating = UserDefaults.standard.integer(forKey: "\(movieId)")
      
      let response = MovieListDetail.GetMovieId.Response(movieId: movieId, delegate: delegate, scoreSumAvg: scoreRating)
      presenter.presentGetMovieId(response: response)
    }
  }
}
