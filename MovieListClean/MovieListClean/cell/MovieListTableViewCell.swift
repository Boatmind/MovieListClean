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
  func setUI(movieatIndex : MovieList.ViewModel.Movie) {
    
    titileLabel.text = movieatIndex.title
    popularityLabel.text = String(movieatIndex.popularity)
    scoreRatingLabel.text = movieatIndex.score
    movieImageView.kf.setImage(with: movieatIndex.posterPath)
    backDropImageView.kf.setImage(with: movieatIndex.backdropPath)
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    movieImageView.image = nil
    backDropImageView.image = nil
  }
  
}
