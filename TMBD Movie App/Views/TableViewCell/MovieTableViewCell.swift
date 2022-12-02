//
//  MovieTableViewCell.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CollectionViewCells.nowPlayingCellNibName, bundle: nil), forCellWithReuseIdentifier: CollectionViewCells.nowPlayingCell)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - Collection View DataSource
extension MovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.nowPlayingCell, for: indexPath) as? NowPlayingCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
}

// MARK: - Collection View Delegate
extension MovieTableViewCell: UICollectionViewDelegateFlowLayout {

}
