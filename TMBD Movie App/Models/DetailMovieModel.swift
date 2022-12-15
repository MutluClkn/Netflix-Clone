//
//  MovieModel.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 7.12.2022.
//

//MARK: - Frameworks
import Foundation

//MARK: - DetailMovieModel
struct DetailMovieModel {
    let movieTitle: String
    let posterURL: String
    let overview: String
    let releaseDate: String
    let id : Int
    let voteAverage: Double
    let voteCount: Int
    
    var score : String {
        return String(format:"%.1f", voteAverage) + " (\(String(voteCount)))"
    }
    
    var posterImage : URL? {
        return URL(string: "\(MovieConstants.baseImageURL)\(String(describing: posterURL))")
    }
     
}
