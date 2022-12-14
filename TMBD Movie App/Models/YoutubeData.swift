//
//  YoutubeData.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 14.12.2022.
//

//MARK: - Frameworks
import Foundation

//MARK: - YoutubeData
struct YoutubeData : Codable{
    let items : [YoutubeItems]
}

//MARK: - Items
struct YoutubeItems : Codable {
    let id : YoutubeID
}

//MARK: - ID
struct YoutubeID : Codable{
    let kind : String
    let videoId : String
}
