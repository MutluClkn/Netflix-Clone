//
//  SettingsViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 8.12.2022.
//

import UIKit
import FirebaseAuth

enum SettingSections : Int {
    case account = 0
    case help = 1
}

//MARK: - SettingsViewController
class SettingsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userDisplayName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Objects
    //Section Titles
    let sectionTitles = ["ACCOUNT", "HELP"]
    //Account Section
    let accountSettings = ["Profile", "Account Settings", "Delete Account"]
    let cellImagesName = ["person", "gear", "minus.circle"]
    //Help Section
    let helpSettings = ["FAQ", "Terms & Privacy"]
    let helpImagesName = ["questionmark","doc.plaintext"]
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    //MARK: - Actions
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        performSegue(withIdentifier: Segues.logOutToLoginVC, sender: nil)
    }
    
    //MARK: - Methods
    func currentUserInfo(){
        userDisplayName.text = Auth.auth().currentUser?.displayName
    }
}

//MARK: - SettingsVC TableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SettingSections.account.rawValue:
            return accountSettings.count
        case SettingSections.help.rawValue:
            return helpSettings.count
        default:
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.settingsCell, for: indexPath) as? SettingsTableViewCell
        else{
            return UITableViewCell() }
        
        switch indexPath.section{
        case SettingSections.account.rawValue:
            cell.cellImage.image = UIImage(systemName: cellImagesName[indexPath.row])
            cell.title.text = accountSettings[indexPath.row]
        case SettingSections.help.rawValue:
            cell.cellImage.image = UIImage(systemName: helpImagesName[indexPath.row])
            cell.title.text = helpSettings[indexPath.row]
        default:
            return UITableViewCell()
        }
        return cell
    }
}

//MARK: - SettingsVC TableViewDelegate
extension SettingsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
    }
}
