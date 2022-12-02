//
//  MovieData.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import Foundation

// MARK: - MovieData
struct MovieData: Codable{
    let dates: Dates
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

enum OriginalLanguage: Codable {
    case de
    case en
    case es
    case vi
}
