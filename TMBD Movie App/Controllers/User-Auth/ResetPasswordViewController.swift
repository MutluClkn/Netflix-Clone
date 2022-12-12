//
//  ResetPasswordViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 6.12.2022.
//

import UIKit
import FirebaseAuth

//MARK: - ResetPasswordViewController
class ResetPasswordViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: - Actions
    @IBAction func ResetButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text{
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error {
                    self.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription)
                }else {
                    self.alertMessage(alertTitle: "Success", alertMesssage: "We sent you a recovery email. Check you mailbox!")
                }
            }
        }
    }
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
