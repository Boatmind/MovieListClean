//
//  MovieListTableViewCell.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright © 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit
import Kingfisher
class MovieListTableViewCell: UITableViewCell {

  
  @IBOutlet weak var movieImageView: UIImageView!
  
  @IBOutlet weak var titileLabel: UILabel!
  
  @IBOutlet weak var popularityLabel: UILabel!
  
  @IBOutlet weak var starImageVIew: UIImageView!
  
  @IBOutlet weak var backDropImageView: UIImageView!
  
  @IBOutlet weak var scoreRatingLabel: UILabel!
  
  var score:Double = 0
  func setUI(movieatIndex : MovieList.GetMovieList.ViewModel.Movie) {
    
       titileLabel.text = movieatIndex.title
       popularityLabel.text = String(movieatIndex.popularity)
    
    if let urlmovie = movieatIndex.posterPath , let urlbackDrop = movieatIndex.backdropPath {
      let poster = URL(string: "https://image.tmdb.org/t/p/original\( urlmovie)")
      let backdrop = URL(string: "https://image.tmdb.org/t/p/original\(urlbackDrop)")
      
          movieImageView.kf.setImage(with: poster)
          backDropImageView.kf.setImage(with: backdrop)
    }
    
    if score > 0 {
      let sumratting = (Int(movieatIndex.voteAverage) * Int(movieatIndex.voteCount)) + Int(score * 2)
      let sumratting2 = Int(movieatIndex.voteCount + 1)
      let ans = sumratting / sumratting2
      scoreRatingLabel.text = String(ans)
    }else {
      var sumratting: Int
      if Int(movieatIndex.voteCount) == 0 {
        sumratting = (Int(movieatIndex.voteAverage) * Int(movieatIndex.voteCount))
      }else {
        sumratting = (Int(movieatIndex.voteAverage) * Int(movieatIndex.voteCount)) / Int(movieatIndex.voteCount)
      }
      scoreRatingLabel.text = String(sumratting)
    }

  }
  
}
