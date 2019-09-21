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
    
//    if response.valueDefalust == 0 { // if movieDetail dont click
//      var sumratting: Int
//      if movieDetailItem.voteCount == 0{
//        sumratting = (Int(movieDetailItem.voteAverage ?? 0) * Int(movieDetailItem.voteCount ?? 0))
//      }else{
//        sumratting = (Int(movieDetailItem.voteAverage ?? 0) * Int(movieDetailItem.voteCount ?? 0)) / Int(movieDetailItem.voteCount ?? 1)
//      }
//    }else {
//      let sumratting = response.valueDefalust
//      let ans = sumratting
//    }
    
    for value in movie {
      let sumratting:Int
      if UserDefaults.standard.integer(forKey: "\(value.id ?? 0)") == 0 {
        if value.voteCount == 0 {
           sumratting = (Int(value.voteAverage) * (value.voteCount))
        }else{
         sumratting = (Int(value.voteAverage) * (value.voteCount)) / Int(value.voteCount)
        }
      }else {
         sumratting = UserDefaults.standard.integer(forKey: "\(value.id ?? 0)")
      }
      let movieViewModel = MovieList.GetMovieList.ViewModel.Movie(title: value.title, id: value.id ?? 0, popularity: value.popularity, posterPath: value.posterPath, backdropPath: value.backdropPath, voteAverage: value.voteAverage, voteCount: value.voteCount, valueScore: sumratting)
      
        viewModel.append(movieViewModel)
    }
    
    viewController.displayMovieList(viewModel: viewModel)
  }
  
  func setMovieIndex(response: MovieList.SetMovieIndex.Response) {
       let viewModel = MovieList.SetMovieIndex.ViewModel()
       viewController.displayPerformGoToDetailVIew(viewModel: viewModel)
  }
}
