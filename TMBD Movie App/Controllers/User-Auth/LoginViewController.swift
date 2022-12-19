//
//  LoginViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 6.12.2022.
//

//MARK: - Frameworks
import UIKit
import FirebaseAuth

//MARK: - LoginViewController
class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var hideAndShowButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    
    //MARK: - Objects
    var rememberMe = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkRememberMe()
        closeKeyboard()
    }
    
    
    //MARK: - Actions
    //Forgot password button
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Segues.toResetPasswordVC, sender: nil)
    }
    //Login buton
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .large)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let error {
                    alertController.dismiss(animated: true, completion: nil);
                    strongSelf.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription)
                }else{
                    if strongSelf.rememberMe == true {
                        UserDefaults.standard.set("1", forKey: "RememberMe")
                        UserDefaults.standard.set(email, forKey: "Email")
                        UserDefaults.standard.set(password, forKey: "Password")
                    }else if strongSelf.rememberMe == false {
                        UserDefaults.standard.set("2", forKey: "RememberMe")
                    }
                    alertController.dismiss(animated: true, completion: nil);
                    self?.performSegue(withIdentifier: Segues.loginToTabBarVC, sender: nil)
                }
            }
        }
    }
    //Register button
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Segues.toRegisterVC, sender: nil)
    }
    //Password hide and show button
    @IBAction func hideAndShowPasswordButtonPressed(_ sender: UIButton) {
        hideAndShowButtonConfiguration(textField: passwordTextField, button: hideAndShowButton)
    }
    //Remember me button
    @IBAction func rememberMeButtonPressed(_ sender: UIButton) {
        if rememberMe == false {
            rememberMe = true
            rememberMeButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            rememberMeButton.alpha = 1
        }else if rememberMe == true {
            rememberMe = false
            rememberMeButton.setImage(UIImage(named: "tickbox"), for: .normal)
            rememberMeButton.alpha = 0.4
        }
    }
    
    //MARK: - Methods
    //Check remember me box
    func checkRememberMe(){
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "RememberMe") == "1" {
            rememberMeButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            rememberMeButton.alpha = 1
            rememberMe = true
            self.emailTextField.text = defaults.string(forKey: "Email")
            self.passwordTextField.text = defaults.string(forKey: "Password")
        }else {
            rememberMeButton.setImage(UIImage(named: "tickbox"), for: .normal)
            rememberMeButton.alpha = 0.4
            rememberMe = false
        }
    }
}
