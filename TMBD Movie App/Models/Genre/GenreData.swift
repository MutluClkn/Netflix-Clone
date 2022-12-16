//
//  GenreData.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 16.12.2022.
//

//MARK: - Frameworks
import Foundation

// MARK: - GenreData
struct GenreData : Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre : Codable {
    let id: Int?
    let name: String?
}
