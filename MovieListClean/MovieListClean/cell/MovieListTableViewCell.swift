//
//  MovieListTableViewCell.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright © 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

  
  @IBOutlet weak var movieImageView: UIImageView!
  
  @IBOutlet weak var titileLabel: UILabel!
  
  @IBOutlet weak var popularityLabel: UILabel!
  
  @IBOutlet weak var starImageVIew: UIImageView!
  
  @IBOutlet weak var backDropImageView: UIImageView!
  
  func setUI(movieatIndex : MovieList.GetMovieList.ViewModel.Movie) {
    
       titileLabel.text = movieatIndex.title
       popularityLabel.text = String(movieatIndex.popularity)
    
    if let urlmovie = movieatIndex.posterPath , let urlbackDrop = movieatIndex.backdropPath {
      let poster = URL(string: "https://image.tmdb.org/t/p/original\( urlmovie)")
      let backdrop = URL(string: "https://image.tmdb.org/t/p/original\(urlbackDrop)")
      
    }
  }
  
}
