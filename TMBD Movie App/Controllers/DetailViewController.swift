//
//  DetailViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 5.12.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.cornerRadius = infoView.frame.size.height * 0.05
        posterImage.layer.cornerRadius = posterImage.frame.size.height * 0.05
        
    }
    
    @IBAction func playTrailerButtonPressed(_ sender: UIButton) {
    }
    @IBAction func watchListButtonPressed(_ sender: UIButton) {
    }
    
    
    func configure(with model: MovieModel){
        movieTitle.text = model.movieTitle
        movieYear.text = model.releaseDate
        movieOverview.text = model.overview
        movieScore.text = model.score

        let downloadPosterImage = URL(string: "\(URLConstants.baseImageURL)\(String(describing: model.posterURL))")
        posterImage.kf.setImage(with: downloadPosterImage)
    }
    
}
