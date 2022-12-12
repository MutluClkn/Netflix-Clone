//
//  WatchlistViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 12.12.2022.
//

import UIKit

//MARK: - Watchlist ViewController
class WatchlistViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var watchlistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        watchlistTableView.dataSource = self
        watchlistTableView.delegate = self
    }
}


//MARK: - TableViewDataSource
extension WatchlistViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = watchlistTableView.dequeueReusableCell(withIdentifier: TableViewCells.watchlistTableViewCell, for: indexPath) as? WatchlistTableViewCell
        else {
            return UITableViewCell()
        }
        return cell
    }
}

//MARK: - TableViewDelegate
extension WatchlistViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.watchlistToDetail, sender: nil)
    }
}

