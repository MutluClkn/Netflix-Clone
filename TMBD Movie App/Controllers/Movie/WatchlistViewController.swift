//
//  WatchlistViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 12.12.2022.
//

//MARK: - Frameworks
import UIKit
import Kingfisher
import Firebase
import FirebaseStorage
import FirebaseAuth

//MARK: - Watchlist ViewController
class WatchlistViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var watchlistTableView: UITableView!
    
    //MARK: - Objects
    var movieManager = MovieManager()
    var loadedMovies = [FStoreMovieModel]()
    var viewModel : DetailMovieModel?
    private var movieArray : [Movie]? = [Movie]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        watchlistTableView.dataSource = self
        watchlistTableView.delegate = self
        loadMovies()
    }

    
    //MARK: - Methods
    //Fetch Movies From Firestore
    func loadMovies(){
        Firestore.firestore().collection(FirestoreConstants.collectionName).order(by: FirestoreConstants.uploadDate, descending: true).addSnapshotListener { querySnapshot, error in
            if let error {
                print(error)
            }else{
                if querySnapshot?.isEmpty != true && querySnapshot != nil {
                    self.loadedMovies.removeAll()
                    for doc in querySnapshot!.documents{
                        if let email = doc.get(FirestoreConstants.email) as? String,let id = doc.get(FirestoreConstants.id) as? Int?, let movieId = doc.get(FirestoreConstants.movieId) as? String, let title = doc.get(FirestoreConstants.title) as? String, let date = doc.get(FirestoreConstants.date) as? String, let score = doc.get(FirestoreConstants.score) as? String, let posterString = doc.get(FirestoreConstants.posterPath) as? String, let overview = doc.get(FirestoreConstants.overview) as? String, let uuid = doc.get(FirestoreConstants.uuid) as? String{
                            if email == Auth.auth().currentUser?.email{
                                self.loadedMovies.append(FStoreMovieModel(id: id, movieID: movieId, posterURL: posterString, title: title, date: date, overview: overview, score: score, uuid: uuid))
                            }
                        }
                    }
                    self.watchlistTableView.reloadData()
                }
            }
        }
    }
    //Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.watchlistToDetail {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.configureFromWatchlist(with: movieArray)
        }
    }
}


//MARK: - TableViewDataSource
extension WatchlistViewController: UITableViewDataSource{
    //MARK: - Number of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loadedMovies.count
    }
    //MARK: - Cell For Row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = watchlistTableView.dequeueReusableCell(withIdentifier: TableViewCells.watchlistTableViewCell, for: indexPath) as? WatchlistTableViewCell else {
            return UITableViewCell()
        }
        cell.movieTitle.text = loadedMovies[indexPath.row].title
        cell.movieScore.text = loadedMovies[indexPath.row].score
        let posterURL = loadedMovies[indexPath.row].posterURL
        cell.movieImage.kf.setImage(with: URL(string: posterURL))

        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            loadedMovies.remove(at: indexPath.row)
            Firestore.firestore().collection(FirestoreConstants.collectionName).document(loadedMovies[indexPath.row].uuid).delete()
            self.watchlistTableView.reloadData()
        }
    }
}

//MARK: - TableViewDelegate
extension WatchlistViewController: UITableViewDelegate{
    //MARK: - Height For Row at
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    //MARK: - Did Select Row at
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let externalID = loadedMovies[indexPath.row].movieID
        
        movieManager.fetchSpecificMovie(with: externalID) { result in
            switch result{
            case .success(let movie):
                
                self.movieArray = movie.movie_results
                self.performSegue(withIdentifier: Segues.watchlistToDetail, sender: nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}


/*
 let filmRef = db.collection("films").whereField("name", isEqualTo: "Film Adı")
filmRef.delete
 */
