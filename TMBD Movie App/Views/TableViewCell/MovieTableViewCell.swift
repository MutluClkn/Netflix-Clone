//
//  MovieTableViewCell.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import UIKit
import Kingfisher

// MARK: - MovieTableViewCellDelegate
protocol MovieTableViewCellDelegate: AnyObject {
    func updateViewController(_ cell: MovieTableViewCell, model: DetailMovieModel)
}

// MARK: - MovieTableViewCell
class MovieTableViewCell: UITableViewCell {

    //Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Objects
    weak var delegate : MovieTableViewCellDelegate?
    private var movieArray : [Movie]? = [Movie]()
    
    //Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // Methods
    public func configure(with movie: [Movie]?){
        self.movieArray = movie
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Collection View DataSource
extension MovieTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.nowPlayingCell, for: indexPath) as? HomeCollectionViewCell
        else {
            return UICollectionViewCell() }
        
        cell.posterLabel.text = self.movieArray?[indexPath.row].title ?? self.movieArray?[indexPath.row].original_title
        cell.posterImage.layer.cornerRadius = cell.posterImage.frame.size.height * 0.08

        if let posterPath = self.movieArray?[indexPath.row].poster_path{
            let downloadPosterImage = URL(string: "\(URLConstants.baseImageURL)\(posterPath)")
            cell.posterImage.kf.setImage(with: downloadPosterImage)
        }
        return cell
    }
}

// MARK: - Collection View Delegate
extension MovieTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movieArray?[indexPath.row]
        let title = movie?.original_title
        guard let posterURL = movie?.poster_path else { return }
        let overview = movie?.overview
        let releaseDate = movie?.release_date
        guard let voteAverage = movie?.vote_average else { return }
        guard let voteCount = movie?.vote_count else { return }
        
        
        let model = DetailMovieModel(movieTitle: title, posterURL: posterURL, overview: overview, releaseDate: releaseDate, voteAverage: voteAverage, voteCount: voteCount)
        
        self.delegate?.updateViewController(self, model: model)
    }
}
