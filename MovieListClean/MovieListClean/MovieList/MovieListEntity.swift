//
//  MovieListEntity.swift
//  MovieListClean
//
//  Created by Pawee Kittiwathanakul on 19/9/2562 BE.
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

struct Entity:Codable {
  var page:Int
  var totalPages:Int
  var results: [Movie]
  // var genre_ids:[String] = []
  private enum CodingKeys: String, CodingKey {
    case page
    case totalPages = "total_pages"
    case results
  }
}

struct Movie: Codable {
  var popularity:Double
  var id:Int?
  var video:Bool
  var voteCount:Int
  var voteAverage:Double
  var title:String
  var releaseDate:String
  var originalLanguage:String
  var originalTitle:String
  var backdropPath:String?
  var posterPath:String?
  private enum CodingKeys: String, CodingKey {
    case popularity
    case id
    case video
    case voteCount = "vote_count"
    case voteAverage = "vote_average"
    case title
    case releaseDate = "release_date"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case backdropPath = "backdrop_path"
    case posterPath = "poster_path"
  }
}
