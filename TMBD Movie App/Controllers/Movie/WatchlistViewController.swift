//
//  WatchlistViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 12.12.2022.
//

import UIKit
import Kingfisher
import Firebase
import FirebaseStorage
import FirebaseAuth

//MARK: - Watchlist ViewController
class WatchlistViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var watchlistTableView: UITableView!
    
    //Objects
    var loadedMovies = [FStoreMovieModel]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        watchlistTableView.dataSource = self
        watchlistTableView.delegate = self
        loadMovies()
    }

    
    //MARK: - Methods
    func loadMovies(){
        Firestore.firestore().collection(FirestoreConstants.collectionName).order(by: FirestoreConstants.uploadDate, descending: true).addSnapshotListener { querySnapshot, error in
            if let error {
                print(error)
            }else{
                if querySnapshot?.isEmpty != true && querySnapshot != nil {
                    self.loadedMovies.removeAll()
                    for doc in querySnapshot!.documents{
                        if let email = doc.get(FirestoreConstants.email) as? String,let id = doc.get(FirestoreConstants.id) as? Int?, let movieId = doc.get(FirestoreConstants.movieId) as? String, let title = doc.get(FirestoreConstants.title) as? String, let date = doc.get(FirestoreConstants.date) as? String, let score = doc.get(FirestoreConstants.score) as? String, let posterString = doc.get(FirestoreConstants.posterPath) as? String, let overview = doc.get(FirestoreConstants.overview) as? String{
                            if email == Auth.auth().currentUser?.email{
                                self.loadedMovies.append(FStoreMovieModel(id: id, movieID: movieId, posterURL: posterString, title: title, date: date, overview: overview, score: score))
                            }
                        }
                    }
                    self.watchlistTableView.reloadData()
                }
            }
        }
    }
}


//MARK: - TableViewDataSource
extension WatchlistViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loadedMovies.count
    }
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
}

//MARK: - TableViewDelegate
extension WatchlistViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.watchlistToDetail, sender: nil)
    }
}

