//
//  DetailViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 5.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var overview: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        infoView.layer.cornerRadius = infoView.frame.size.height * 0.08
    }

    
    @IBAction func playTrailerPressed(_ sender: UIButton) {
    }
    
    @IBAction func addWatchListPressed(_ sender: UIButton) {
    }
    
    
}
