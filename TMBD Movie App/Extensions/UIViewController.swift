//
//  UIViewController.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 9.12.2022.
//

//MARK: - Frameworks
import UIKit

//MARK: - UIViewController
extension UIViewController{
    
    //MARK: - UIAlertController
    func alertMessage(alertTitle: String, alertMesssage: String, completionHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: alertTitle, message: alertMesssage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completionHandler?()
        }
        
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Hide and Show Button Configuration
    func hideAndShowButtonConfiguration(textField: UITextField, button: UIButton){
        if textField.isSecureTextEntry == true {
            textField.isSecureTextEntry = false
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }else{
            textField.isSecureTextEntry = true
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    //MARK: - Hide Keyboard
    func closeKeyboard(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardPressed))
        view.addGestureRecognizer(gestureRecognizer)
    }
    @objc func closeKeyboardPressed(){
        view.endEditing(true)
    }
    
    //MARK: - Gradient
    func addGradient(viewTest: UIView){
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.darkText.cgColor
        ]
        // gradient.frame = viewTest.bounds
        gradient.frame.size.height = viewTest.frame.height
        gradient.frame.size.width = viewTest.frame.width * 20
        viewTest.layer.addSublayer(gradient)
    }
}
