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
    let sectionTitles = ["NOW PLAYING", "POPULAR", "TOP RATED", "UPCOMING"]
    var tableViewCell = MovieTableViewCell()
    var viewModel : DetailMovieModel?
    private var genreData : [Genre]? = [Genre]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        fetchGenreData()
    }
    
    //MARK: - Actions
    @IBAction func searchButtonDidPress(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segues.toSearchVC, sender: nil)
    }
    
    //MARK: - Methods
    //Fetch Genre Data
    private func fetchGenreData(){
        MovieManager.shared.performRequest(type: GenreData.self, query: "", externalID: "", movieID: 0, movieIDSelection: .none, movieURL: .none, completion: { results in
            switch results{
            case.success(let genres):
                self.genreData = genres.genres
            case.failure(let error):
                print(error.localizedDescription)
            }
        })
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
        return TableViewConstants.HomeTableView.numberOfRowsInSection
    }
    //MARK: - Cell for Row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TableViewCells.movieTableViewCell, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        //MovieTableViewCellDelegate
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.nowPlaying.rawValue:
            MovieManager.shared.performRequest(type: MovieData.self, query: "", externalID: "", movieID: 0, movieIDSelection: .none, movieURL: .nowPlaying) { results in
                switch results{
                case.success(let movie):
                    cell.configure(with: movie.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.popular.rawValue:
            MovieManager.shared.performRequest(type: MovieData.self, query: "", externalID: "", movieID: 0, movieIDSelection: .none, movieURL: .popular) { results in
                switch results{
                case.success(let movie):
                    cell.configure(with: movie.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.topRated.rawValue:
            MovieManager.shared.performRequest(type: MovieData.self, query: "", externalID: "", movieID: 0, movieIDSelection: .none, movieURL: .topRated) { results in
                switch results{
                case.success(let movie):
                    cell.configure(with: movie.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.upcoming.rawValue:
            MovieManager.shared.performRequest(type: MovieData.self, query: "", externalID: "", movieID: 0, movieIDSelection: .none, movieURL: .upcoming) { results in
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
        return TableViewConstants.HomeTableView.heightForRowAt
    }
    //MARK: - Title For Header in Section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    //MARK: - Height For Header in Section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewConstants.HomeTableView.heightForHeaderInSection
    }
    //MARK: - Will Display Header View
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
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
            destinationVC.viewModel = self.viewModel
            destinationVC.genreData = self.genreData
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
