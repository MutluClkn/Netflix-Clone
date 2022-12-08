//
//  HomeViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import UIKit
// MARK: - TableView Sections
enum Sections : Int {
    case nowPlaying = 0
    case popular = 1
    case topRated = 2
    case upcoming = 3
}

// MARK: - ViewController
class HomeViewController: UIViewController {
    // Properties
    @IBOutlet weak var homeTableView: UITableView!

    // Objects
    let sectionTitles = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
    var tableViewCell = MovieTableViewCell()
    var movieManager = MovieManager()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
    
    @IBAction func searchButtonDidPress(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segues.toSearchVC, sender: nil)
    }
}

// MARK: - Table View DataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TableViewCells.movieTableViewCell, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.nowPlaying.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlNowPlaying) { movie in
                cell.configure(with: movie.results)
            }
        case Sections.popular.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlPopular) { movie in
                cell.configure(with: movie.results)
            }
        case Sections.topRated.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlTopRated) { movie in
                cell.configure(with: movie.results)
            }
        case Sections.upcoming.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlUpcoming) { movie in
                cell.configure(with: movie.results)
            }
        default:
            return UITableViewCell()
        }
        
        
        return cell
    }
}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
    }
}

// MARK: - MovieTableViewCellDelegate
extension HomeViewController: MovieTableViewCellDelegate {
    func updateViewController(_ cell: MovieTableViewCell, model: DetailMovieModel) {
        DispatchQueue.main.async {
            let vc = DetailViewController()
            vc.configure(with: model)
            //print(model)
            self.performSegue(withIdentifier: Segues.toDetailVC, sender: nil)
        }
    }
}
