//
//  SearchViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 7.12.2022.
//

import UIKit

//MARK: - SearchViewController
class SearchViewController: UIViewController {
    //Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!

    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}

//MARK: - TableViewDataSource
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: TableViewCells.searchTableViewCell, for: indexPath) as? SearchTableViewCell
        else {
            return UITableViewCell()
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}
