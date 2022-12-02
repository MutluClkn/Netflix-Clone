//
//  CollectionViewCell.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 1.12.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterTitle: UILabel!
    
    var title = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterTitle.text = title
    }

}
