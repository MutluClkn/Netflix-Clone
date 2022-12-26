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
    @IBOutlet weak var addWatchlistButton: UIButton!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    
    //MARK: - Objects
    //private var movieManager = MovieManager()
    private var movieID : String?
    private var id : Int?
    private var posterString : String?
    public var viewModel : DetailMovieModel?
    private var movieArray : [Movie]? = [Movie]()
    private var casts : [Cast]? = [Cast]()
    public var genreData : [Genre]? = [Genre]()
    private var videoData : [VideoResults]? = [VideoResults]()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        castCollectionView.dataSource = self
        trailerCollectionView.dataSource = self
        addGradient(viewTest: posterView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDetails()
        loadVideos()
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
            
            guard let movieGenreArray = movieArray?[0].genre_ids else { return }
            let movieGenreCount = movieGenreArray.count
            
            guard let genreDataCount = self.genreData?.count else { return }
            
            var genreResult : String = ""
            
            for movieGenreIndex in 0...movieGenreCount - 1{
                for gDataIndex in 0...genreDataCount - 1 {
                    if movieGenreArray[movieGenreIndex] == self.genreData?[gDataIndex].id{
                        guard let genreName = self.genreData?[gDataIndex].name else { return }
                        genreResult = genreResult + genreName + ", "
                    }
                }
            }
            
            self.viewModel = DetailMovieModel(movieTitle: title, posterURL: posterURL, overview: overview, releaseDate: releaseDate, id: movieId, voteAverage: voteAverage, voteCount: voteCount, genre: genreResult)
        }
        //Load The Latest Data
        movieTitle.text = viewModel?.movieTitle
        movieYear.text = viewModel?.dateAndGenre
        movieScore.text = viewModel?.score
        movieOverview.text = viewModel?.overview
        posterImage.kf.setImage(with: viewModel?.posterImage)
        posterString = "\(MovieConstants.baseImageURL)" + (viewModel?.posterURL ?? "")
        
        //Get External ID
        MovieManager.shared.performRequest(type: MovieDetailsData.self, query: "", externalID: "", movieID: viewModel?.id ?? 0, movieIDSelection: .movieDetails, movieURL: .none) { results in
            switch results{
            case .success(let details):
                self.id = details.id
                self.movieID = details.imdb_id
            case .failure(let error):
                print(error)
            }
        }
        
        //Fetch Casts
        MovieManager.shared.performRequest(type: CreditsData.self, query: "", externalID: "", movieID: viewModel?.id ?? 0, movieIDSelection: .credits, movieURL: .none) { results in
            switch results{
            case.success(let cast):
                DispatchQueue.main.async {
                    self.casts = cast.cast
                    self.castCollectionView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //Load Movie Videos
    func loadVideos(){
        MovieManager.shared.performRequest(type: VideoData.self, query: "", externalID: "", movieID: viewModel?.id ?? 0, movieIDSelection: .videos, movieURL: .none) { results in
            switch results {
            case.success(let video):
                DispatchQueue.main.async {
                    self.videoData = video.results
                    self.trailerCollectionView.reloadData()
                }
            case.failure( let error):
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
        
        Firestore.firestore().collection(FirestoreConstants.collectionName).whereField(FirestoreConstants.id, isEqualTo: self.id as Any).whereField(FirestoreConstants.email, isEqualTo: Auth.auth().currentUser?.email as Any).getDocuments { snapshot, error in
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
    public func configureFromWatchlist(with movie: [Movie]?, and genre: [Genre]?){
        self.movieArray = movie
        self.genreData = genre
    }
    //Get Data From SearchVC
    public func configureFromSearchVC(with movie : Movie?, and genre: [Genre]?){
        if let movie{
            self.movieArray?.append(movie)
            self.genreData = genre
        }
    }
}

//MARK: - CollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView{
            guard let numberOfItems = self.casts?.count else{return 0}
            return numberOfItems
        }
        else{
            guard let numberOfItems = self.videoData?.count else{return 0}
            return numberOfItems
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castCollectionView{
            guard let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.castCell, for: indexPath) as? CreditsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.castName.text = self.casts?[indexPath.row].name ?? self.casts?[indexPath.row].original_name
            cell.castImage.layer.cornerRadius = cell.castImage.frame.size.height * 0.1
            
            if let posterPath = self.casts?[indexPath.row].profile_path{
                let downloadPosterImage = URL(string: "\(MovieConstants.baseImageURL)\(posterPath)")
                cell.castImage.kf.setImage(with: downloadPosterImage)
            }
            return cell
            
        }
        
        else{
            guard let cell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.trailerCell, for: indexPath) as? TrailerCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let videoKey = self.videoData?[indexPath.row].key else {return UICollectionViewCell()}
            guard let url = URL(string: "https://www.youtube.com/embed/\(videoKey)") else {return UICollectionViewCell()}
            cell.trailerWebView.load(URLRequest(url: url))
            return cell
        }
        
    }
}
