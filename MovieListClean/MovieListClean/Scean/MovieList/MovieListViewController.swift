//
//  MovieListViewController.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListViewControllerInterface: class {
  func displayMovieList(viewModel: [MovieList.GetMovieList.ViewModel.Movie])
  func displayPerformGoToDetailVIew(viewModel:MovieList.SetMovieIndex.ViewModel)
}

class MovieListViewController: UIViewController, MovieListViewControllerInterface {
  
  
  var interactor: MovieListInteractorInterface!
  var router: MovieListRouter!
  var movieList :[MovieList.GetMovieList.ViewModel.Movie] = []
  
  @IBOutlet weak var tableView: UITableView!
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: MovieListViewController) {
    let router = MovieListRouter()
    router.viewController = viewController

    let presenter = MovieListPresenter()
    presenter.viewController = viewController

    let interactor = MovieListInteractor()
    interactor.presenter = presenter
    interactor.worker = MovieListWorker(store: MovieListStore())

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

    let request = MovieList.GetMovieList.Request()
    interactor.getMovieList(request: request)
  }

  // MARK: - Display logic

  func displayMovieList(viewModel: [MovieList.GetMovieList.ViewModel.Movie]) {
      movieList = viewModel
      tableView.reloadData()
  }
  func displayPerformGoToDetailVIew(viewModel: MovieList.SetMovieIndex.ViewModel) {
      router.navigateToSomewhere()
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToMovieListViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

extension MovieListViewController :UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return movieList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell  else {
        return UITableViewCell()
    }
    let movieAtindex = movieList[indexPath.row]
    cell.setUI(movieatIndex: movieAtindex)
    return cell
  }
  
  
}

extension MovieListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let request = MovieList.SetMovieIndex.Request(movieIndex: indexPath.row)
    
        interactor.setIndexForPerform(request: request)
  }
}
