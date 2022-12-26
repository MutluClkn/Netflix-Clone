//
//  MovieTableViewCell.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

//MARK: - Frameworks
import UIKit
import Kingfisher

// MARK: - MovieTableViewCell
class MovieTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Objects
    weak var delegate : MovieTableViewCellDelegate?
    private var movieArray : [Movie]? = [Movie]()
    var viewModel : DetailMovieModel?
    private var genreData : [Genre]? = [Genre]()
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchGenreData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Methods
    public func configure(with movie: [Movie]?){
        self.movieArray = movie
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    //Fetch Genre Data
    private func fetchGenreData(){
        MovieManager.shared.performRequest(type: GenreData.self, query: "", externalID: "", movieID: 0, movieIDSelection: .none, movieURL: .none) { results in
            switch results{
            case.success(let genres):
                self.genreData = genres.genres
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Collection View DataSource
extension MovieTableViewCell: UICollectionViewDataSource {
    //MARK: - Number of Items in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = self.movieArray?.count else { return 0}
        return numberOfItems
    }
    //MARK: - Cell For Item at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.nowPlayingCell, for: indexPath) as? HomeCollectionViewCell
        else {
            return UICollectionViewCell() }
        
        cell.posterLabel.text = self.movieArray?[indexPath.row].title ?? self.movieArray?[indexPath.row].original_title
        cell.posterImage.layer.cornerRadius = cell.posterImage.frame.size.height * 0.08

        if let posterPath = self.movieArray?[indexPath.row].poster_path{
            let downloadPosterImage = URL(string: "\(MovieConstants.baseImageURL)\(posterPath)")
            cell.posterImage.kf.setImage(with: downloadPosterImage)
        }
        return cell
    }
}

// MARK: - Collection View Delegate
extension MovieTableViewCell: UICollectionViewDelegate {
    //MARK: - Did Select Item at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let title = movieArray?[indexPath.row].title ?? movieArray?[indexPath.row].original_title ?? ""
        let posterURL = movieArray?[indexPath.row].poster_path ?? ""
        let overview = movieArray?[indexPath.row].overview ?? ""
        let releaseDate = movieArray?[indexPath.row].release_date ?? ""
        let movieId = movieArray?[indexPath.row].id ?? 0
        let voteAverage = movieArray?[indexPath.row].vote_average ?? 0
        let voteCount = movieArray?[indexPath.row].vote_count ?? 0
        
        guard let movieGenreArray = movieArray?[indexPath.row].genre_ids else { return }
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

        self.delegate?.updateViewController(self, model: self.viewModel!)
    }
}
