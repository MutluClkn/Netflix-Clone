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
import WebKit

//MARK: - Detail ViewController
class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - Objects
    var movieManager = MovieManager()
    var movieID : String?
    var id : Int?
    var posterString : String?
    var viewModel : DetailMovieModel?
    private var movieArray : [Movie]? = [Movie]()
    
    
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
        if movieArray?.isEmpty == false {
            
            let title = movieArray?[0].title ?? movieArray?[0].original_title ?? ""
            let posterURL = movieArray?[0].poster_path ?? ""
            let overview = movieArray?[0].overview ?? ""
            let releaseDate = movieArray?[0].release_date ?? ""
            let movieId = movieArray?[0].id ?? 0
            let voteAverage = movieArray?[0].vote_average ?? 0
            let voteCount = movieArray?[0].vote_count ?? 0
            
            self.viewModel = DetailMovieModel(movieTitle: title, posterURL: posterURL, overview: overview, releaseDate: releaseDate, id: movieId, voteAverage: voteAverage, voteCount: voteCount)
        }
        movieTitle.text = viewModel?.movieTitle
        movieYear.text = viewModel?.releaseDate
        movieScore.text = viewModel?.score
        movieOverview.text = viewModel?.overview
        posterImage.kf.setImage(with: viewModel?.posterImage)
        posterString = "\(MovieConstants.baseImageURL)" + (viewModel?.posterURL ?? "")
        
        movieManager.fetchMovieDetails(movieID: viewModel?.id ?? 0) { results in
            switch results{
            case .success(let details):
                self.id = details.id
                self.movieID = details.imdb_id
            case .failure(let error):
                print(error)
            }
        }
        
        movieManager.fetchYoutubeVideo(with: viewModel?.movieTitle ?? "" + " trailer") { result in
            switch result{
            case .success(let video):
                
                guard let url = URL(string: "https://www.youtube.com/embed/\(video.id.videoId)") else {return}
                self.webView.load(URLRequest(url: url))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func configureUI(){
        infoView.layer.cornerRadius = infoView.frame.size.height * 0.05
        posterImage.layer.cornerRadius = posterImage.frame.size.height * 0.05
    }
    private func addWatchlist(){
        let uuid = UUID().uuidString
        let docData : [String: Any] = [FirestoreConstants.id : id as Any,
                                       FirestoreConstants.movieId : movieID as Any,
                                       FirestoreConstants.title : movieTitle.text!,
                                       FirestoreConstants.date : movieYear.text!,
                                       FirestoreConstants.overview : movieOverview.text!,
                                       FirestoreConstants.score : movieScore.text!,
                                       FirestoreConstants.posterPath : posterString as Any,
                                       FirestoreConstants.uploadDate : FieldValue.serverTimestamp(),
                                       FirestoreConstants.uuid : uuid,
                                       FirestoreConstants.email : Auth.auth().currentUser?.email as Any]
        
        Firestore.firestore().collection(FirestoreConstants.collectionName).whereField(FirestoreConstants.id, isEqualTo: self.id as Any).getDocuments { snapshot, error in
            if let error{
                print("Error getting documents: \(error)")
            }else{
                if !snapshot!.documents.isEmpty {
                    self.alertMessage(alertTitle: "Failed", alertMesssage: "Current movie is in your watchlist already.")
                    print("Movie saved in the database already.")
                }else{
                    Firestore.firestore().collection(FirestoreConstants.collectionName).document(uuid).setData(docData){ error in
                        if let error {
                            print("Error writing document: \(error)")
                        } else {
                            self.alertMessage(alertTitle: "Success", alertMesssage: "The movie saved in your watchlist.")
                            print("Document successfully written!")
                        }
                    }
                }
            }
        }
    }
    public func configureFromWatchlist(with movie: [Movie]?){
        self.movieArray = movie
    }
}
