//
//  HomeViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import UIKit

// MARK: - ViewController
class HomeViewController: UIViewController {
    //Properties
    @IBOutlet weak var homeTableView: UITableView!

    let sectionTitles = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
    
    var tableViewCell = MovieTableViewCell()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self 
    }
    
    @IBAction func searchButtonDidPress(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segues.toSearchVC, sender: nil)
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toDetailVC {
            let destinationVC = segue.destination as! DetailViewController
            if let index = tableViewCell.collectionView.indexPathsForSelectedItems?.first{
                destinationVC.movieTitle.text = tableViewCell.movieArray?[index.row].title
            }
        }
    }*/
}

// MARK: - Table View DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: TableViewCells.movieTableViewCell, for: indexPath)
        guard let movieCell = cell as? MovieTableViewCell else { return cell }
        
        movieCell.didSelectItemAction = { [weak self] indexPath in
            self?.performSegue(withIdentifier: Segues.toDetailVC, sender: self)
        }
        return movieCell
    }
}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}
