//
//  SettingsTableViewCell.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 12.12.2022.
//

//MARK: - Frameworks
import UIKit

//MARK: - SettingsTableViewCell
class SettingsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
