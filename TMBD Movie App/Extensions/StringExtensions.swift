//
//  StringExtensions.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 5.12.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
