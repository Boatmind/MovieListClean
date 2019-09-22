//
//  MovieListDetailPresenter.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit


protocol MovieListDetailPresenterInterface {
  func presentMovieDetail(response: MovieListDetail.getMovieDetail.Response)
  func presentShowScore(response:MovieListDetail.ShowScoreRating.Response)
  func presentSetValueDefault(response:MovieListDetail.SetscoreValueDefault.Response)
  func presentGetMovieId(response:MovieListDetail.GetMovieId.Response)
}

class MovieListDetailPresenter: MovieListDetailPresenterInterface {
  
  weak var viewController: MovieListDetailViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMovieDetail(response: MovieListDetail.getMovieDetail.Response){
    guard let movieDetailItem = response.movieDetail
      else{ return }
    
    
    let viewModel = MovieListDetail.getMovieDetail.ViewModel.MovieDetail(originalTitle: movieDetailItem.originalTitle ?? "", overview: movieDetailItem.overview, genres: movieDetailItem.genres, posterPath: movieDetailItem.posterPath, originalLanguage: movieDetailItem.originalLanguage, voteAverage: movieDetailItem.voteAverage, voteCount: movieDetailItem.voteCount)
    
    viewController.displaySomething(viewModel: viewModel)
  }
  
  func presentShowScore(response: MovieListDetail.ShowScoreRating.Response) {
    
    let score = response.scoreRating
    let viewModel = MovieListDetail.ShowScoreRating.ViewModel.Score(scoreRating: score)
    viewController.displayScore(viewModel: viewModel)
  }
  func presentSetValueDefault(response: MovieListDetail.SetscoreValueDefault.Response) {
    let viewModel = MovieListDetail.SetscoreValueDefault.ViewModel()
    viewController.displaySetScoreValueDefault(viewModel: viewModel)
  }
  
  func presentGetMovieId(response: MovieListDetail.GetMovieId.Response) {
    let movieId = response.movieId
    let delegate = response.delegate
    
    let viewModel = MovieListDetail.GetMovieId.ViewModel.GetMovieIdAndDelegate(movieId: movieId, delegate: delegate)
    
    viewController.displayGetMovieId(viewModel: viewModel)
    
  }
}
