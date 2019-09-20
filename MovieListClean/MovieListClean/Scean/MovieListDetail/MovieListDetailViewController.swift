//
//  MovieListDetailViewController.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListDetailViewControllerInterface: class {
  func displaySomething(viewModel: MovieListDetail.getMovieDetail.ViewModel.MovieDetail)
}

class MovieListDetailViewController: UIViewController, MovieListDetailViewControllerInterface {
  var interactor: MovieListDetailInteractorInterface!
  var router: MovieListDetailRouter!
  var movieDetail : MovieListDetail.getMovieDetail.ViewModel.MovieDetail?
  
  @IBOutlet weak var titleLabel: UILabel!
  
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
  }

  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

    let request = MovieListDetail.getMovieDetail.Request()
    interactor.getMovieDetail(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: MovieListDetail.getMovieDetail.ViewModel.MovieDetail) {
       movieDetail = viewModel
    
       DispatchQueue.main.async {
        
        self.titleLabel.text = self.movieDetail?.originalTitle
       }
    
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
