//
//  Credits.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 16.12.2022.
//

//MARK: - Frameworks
import Foundation

// MARK: - Credits
struct CreditsData : Codable {
    let id: Int?
    let cast, crew: [Cast]?
}

// MARK: - Cast
struct Cast : Codable {
    let adult: Bool?
    let gender, id: Int?
    let known_for_department, name, original_name: String?
    let popularity: Double?
    let profile_path: String?
    let cast_id: Int?
    let character, credit_id: String?
    let order: Int?
    let department, job: String?
}
