//
//  MovieListDetailInteractor.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListDetailInteractorInterface {
  func getMovieDetail(request: MovieListDetail.GetMovieDetail.Request)
  func setMovieScore(request: MovieListDetail.SetScore.Request)
  var movieId : Int? { get set }
}

class MovieListDetailInteractor: MovieListDetailInteractorInterface {

  var presenter: MovieListDetailPresenterInterface!
  var worker: MovieListDetailWorker?
  var model: DetailMovieList?
  var movieId: Int?

  // MARK: - Business logic
  
  func getMovieDetail(request: MovieListDetail.GetMovieDetail.Request) {
    
    if let movieId = movieId {
      worker?.getMovieDetail(movieId: movieId) { [weak self] apiResponse in
        switch apiResponse {
        case .success(let movieDetail):
          if let movieDetail = movieDetail {
            self?.model = movieDetail
            var scoreRating = UserDefaults.standard.double(forKey: "\(movieId)")
            if scoreRating > 0.0 {
              let sumratting1 = Double(scoreRating) * (Double(movieDetail.voteCount ?? 0) + 1)
              let sumratting2 = (Double(movieDetail.voteAverage ?? 0) * Double(movieDetail.voteCount ?? 0))
              let ansShowScore = (sumratting1 - sumratting2) / 2
              scoreRating = ansShowScore
            }
            let response = MovieListDetail.GetMovieDetail.Response(movieDetail: .success(movieDetail), scoreRating: scoreRating)
            self?.presenter.presentMovieDetail(response: response)
          }
          
        case .failure(let error):
          print(error) // show error
        }
      }
    }
  }
  
  func setMovieScore(request: MovieListDetail.SetScore.Request){
    let scoreRating = request.score
    if let model = model, let movieId = movieId {
      if scoreRating != 0 {
        let sumratting1 = (model.voteAverage ?? 0) * Double(model.voteCount ?? 0) + Double(scoreRating * 2)
        let sumratting2 = Double(model.voteCount ?? 0) + 1
        let ansScore = sumratting1 / sumratting2
        let ans = String(format: "%.2f", ansScore)
        // set Score Average at forkey is movieId
        UserDefaults.standard.set(ans, forKey: "\(movieId)")
        let response = MovieListDetail.SetScore.Response(movieId: movieId, scoreSumAvg: ansScore)
        presenter.presentMovieScore(response: response)
      }
    }
    
  }
}
