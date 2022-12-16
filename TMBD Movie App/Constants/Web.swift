//
//  Web.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

//MARK: - Frameworks
import Foundation

//MARK: - MovieConstants
struct MovieConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let type = "movie"
    static let apiKey = "api_key=680ebd51dcc601e95626cfd2b274da81"
    static let firstPage = "page=1"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    struct Category {
        static let nowPlaying = "now_playing"
        static let popular = "popular"
        static let topRated = "top_rated"
        static let upcoming = "upcoming"
    }
}

struct YoutubeConstants{
    static let youtubeApiKey = "key=AIzaSyBpzqSb0bCKDAYqgB6jkEDsDAr4SN0f79w"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search"
}

//MARK: - URL Address
struct URLAddress {
    let urlNowPlaying = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(MovieConstants.Category.nowPlaying)?\(MovieConstants.apiKey)&\(MovieConstants.firstPage)"
    let urlPopular = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(MovieConstants.Category.popular)?\(MovieConstants.apiKey)&\(MovieConstants.firstPage)"
    let urlTopRated = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(MovieConstants.Category.topRated)?\(MovieConstants.apiKey)&\(MovieConstants.firstPage)"
    let urlUpcoming = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(MovieConstants.Category.upcoming)?\(MovieConstants.apiKey)&\(MovieConstants.firstPage)"
    let discoverURL = "\(MovieConstants.baseURL)/discover/\(MovieConstants.type)?\(MovieConstants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&\(MovieConstants.firstPage)&with_watch_monetization_types=flatrate"
    let searchQueryURL = "\(MovieConstants.baseURL)/search/\(MovieConstants.type)?\(MovieConstants.apiKey)&query="
    let genreData = "\(MovieConstants.baseURL)/genre/\(MovieConstants.type)/list?\(MovieConstants.apiKey)&language=en-US"
}


