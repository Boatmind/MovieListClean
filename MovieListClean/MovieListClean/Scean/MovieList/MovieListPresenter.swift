//
//  MovieListPresenter.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListPresenterInterface {
  func presentMovieList(response: MovieList.GetMovieList.Response)
  func setMovieIndex(response: MovieList.SetMovieIndex.Response)
}

class MovieListPresenter: MovieListPresenterInterface {
  weak var viewController: MovieListViewControllerInterface!

  // MARK: - Presentation logic

  func presentMovieList(response: MovieList.GetMovieList.Response) {
    var viewModel : [MovieList.GetMovieList.ViewModel.Movie] = []
    let movie = response.movie
    
    for value in movie {
      let movieViewModel = MovieList.GetMovieList.ViewModel.Movie(title: value.title, id: value.id ?? 0, popularity: value.popularity, posterPath: value.posterPath, backdropPath: value.backdropPath, voteAverage: value.voteAverage, voteCount: value.voteCount)
      
        viewModel.append(movieViewModel)
    }
    
    viewController.displayMovieList(viewModel: viewModel)
  }
  
  func setMovieIndex(response: MovieList.SetMovieIndex.Response) {
       let viewModel = MovieList.SetMovieIndex.ViewModel()
       viewController.displayPerformGoToDetailVIew(viewModel: viewModel)
  }
}
