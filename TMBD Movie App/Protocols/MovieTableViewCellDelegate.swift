//
//  MovieTableViewCellDelegate.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 12.12.2022.
//

import Foundation

// MARK: - MovieTableViewCellDelegate
protocol MovieTableViewCellDelegate: AnyObject {
    func updateViewController(_ cell: MovieTableViewCell, model: DetailMovieModel)
}
