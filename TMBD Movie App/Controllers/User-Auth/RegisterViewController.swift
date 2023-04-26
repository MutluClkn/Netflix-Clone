//
//  RegisterViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 6.12.2022.
//

//MARK: - Frameworks
import UIKit
import FirebaseAuth

//MARK: - RegisterViewController
class RegisterViewController: UIViewController {

    //MARK: - Outlets
    //Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordHideAndShowButton: UIButton!
    @IBOutlet weak var confirmPassHideAndShowButton: UIButton!
    
    
    //MARK: - Lifecycle
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
    }
    
    
    //MARK: - Actions
    //Password Hide and Show Button
    @IBAction func passwordHideAndShowPressed(_ sender: UIButton) {
        hideAndShowButtonConfiguration(textField: passwordTextField, button: passwordHideAndShowButton)
    }
    //Confirm Password Hide and Show Button
    @IBAction func confirmPasswordHideAndShowPressed(_ sender: UIButton) {
        hideAndShowButtonConfiguration(textField: confirmPasswordTextField, button: confirmPassHideAndShowButton)
    }
    //Register Button
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmPass = confirmPasswordTextField.text {
            if password == confirmPass {
                Auth.auth().createUser(withEmail: email, password: password){_, error in
                    if let error {
                        self.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription, completionHandler: nil)
                    }else{
                        self.alertMessage(alertTitle: "Success", alertMesssage: "You have successfully registered."){
                            self.dismiss(animated: true)
                        }
                    }
                }
            }else{
                alertMessage(alertTitle: "Error", alertMesssage: "Passwords are not match!", completionHandler: nil)
            }
        }else{
            alertMessage(alertTitle: "Error", alertMesssage: "Please fill all the necessary parts!", completionHandler: nil)
        }
    }
    //Sign In Button
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

