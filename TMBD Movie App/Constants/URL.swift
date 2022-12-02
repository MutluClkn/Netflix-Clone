//
//  URL.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import Foundation

struct URLConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let type = "movie"
    static let apiKey = "api_key=680ebd51dcc601e95626cfd2b274da81"
    static let page = "page=1"
    
    struct Category {
        static let nowPlaying = "now_playing"
        static let popular = "popular"
    }
}


