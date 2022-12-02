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
    let url = "\(URLConstants.baseURL)/\(URLConstants.type)/\(URLConstants.Category.nowPlaying)?\(URLConstants.apiKey)&\(URLConstants.page)"
    
    var delegate: MovieManagerDelegate?
    
    func performRequest(){
        if let urlString = URL(string: self.url){
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
            let result = try JSONDecoder().decode(MovieData.self, from: data)
            let model = MovieModel(originalTitle: result.results[0].originalTitle)
            return model
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
