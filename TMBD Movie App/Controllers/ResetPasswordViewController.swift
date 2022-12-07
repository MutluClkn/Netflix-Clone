//
//  ResetPasswordViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 6.12.2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func securePasswordPressed(_ sender: UIButton) {
    }
    @IBAction func secureConfirmPasswordPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func ResetButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
