//
//  SearchMovieModel.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 8.12.2022.
//

import Foundation

struct SearchMovieModel {
    let movieTitle: String
    let posterURL: String
    let voteAverage: Double
    let voteCount: Int
    
    var score : String {
        return "Score: " + String(format:"%.1f", voteAverage) + " (\(String(voteCount)))"
    }
    
    var posterImage : URL? {
        return URL(string: "\(URLConstants.baseImageURL)\(String(describing: posterURL))")
    }
}
