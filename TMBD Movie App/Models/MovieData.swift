//
//  MovieData.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import Foundation

// MARK: - MovieData
struct MovieData: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
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


/*
 
 "dates": {
 "maximum": "2022-12-03",
 "minimum": "2022-10-16"
 },
 "page": 1,
 "results": [20 items],
 "total_pages": 106,
 "total_results": 2120
 
 
 "adult": false,
 "backdrop_path": "/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg",
 "genre_ids": [
 28,
 14,
 878
 ],
 "id": 436270,
 "original_language": "en",
 "original_title": "Black Adam",
 "overview": "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.",
 "popularity": 11752.795,
 "poster_path": "/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg",
 "release_date": "2022-10-19",
 "title": "Black Adam",
 "video": false,
 "vote_average": 7.3,
 "vote_count": 2415
 */

