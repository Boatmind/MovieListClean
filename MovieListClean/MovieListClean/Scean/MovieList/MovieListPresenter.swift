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
  func reLoadMovieListAtIndex(response: MovieList.ReloadTableMovieListAtIndex.Response)
}

class MovieListPresenter: MovieListPresenterInterface {
 
  weak var viewController: MovieListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMovieList(response: MovieList.GetMovieList.Response) {
    var viewModel : [MovieList.ViewModel.Movie] = []
    let movie = response.movie
    var sumratting: Double
    
    for value in movie {
      
      if UserDefaults.standard.double(forKey: "\(value.id ?? 0)") == 0.0 {
       
        if value.voteCount == 0 {
           sumratting = (Double(value.voteAverage)) * Double(value.voteCount)
        }else{
           sumratting = (Double(value.voteAverage)) * Double(value.voteCount) / Double(value.voteCount)
        }
      }else {
        sumratting = UserDefaults.standard.double(forKey: "\(value.id ?? 0)")
      }
      let poster = URL(string: "https://image.tmdb.org/t/p/original\(value.posterPath ?? "")")
      let backdrop = URL(string: "https://image.tmdb.org/t/p/original\(value.backdropPath ?? "")")
      
      let movieViewModel = MovieList.ViewModel.Movie(title: String(value.title), id: value.id ?? 0, popularity: String(value.popularity), posterPath: poster, backdropPath: backdrop, voteAverage: String(value.voteAverage), voteCount: String(value.voteCount), score: String(format: "%.2f", sumratting))
      
      viewModel.append(movieViewModel)
      
    }
    
    viewController.displayMovieList(viewModel: viewModel)
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
  
  func reLoadMovieListAtIndex(response: MovieList.ReloadTableMovieListAtIndex.Response) {
    if let movie = response.movie {
      var viewModel : [MovieList.ViewModel.Movie] = []
      var sumratting: Double
      for value in movie {
        
        if UserDefaults.standard.integer(forKey: "\(value.id ?? 0)") == 0 {
          
          if value.voteCount == 0 {
            sumratting = (Double(value.voteAverage)) * Double(value.voteCount)
          }else{
            sumratting = (Double(value.voteAverage)) * Double(value.voteCount) / Double(value.voteCount)
          }
        }else {
          sumratting = UserDefaults.standard.double(forKey: "\(value.id ?? 0)")
        }
        
        let poster = URL(string: "https://image.tmdb.org/t/p/original\(value.posterPath ?? "")")
        let backdrop = URL(string: "https://image.tmdb.org/t/p/original\(value.backdropPath ?? "")")
        
        
        let movieViewModel = MovieList.ViewModel.Movie(title: value.title,
                                                       id: value.id ?? 0,
                                                       popularity: String(value.popularity),
                                                       posterPath: poster,
                                                       backdropPath: backdrop,
                                                       voteAverage: String(value.voteAverage),
                                                       voteCount: String(value.voteCount), score: String(format: "%.2f", sumratting))
        
        viewModel.append(movieViewModel)
        
      }
      viewController.displayReloadMovieListAtIndex(viewModel: viewModel)
    }
  }
  
  
}
