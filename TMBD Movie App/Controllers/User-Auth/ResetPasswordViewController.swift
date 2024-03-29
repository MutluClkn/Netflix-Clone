//
//  ResetPasswordViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 6.12.2022.
//

//MARK: - Frameworks
import UIKit
import FirebaseAuth

//MARK: - ResetPasswordViewController
class ResetPasswordViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
    }
    
    
    //MARK: - Actions
    @IBAction func ResetButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text{
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error {
                    self.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription, completionHandler: nil)
                }else {
                    self.alertMessage(alertTitle: "Success", alertMesssage: "We sent you a recovery email. Check your mailbox!"){
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
