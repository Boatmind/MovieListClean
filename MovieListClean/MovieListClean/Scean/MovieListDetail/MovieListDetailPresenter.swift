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
}
