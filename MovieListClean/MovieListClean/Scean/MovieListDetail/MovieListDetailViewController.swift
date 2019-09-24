//
//  MovieListDetailViewController.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit
import Cosmos
protocol MovieListDetailViewControllerInterface: class {
  func displayMovieDetail(viewModel: MovieListDetail.GetMovieDetail.ViewModel)
  func displaySetMovieScore(viewModel: MovieListDetail.SetScore.ViewModel)
}

protocol MovieListReloadTableViewAtIndex: class {
  func reloadTableView(movieId:Int,scoreSumAvg:Double)
}

class MovieListDetailViewController: UIViewController, MovieListDetailViewControllerInterface {
  
  var interactor: MovieListDetailInteractorInterface!
  var router: MovieListDetailRouter!
  var delegate :MovieListReloadTableViewAtIndex?
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var detailLabel: UILabel!
  
  @IBOutlet weak var catagoryLabel: UILabel!
  
  @IBOutlet weak var lagguartLabel: UILabel!
  
  @IBOutlet weak var movieDetailImageView: UIImageView!
  
  @IBOutlet weak var cosMos: CosmosView!
  
  
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: MovieListDetailViewController) {
    let router = MovieListDetailRouter()
    router.viewController = viewController

    let presenter = MovieListDetailPresenter()
    presenter.viewController = viewController

    let interactor = MovieListDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = MovieListDetailWorker(store: MovieListDetailStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    doSomethingOnLoad()
    cosmosEven()
    
  }
  
  func cosmosEven() {
       cosMos.didTouchCosmos = { ratting in
       let ratting = Int(ratting)
       let request = MovieListDetail.SetScore.Request(score: ratting)
       self.interactor.setMovieScore(request: request)
    }
  }
  
  // MARK: - Event handling

  func doSomethingOnLoad() {
    let request = MovieListDetail.GetMovieDetail.Request()
    interactor.getMovieDetail(request: request)
  }

  // MARK: - Display logic
  
  func displayMovieDetail(viewModel: MovieListDetail.GetMovieDetail.ViewModel) {
    let displayedMovieDetail = viewModel.displayedMovieDetail
    if let urlposter = displayedMovieDetail.posterPath {
      movieDetailImageView.kf.setImage(with: urlposter)
    }
    titleLabel.text = displayedMovieDetail.originalTitle
    detailLabel.text = displayedMovieDetail.overview
    catagoryLabel.text = displayedMovieDetail.genres
    lagguartLabel.text = displayedMovieDetail.originalLanguage
    cosMos.rating = displayedMovieDetail.scoreRating
  }
  
  func displaySetMovieScore(viewModel: MovieListDetail.SetScore.ViewModel) {
    let movieId = viewModel.movieId
    let scoreSumAvg = viewModel.scoreSumAvg
    delegate?.reloadTableView(movieId: movieId, scoreSumAvg: Double(scoreSumAvg))
  }
}
