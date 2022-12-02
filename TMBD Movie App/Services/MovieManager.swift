//
//  MovieManager.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import Foundation

// MARK: - Movie Manager Delegate
protocol MovieManagerDelegate {
    func didUpdateWeather(_ movieManager: MovieManager, model : MovieModel)
    func didFailWithError(error: Error)
}

// MARK: - MovieManager
struct MovieManager {
    
    var delegate: MovieManagerDelegate?
    
    func performRequest(){
        let url = "\(URLConstants.baseURL)/\(URLConstants.type)/\(URLConstants.Category.nowPlaying)?\(URLConstants.apiKey)&\(URLConstants.page)"
        
        if let urlString = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, response, error in
                if let error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                if let data {
                    if let movieResult = self.parseJSON(data: data){
                        self.delegate?.didUpdateWeather(self, model: movieResult)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(data: Data) -> MovieModel? {
        do{
            let result = try JSONDecoder().decode(Result.self, from: data)
            let model = MovieModel(movieTitle: result.originalTitle)
            return model
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
