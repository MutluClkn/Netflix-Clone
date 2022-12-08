//
//  SettingsViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 8.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Segues.logOutToLoginVC, sender: nil)
    }
}
