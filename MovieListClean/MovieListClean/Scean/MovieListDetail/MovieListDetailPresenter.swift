//
//  MovieListDetailPresenter.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit


protocol MovieListDetailPresenterInterface {
  func presentMovieDetail(response: MovieListDetail.GetMovieDetail.Response)
  func presentMovieScore(response:MovieListDetail.SetScore.Response)
}

class MovieListDetailPresenter: MovieListDetailPresenterInterface {
  
  weak var viewController: MovieListDetailViewControllerInterface!

  
  // MARK: - Presentation logic
  
  func presentMovieDetail(response: MovieListDetail.GetMovieDetail.Response){
    guard let movieDetailItem = response.movieDetail
      else{ return }
    var valueCatagory = ""
    if let gen = movieDetailItem.genres {
     valueCatagory = gen.map{$0.name!}.joined(separator: ", ")
    }
    let displayedMovieDetail = MovieListDetail.GetMovieDetail.ViewModel.DisplayedMovieDetail(
      originalTitle: movieDetailItem.originalTitle ?? "",
      overview: movieDetailItem.overview,
      genres: valueCatagory,
      posterPath: URL(string: "https://image.tmdb.org/t/p/original\(movieDetailItem.posterPath ?? "")"),
      originalLanguage: movieDetailItem.originalLanguage,
      voteAverage: movieDetailItem.voteAverage,
      voteCount: movieDetailItem.voteCount,
      scoreRating: response.scoreRating)
    let viewModel = MovieListDetail.GetMovieDetail.ViewModel(displayedMovieDetail: displayedMovieDetail)
    viewController.displayMovieDetail(viewModel: viewModel)
  }
  
  func presentMovieScore(response:MovieListDetail.SetScore.Response) {
    let movieId = response.movieId
    let scoreSumAvg = response.scoreSumAvg
    let viewModel = MovieListDetail.SetScore.ViewModel(movieId: movieId, scoreSumAvg: scoreSumAvg)
    viewController.displaySetMovieScore(viewModel: viewModel)
  }
}
