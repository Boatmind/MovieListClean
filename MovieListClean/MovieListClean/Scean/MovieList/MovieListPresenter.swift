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
  func setFilter(response: MovieList.SetFilter.Response)
  func setStatus(response: MovieList.SetStatusRefact.Response)
}

class MovieListPresenter: MovieListPresenterInterface {
 
  weak var viewController: MovieListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMovieList(response: MovieList.GetMovieList.Response) {
    var viewModel : [MovieList.ViewModel.Movie] = []
    let movie = response.movie
    var sumratting: Int
    
    for value in movie {
      
      if UserDefaults.standard.integer(forKey: "\(value.id ?? 0)") == 0 {
       
        if value.voteCount == 0 {
           sumratting = (Int(value.voteAverage)) * value.voteCount
        }else{
           sumratting = (Int(value.voteAverage)) * value.voteCount / value.voteCount
        }
      }else {
        
        sumratting = UserDefaults.standard.integer(forKey: "\(value.id ?? 0)")

      }
      
      let movieViewModel = MovieList.ViewModel.Movie(title: value.title, id: value.id ?? 0, popularity: value.popularity, posterPath: value.posterPath, backdropPath: value.backdropPath, voteAverage: value.voteAverage, voteCount: value.voteCount, score: sumratting)
      
      viewModel.append(movieViewModel)
      
    }
    
    let pageViewModel = MovieList.ViewModel.Page(page: response.page)
    
    
    viewController.displayMovieList(viewModel: viewModel, page: pageViewModel)
  }
  
  func setMovieIndex(response: MovieList.SetMovieIndex.Response) {
    let viewModel = MovieList.SetMovieIndex.ViewModel()
    viewController.displayPerformGoToDetailVIew(viewModel: viewModel)
  }
  
  func setFilter(response: MovieList.SetFilter.Response) {
    let viewModel = MovieList.SetFilter.ViewModel()
    viewController.displaySetFilter(viewModel: viewModel)
    
  }
  func setStatus(response: MovieList.SetStatusRefact.Response) {
    let viewModel = MovieList.SetStatusRefact.ViewModel()
    viewController.displatSetStatus(vieModel: viewModel)
  }
  
}
