//
//  MovieListDetailEntity.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 20/9/2562 BE.
//  Copyright (c) 2562 Pawee Kittiwathanakul. All rights reserved.
//

import Foundation

/*

 The Entity class is the business object.
 The Result enumeration is the domain model.

 1. Rename this file to the desired name of the model.
 2. Rename the Entity class with the desired name of the model.
 3. Move this file to the Models folder.
 4. If the project already has a declaration of Result enumeration, you may remove the declaration from this file.
 5. Remove the following comments from this file.

 */


struct DetailMovieList :Codable{
  var originalTitle:String?
  var overview:String?
  var genres:[genresDetail]?
  var posterPath:String?
  var originalLanguage: String?
  var voteAverage:Double?
  var voteCount:Double?
  
  private enum CodingKeys: String, CodingKey {
    case originalTitle = "original_title"
    case overview
    case genres
    case posterPath = "poster_path"
    case originalLanguage = "original_language"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    
  }
}
struct genresDetail:Codable {
  var name:String?
}
