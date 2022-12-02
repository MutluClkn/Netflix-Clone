//
//  HomeViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import UIKit

// MARK: - ViewController
class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    var movieManager = MovieManager()
    
    var movieTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieManager.delegate = self
        homeTableView.dataSource = self
        homeTableView.delegate = self
        
    }

    @IBAction func searchButtonDidPress(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segues.toSearchVC, sender: nil)
    }
}

// MARK: - Movie Manager Delegate
extension HomeViewController: MovieManagerDelegate{
    func didUpdateWeather(_ movieManager: MovieManager, model: MovieModel) {
        DispatchQueue.main.async {
            self.movieTitle = model.originalTitle
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Table View DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TableViewCells.movieTableViewCell, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
