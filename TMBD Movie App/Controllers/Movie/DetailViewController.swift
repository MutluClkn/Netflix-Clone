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
    
    var newTitle : String?
    
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.cornerRadius = infoView.frame.size.height * 0.05
        posterImage.layer.cornerRadius = posterImage.frame.size.height * 0.05
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTitle.text = newTitle
    }
    
    @IBAction func playTrailerButtonPressed(_ sender: UIButton) {
        print("Play Trailer button pressed.")
    }
    @IBAction func watchListButtonPressed(_ sender: UIButton) {
        print("Watchlist button pressed.")
    }
    
    
    func configure(with model: DetailMovieModel){
        print("-----")
        print(model)
        print("-----")
        
        newTitle = model.movieTitle
        
        /*
        
        movieTitle.text = model.movieTitle
        movieYear.text = model.releaseDate
        movieOverview.text = model.overview
        movieScore.text = model.score
        posterImage.kf.setImage(with: model.posterImage)
        */
    }
    
}
