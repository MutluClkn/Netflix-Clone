//
//  HomeViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

//MARK: - Frameworks
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
    
    //MARK: - Outlets
    @IBOutlet weak var homeTableView: UITableView!

    //MARK: - Objects
    let sectionTitles = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
    var tableViewCell = MovieTableViewCell()
    var movieManager = MovieManager()
    var viewModel : DetailMovieModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
    
    //MARK: - Actions
    @IBAction func searchButtonDidPress(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segues.toSearchVC, sender: nil)
    }
}

// MARK: - Table View DataSource
extension HomeViewController: UITableViewDataSource {
    //MARK: - Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    //MARK: - Number of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //MARK: - Cell for Row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TableViewCells.movieTableViewCell, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        //MovieTableViewCellDelegate
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.nowPlaying.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlNowPlaying) { results in
                switch results{
                case.success(let movie):
                    cell.configure(with: movie.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.popular.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlPopular) { results in
                switch results{
                case.success(let movie):
                    cell.configure(with: movie.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.topRated.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlTopRated) { results in
                switch results{
                case.success(let movie):
                    cell.configure(with: movie.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.upcoming.rawValue:
            self.movieManager.performRequest(url: URLAddress().urlUpcoming) { results in
                switch results{
                case.success(let movie):
                    cell.configure(with: movie.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate{
    //MARK: - Height For Row at
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    //MARK: - Title For Header in Section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    //MARK: - Height For Header in Section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    //MARK: - Will Display Header View
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
    }
}

// MARK: - MovieTableViewCellDelegate
extension HomeViewController: MovieTableViewCellDelegate {
    //MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toDetailVC {
            let destinationVC = segue.destination as! DetailViewController
           // destinationVC.movieID = self.movieId
            destinationVC.viewModel = self.viewModel
        }
    }
    //MARK: - Update View Controller
    func updateViewController(_ cell: MovieTableViewCell, model: DetailMovieModel) {
        DispatchQueue.main.async {
            self.viewModel = model
            self.performSegue(withIdentifier: Segues.toDetailVC, sender: nil)
        }
    }
}
