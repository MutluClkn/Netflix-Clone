//
//  DetailViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 5.12.2022.
//

//MARK: - Frameworks
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
    
    //MARK: - Objects
    var movieManager = MovieManager()
    var watchlistVC = WatchlistViewController()
    var movieID : String?
    var id : Int?
    var posterString : String?
    var viewModel : DetailMovieModel?
    var watchlistModel : WatchlistDetailMovieModel?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDetails()
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
    private func loadDetails(){
        if self.viewModel != nil {
            movieTitle.text = viewModel?.movieTitle
            movieYear.text = viewModel?.releaseDate
            movieScore.text = viewModel?.score
            movieOverview.text = viewModel?.overview
            posterImage.kf.setImage(with: viewModel?.posterImage)
            posterString = "\(URLConstants.baseImageURL)" + (viewModel?.posterURL ?? "")
            
            movieManager.fetchMovieDetails(movieID: viewModel?.id ?? 0) { results in
                switch results{
                case .success(let details):
                    self.id = details.id
                    self.movieID = details.imdb_id
                case .failure(let error):
                    print(error)
                }
            }
        }else if watchlistModel != nil {
            movieTitle.text = watchlistModel?.title
            movieYear.text = watchlistModel?.releaseDate
            movieScore.text = watchlistModel?.score
            movieOverview.text = watchlistModel?.overview
            posterImage.kf.setImage(with: URL(string: watchlistModel?.posterURL ?? ""))
        }
    }
    private func configureUI(){
        infoView.layer.cornerRadius = infoView.frame.size.height * 0.05
        posterImage.layer.cornerRadius = posterImage.frame.size.height * 0.05
    }
    private func addWatchlist(){
        let docData : [String: Any] = [FirestoreConstants.id : id as Any,
                                       FirestoreConstants.movieId : movieID as Any,
                                       FirestoreConstants.title : movieTitle.text!,
                                       FirestoreConstants.date : movieYear.text!,
                                       FirestoreConstants.overview : movieOverview.text!,
                                       FirestoreConstants.score : movieScore.text!,
                                       FirestoreConstants.posterPath : posterString as Any,
                                       FirestoreConstants.uploadDate : FieldValue.serverTimestamp(),
                                       FirestoreConstants.email : Auth.auth().currentUser?.email as Any]
        
        Firestore.firestore().collection(FirestoreConstants.collectionName).addDocument(data: docData){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

