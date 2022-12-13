//
//  MovieData.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

//MARK: - Frameworks
import Foundation

// MARK: - MovieData
struct MovieData: Codable {
    let results: [Movie]?
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genreids: [Int]?
    let id: Int?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, release_date, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
