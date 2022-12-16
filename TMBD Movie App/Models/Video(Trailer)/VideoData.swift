//
//  VideoData.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 16.12.2022.
//

//MARK: - Frameworks
import Foundation

//MARK: - VideoData
struct VideoData : Codable {
    let results : [VideoResults]?
}

//MARK: - VideoResults
struct VideoResults : Codable {
    let key : String?
}
