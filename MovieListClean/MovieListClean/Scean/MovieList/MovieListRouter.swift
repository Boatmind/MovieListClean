//
//  MovieListRouter.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListRouterInput {
  func navigateToSomewhere()
}

class MovieListRouter: MovieListRouterInput {
  weak var viewController: MovieListViewController!

  // MARK: - Navigation

  func navigateToSomewhere() {
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:

    // 1. Trigger a storyboard segue
    viewController.performSegue(withIdentifier: "MovieListGoToMovieDetail", sender: nil)

    // 2. Present another view controller programmatically
    // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)

    // 3. Ask the navigation controller to push another view controller onto the stack
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)

    // 4. Present a view controller from a different storyboard
    // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
    // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
  }

  // MARK: - Communication

  func passDataToNextScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router which scenes it can communicate with

    if segue.identifier == "MovieListGoToMovieDetail" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router how to pass data to the next scene

    guard let movieDetailViewController = segue.destination as? MovieListDetailViewController, let index = viewController.interactor.movieIndex else {
      
      return
    }
    movieDetailViewController.interactor.movieId = viewController.interactor.model[index].id
    movieDetailViewController.delegate = viewController
  }
}
