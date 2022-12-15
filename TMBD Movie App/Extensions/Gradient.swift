//
//  Gradient.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 15.12.2022.
//

import UIKit

extension UIViewController{
    func addGradient(viewTest: UIView){
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.darkText.cgColor
        ]
        gradient.frame = viewTest.bounds
        viewTest.layer.addSublayer(gradient)
    }
}
