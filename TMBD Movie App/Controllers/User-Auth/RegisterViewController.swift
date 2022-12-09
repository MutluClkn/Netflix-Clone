//
//  RegisterViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 6.12.2022.
//

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
        if emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" {
            if passwordTextField.text == confirmPasswordTextField.text {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: confirmPasswordTextField.text!){_, error in
                    if let error {
                        self.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription)
                    }else{
                        self.alertMessage(alertTitle: "Succes", alertMesssage: "Registration successed! You can return to the login screen by pressing the 'Sign In' button below.")
                    }
                }
            }else{
                alertMessage(alertTitle: "Error", alertMesssage: "Passwords are not match!")
            }
        }else{
            alertMessage(alertTitle: "Error", alertMesssage: "Please fill all the necessary parts!")
        }
    }
    //Sign In Button
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Methods
    //Hide and Show Button Configuration
    private func hideAndShowButtonConfiguration(textField: UITextField, button: UIButton){
        if textField.isSecureTextEntry == true {
            textField.isSecureTextEntry = false
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }else{
            textField.isSecureTextEntry = true
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
}

