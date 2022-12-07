//
//  MovieModel.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 7.12.2022.
//

import Foundation

struct MovieModel {
    let movieTitle: String
    let posterURL: String
    let overview: String
    let releaseDate: String
    let voteAvarage: Double
    let voteCount: Int
    
    var score : String {
        return "Score: " + String(format:"%.1f", voteAvarage) + " (\(String(voteCount)))"
    }

}
