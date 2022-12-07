//
//  URLs.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import Foundation

//MARK: - URL Constants
struct URLConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let type = "movie"
    static let apiKey = "api_key=680ebd51dcc601e95626cfd2b274da81"
    static let page = "page=1"
    
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    struct Category {
        static let nowPlaying = "now_playing"
        static let popular = "popular"
        static let topRated = "top_rated"
        static let upcoming = "upcoming"
    }
}

//MARK: - URL Address
struct URLAddress {
    let urlNowPlaying = "\(URLConstants.baseURL)/\(URLConstants.type)/\(URLConstants.Category.nowPlaying)?\(URLConstants.apiKey)&\(URLConstants.page)"
    let urlPopular = "\(URLConstants.baseURL)/\(URLConstants.type)/\(URLConstants.Category.popular)?\(URLConstants.apiKey)&\(URLConstants.page)"
    let urlTopRated = "\(URLConstants.baseURL)/\(URLConstants.type)/\(URLConstants.Category.topRated)?\(URLConstants.apiKey)&\(URLConstants.page)"
    let urlUpcoming = "\(URLConstants.baseURL)/\(URLConstants.type)/\(URLConstants.Category.upcoming)?\(URLConstants.apiKey)&\(URLConstants.page)"

}


