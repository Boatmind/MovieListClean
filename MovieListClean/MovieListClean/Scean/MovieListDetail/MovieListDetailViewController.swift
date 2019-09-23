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
  func displaySomething(viewModel: MovieListDetail.getMovieDetail.ViewModel.MovieDetail)
  func displayScore(viewModel: MovieListDetail.ShowScoreRating.ViewModel.Score)
  func displaySetScoreValueDefault(viewModel: MovieListDetail.SetscoreValueDefault.ViewModel)
  func displayGetMovieId(viewModel: MovieListDetail.GetMovieId.ViewModel.GetMovieIdAndDelegate)

}

protocol MovieListReloadTableViewAtIndex: class {
  func reloadTableView(movieId:Int,scoreSumAvg:Double)
}

class MovieListDetailViewController: UIViewController, MovieListDetailViewControllerInterface {
  
  var interactor: MovieListDetailInteractorInterface!
  var router: MovieListDetailRouter!
  var movieDetail : MovieListDetail.getMovieDetail.ViewModel.MovieDetail?
  
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
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    let request = MovieListDetail.GetMovieId.Request()
    interactor.getMovieId(request: request)
  }
  
  func cosmosEven() {
       cosMos.didTouchCosmos = { ratting in
       let ratting = Int(ratting)
       let request = MovieListDetail.SetscoreValueDefault.Request(score: ratting)
       self.interactor.setScoreValueDefault(request: request)
//       UserDefaults.standard.set(ratting, forKey: "\()")
    }
  }
  
  func ShowScore() {
       let request = MovieListDetail.ShowScoreRating.Request()
       interactor.showScoreRating(request: request)
  }

  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

    let request = MovieListDetail.getMovieDetail.Request()
    interactor.getMovieDetail(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: MovieListDetail.getMovieDetail.ViewModel.MovieDetail) {
       ShowScore()
       movieDetail = viewModel
    
       DispatchQueue.main.async {
        if let urlposter = self.movieDetail?.posterPath {
           let poster = URL(string: "https://image.tmdb.org/t/p/original\(urlposter)")
           self.movieDetailImageView.kf.setImage(with: poster)
        }
        self.titleLabel.text = self.movieDetail?.originalTitle
        self.detailLabel.text = self.movieDetail?.overview
        //self.catagoryLabel.text = self.movieDetail?.genres?[0].name
        self.lagguartLabel.text = self.movieDetail?.originalLanguage
       }
    
  }
  
  func displayScore(viewModel: MovieListDetail.ShowScoreRating.ViewModel.Score) {
       DispatchQueue.main.async {
        self.cosMos.rating = Double(viewModel.scoreRating)
       }
  }
  
  func displaySetScoreValueDefault(viewModel: MovieListDetail.SetscoreValueDefault.ViewModel) {
    
  }
  
  func displayGetMovieId(viewModel: MovieListDetail.GetMovieId.ViewModel.GetMovieIdAndDelegate) {
       let movieId = viewModel.movieId
       let delegate = viewModel.delegate
       let scoreSumAvg = viewModel.scpreSumAvg
    delegate?.reloadTableView(movieId: movieId, scoreSumAvg: Double(scoreSumAvg))
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToMovieListDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
