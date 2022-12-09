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
    
    var newTitle, newDate, newOverview, newScore : String?
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.cornerRadius = infoView.frame.size.height * 0.05
        posterImage.layer.cornerRadius = posterImage.frame.size.height * 0.05
        /*
        movieTitle.text = newTitle
        movieYear.text = newDate
        movieOverview.text = newOverview
        movieScore.text = newScore
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        movieTitle.text = newTitle
        movieYear.text = newDate
        movieOverview.text = newOverview
        movieScore.text = newScore
         */
    }
    
    @IBAction func playTrailerButtonPressed(_ sender: UIButton) {
    }
    @IBAction func watchListButtonPressed(_ sender: UIButton) {
    }
    
    
    func configure(with model: DetailMovieModel){
        print(model)
        /*
        newTitle = model.movieTitle
        newDate = model.releaseDate
        newOverview = model.overview
        newScore = model.score
        posterImage.kf.setImage(with: model.posterImage)
         */
    }
    
}
