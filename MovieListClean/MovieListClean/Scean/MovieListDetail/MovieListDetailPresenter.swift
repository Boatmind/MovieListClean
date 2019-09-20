//
//  MovieListDetailPresenter.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import UIKit

protocol MovieListDetailPresenterInterface {
  func presentSomething(response: MovieListDetail.Something.Response)
}

class MovieListDetailPresenter: MovieListDetailPresenterInterface {
  weak var viewController: MovieListDetailViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: MovieListDetail.Something.Response) {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.

    let viewModel = MovieListDetail.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
}
