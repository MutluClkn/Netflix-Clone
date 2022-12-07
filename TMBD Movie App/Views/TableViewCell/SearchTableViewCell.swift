//
//  SearchTableViewCell.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 7.12.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    //Properties
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    //Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = posterImage.frame.size.height * 0.08
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
