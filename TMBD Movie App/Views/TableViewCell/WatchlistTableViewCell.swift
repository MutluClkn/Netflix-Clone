//
//  WatchlistTableViewCell.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 12.12.2022.
//

//MARK: - Frameworks
import UIKit

//MARK: - Watchlist TableViewCell
class WatchlistTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = movieImage.frame.size.height * 0.08
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
