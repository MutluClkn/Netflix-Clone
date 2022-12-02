//
//  HomeViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import UIKit

// MARK: - ViewController
class HomeViewController: UIViewController {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieManager = MovieManager()
    
    var movieTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieManager.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Cells.nowPlayingCellName, bundle: nil), forCellWithReuseIdentifier: Cells.nowPlayingCell)
    }

    @IBAction func searchButtonDidPress(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segues.toSearchVC, sender: nil)
    }
}

// MARK: - Collection View Data Source
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.nowPlayingCell, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.title = self.movieTitle
        return cell
    }
    
}

// MARK: - Collection View Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.toDetailVC, sender: nil)
    }
}

extension HomeViewController: MovieManagerDelegate{
    func didUpdateWeather(_ movieManager: MovieManager, model: MovieModel) {
        DispatchQueue.main.async {
            self.movieTitle = model.movieTitle
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
