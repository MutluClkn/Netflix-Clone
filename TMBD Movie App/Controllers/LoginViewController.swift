//
//  LoginViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 6.12.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: Segues.toRegisterVC, sender: nil)
        
    }
    @IBAction func hideAndShowPasswordButtonPressed(_ sender: UIButton) {
    }
}
