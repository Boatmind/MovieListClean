//
//  MovieListViewController.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListViewControllerInterface: class {
  func displayMovieList(viewModel: [MovieList.ViewModel.Movie],page:MovieList.ViewModel.Page)
  func displayPerformGoToDetailVIew(viewModel:MovieList.SetMovieIndex.ViewModel)
  func displaySetFilter(viewModel:MovieList.SetFilter.ViewModel)
  func displatSetStatus(vieModel:MovieList.SetStatusRefact.ViewModel)
  func displayReloadMovieListAtIndex(viewModel:[MovieList.ViewModel.Movie])
}

class MovieListViewController: UIViewController, MovieListViewControllerInterface {
 
  var interactor: MovieListInteractorInterface!
  var router: MovieListRouter!
  var movieList :[MovieList.ViewModel.Movie] = []
  var refreshControl = UIRefreshControl()
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var loadingView: UIView!
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
    setRefreshControl()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  @IBAction func filterMovieList(_ sender: Any) {
    
    let alert = UIAlertController(title: "Saved", message: "Selected Frame is Saved", preferredStyle: .alert)
    
      alert.addAction(UIAlertAction(title: "DESC", style:.default , handler: { (UIAlertAction) in
      let request = MovieList.SetFilter.Request(filter: "desc")
      self.interactor.setFilter(request: request)
        
//      alert.editButtonItem.isEnabled = false
      
    }))
    alert.addAction(UIAlertAction(title: "ABSC", style:.default , handler: { (UIAlertAction) in
      let request = MovieList.SetFilter.Request(filter: "asc")
      self.interactor.setFilter(request: request)
//      alert.editButtonItem.isEnabled = false
      
    }))
    alert.addAction(UIAlertAction(title: "Cancle", style:.default , handler: { (UIAlertAction) in
      
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  func setRefreshControl() {
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
  }
  @objc func refresh(sender:AnyObject) {
    // Code to refresh table view
      let request = MovieList.SetStatusRefact.Request()
      interactor.setStatusRefect(request: request)
  }
  
  
  // MARK: - Event handling
  
  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work
    DispatchQueue.main.async {
    self.loadingView.isHidden = false
    }
    let request = MovieList.GetMovieList.Request()
    interactor.getMovieList(request: request)
  }

  
  // MARK: - Display logic
  
  func displayMovieList(viewModel: [MovieList.ViewModel.Movie],page:MovieList.ViewModel.Page) {
    if page.page == 1 {
       movieList = viewModel
    }else {
       movieList.append(contentsOf: viewModel)
    }
    
    print("Page is :\(page.page) and MovieList is \(self.movieList.count)")
    self.loadingView.isHidden = true
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  func displayPerformGoToDetailVIew(viewModel: MovieList.SetMovieIndex.ViewModel) {
    router.navigateToSomewhere()
  }
  
  func displaySetFilter(viewModel: MovieList.SetFilter.ViewModel) {
    doSomethingOnLoad()
    
  }
  
  func displatSetStatus(vieModel: MovieList.SetStatusRefact.ViewModel) {
    doSomethingOnLoad()
    DispatchQueue.main.async {
      self.refreshControl.endRefreshing()
    }
  }
  
  func displayReloadMovieListAtIndex(viewModel: [MovieList.ViewModel.Movie]) {
    movieList = viewModel
    tableView.reloadData()
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
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if indexPath.row == movieList.count - 1 && loadingView.isHidden{
      doSomethingOnLoad()
    }
  }
  
  
}

extension MovieListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let request = MovieList.SetMovieIndex.Request(movieIndex: indexPath.row)
    
    interactor.setIndexForPerform(request: request)
  }
}

extension MovieListViewController : MovieListReloadTableViewAtIndex {
  func reloadTableView(movieId: Int, scoreSumAvg: Double) {
    for (index , value) in movieList.enumerated(){
      if movieId == value.id {
        movieList[index].score = Double(scoreSumAvg)
      }
    }
    tableView.reloadData()
  }
}
