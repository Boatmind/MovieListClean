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
  func presentUpdateScore(response: MovieList.UpdateScore.Response)
}

class MovieListPresenter: MovieListPresenterInterface {
 
  weak var viewController: MovieListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMovieList(response: MovieList.GetMovieList.Response) {
    var displayedMovies : [MovieList.DisplayedMovie] = []
    let movie = response.movie
    var sumratting: Double
    
    switch movie {
    case .success(let movie):
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
          
          let displayedMovie = MovieList.DisplayedMovie(title: String(value.title),
                                                        id: value.id ?? 0,
                                                        popularity: String(value.popularity),
                                                        posterPath: poster,
                                                        backdropPath: backdrop,
                                                        voteAverage: String(value.voteAverage),
                                                        voteCount: String(value.voteCount),
                                                        score: String(format: "%.1f", sumratting))
          
          displayedMovies.append(displayedMovie)
          let viewModel = MovieList.GetMovieList.ViewModel(displayedMovies: .success(displayedMovies))
          viewController.displayMovieList(viewModel: viewModel)
        }
    case .failure(let error):
      
      let viewModel = MovieList.GetMovieList.ViewModel(displayedMovies: .failure(error))
      viewController.displayMovieList(viewModel: viewModel)
    }

    
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
  
  
  func presentUpdateScore(response: MovieList.UpdateScore.Response) {
    let movie = response.movie
    let poster = URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")
    let backdrop = URL(string: "https://image.tmdb.org/t/p/original\(movie.backdropPath ?? "")")
    let displayedMovie = MovieList.DisplayedMovie(title: movie.title,
                                                   id: movie.id ?? 0,
                                                   popularity: String(movie.popularity),
                                                   posterPath: poster,
                                                   backdropPath: backdrop,
                                                   voteAverage: String(movie.voteAverage),
                                                   voteCount: String(movie.voteCount),
                                                   score: String(response.score))
    
    let viewModel = MovieList.UpdateScore.ViewModel(displayedMovie: displayedMovie)
    viewController.displayUpdateScore(viewModel: viewModel)
  }
  
  
}
