//
//  DetailViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 5.12.2022.
//

import UIKit
import Kingfisher
import Firebase
import FirebaseStorage

//MARK: - Detail ViewController
class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movieID : Int? = 436270
    var posterURL = "\(URLConstants.baseImageURL)/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Actions
    @IBAction func playTrailerButtonPressed(_ sender: UIButton) {
        print("Play Trailer button pressed.")
    }
    @IBAction func watchListButtonPressed(_ sender: UIButton) {
        print("Watchlist button pressed.")
        addWatchlist()
        
    }
    
    //MARK: - Methods
    func configure(with model: DetailMovieModel){
        print("-----")
        print(model)
        print("-----")

        /*
         movieTitle.text = model.movieTitle
         movieYear.text = model.releaseDate
         movieOverview.text = model.overview
         movieScore.text = model.score
         movieID = model.id
        posterURL = "\(URLConstants.baseImageURL)\(model.posterURL)"
         posterImage.kf.setImage(with: model.posterImage)
         */
    }
    private func configureUI(){
        infoView.layer.cornerRadius = infoView.frame.size.height * 0.05
        posterImage.layer.cornerRadius = posterImage.frame.size.height * 0.05
    }
    private func addWatchlist(){
        let docData : [String: Any] = [FirestoreConstants.movieId : movieID as Any, FirestoreConstants.title : movieTitle.text!, FirestoreConstants.date : movieYear.text!, FirestoreConstants.overview : movieOverview.text!, FirestoreConstants.score : movieScore.text!, FirestoreConstants.posterPath : posterURL, FirestoreConstants.uploadDate : FieldValue.serverTimestamp(), FirestoreConstants.email : Auth.auth().currentUser?.email as Any]
        Firestore.firestore().collection(FirestoreConstants.collectionName).addDocument(data: docData){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
