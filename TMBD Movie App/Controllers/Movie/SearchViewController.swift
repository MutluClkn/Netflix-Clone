//
//  SearchViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 7.12.2022.
//

import UIKit
import Kingfisher

//MARK: - SearchViewController
class SearchViewController: UIViewController {
    //Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    //Objects
    private var movieArray : [Movie]?

    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        searchBar.delegate = self
        
        fetchDiscoverMovies()
    }
    
    //Methods
    private func fetchDiscoverMovies(){
        MovieManager().performRequest(url: URLAddress().discoverURL) { movie in
            DispatchQueue.main.async { [weak self] in
                self?.movieArray = movie.results
                self?.searchTableView.reloadData()
            }
        }
    }
}

//MARK: - TableViewDataSource
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: TableViewCells.searchTableViewCell, for: indexPath) as? SearchTableViewCell
        else {
            return UITableViewCell()
        }
        let movie = self.movieArray?[indexPath.row]
        cell.movieTitle.text = movie?.title
        
        if let posterPath = movie?.poster_path{
            let downloadPosterImage = URL(string: "\(URLConstants.baseImageURL)\(posterPath)")
            cell.posterImage.kf.setImage(with: downloadPosterImage)
        }
        
        if let voteAverage = movie?.vote_average, let voteCount = movie?.vote_count {
            cell.scoreLabel.text = "Score: " + String(format:"%.1f", voteAverage) + " (\(String(voteCount)))"
        }
        return cell
    }
}

//MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

//MARK: - SearchBarDelegate
extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.movieArray = []
            let query = searchText
            MovieManager().fetchSearchQuery(with: query, url: URLAddress().searchQueryURL) { movie in
                DispatchQueue.main.async { [weak self] in
                    self?.movieArray = movie.results
                    self?.searchTableView.reloadData()
                }
            }
        }
    }
}
