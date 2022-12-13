//
//  FStoreMovieModel.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 12.12.2022.
//

import Foundation

struct FStoreMovieModel {
    var id : Int?
    var posterURL : String
    var title : String
    var date : String
    var overview : String
    var score : String
    
    init(id: Int? = nil, posterURL : String, title: String, date: String, overview: String, score: String) {
        self.id = id
        self.posterURL = posterURL
        self.title = title
        self.date = date
        self.overview = overview
        self.score = score
    }
}

/*
 let docData : [String: Any] = [FirestoreConstants.id : ID as Any, FirestoreConstants.posterPath : posterURL as Any, FirestoreConstants.title : movieTitle.text!, FirestoreConstants.date : movieYear.text!, FirestoreConstants.overview : movieOverview.text!, FirestoreConstants.score : movieScore.text!, FirestoreConstants.email : Auth.auth().currentUser?.email as Any]
 */
