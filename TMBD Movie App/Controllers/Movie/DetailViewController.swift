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
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var addWatchlistButton: UIButton!
    
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
        addGradient(viewTest: posterView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDetails()
    }
    
    
    //MARK: - Actions
    @IBAction func watchListButtonPressed(_ sender: UIButton) {
        print("Watchlist button pressed.")
        addWatchlist()
    }
    
    
    //MARK: - Methods
    //Update View
    private func loadDetails(){
        //Check If The Data Fetched From Watchlist or SearchVC
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
        //Load The Latest Data
        movieTitle.text = viewModel?.movieTitle
        movieYear.text = viewModel?.releaseDate
        movieScore.text = viewModel?.score
        movieOverview.text = viewModel?.overview
        posterImage.kf.setImage(with: viewModel?.posterImage)
        posterString = "\(MovieConstants.baseImageURL)" + (viewModel?.posterURL ?? "")
        
        //Get External ID
        movieManager.fetchMovieDetails(movieID: viewModel?.id ?? 0) { results in
            switch results{
            case .success(let details):
                self.id = details.id
                self.movieID = details.imdb_id
            case .failure(let error):
                print(error)
            }
        }
        //Update Trailer Video
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
    //Prepare For Watchlist Button
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
                    self.alertMessage(alertTitle: "", alertMesssage: "The movie is in your watchlist.")
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
    //Get Data From WatchlistVC
    public func configureFromWatchlist(with movie: [Movie]?){
        self.movieArray = movie
    }
    //Get Data From SearchVC
    public func configureFromSearchVC(with movie : Movie?){
        if let movie{
            self.movieArray?.append(movie)
        }
    }
}
