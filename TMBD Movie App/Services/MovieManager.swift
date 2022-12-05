//
//  MovieManager.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import Foundation

// MARK: - MovieManager
struct MovieManager {
    let url = "\(URLConstants.baseURL)/\(URLConstants.type)/\(URLConstants.Category.nowPlaying)?\(URLConstants.apiKey)&\(URLConstants.page)"

    func performRequest(completion: @escaping (MovieData) -> Void){
        if let urlString = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, _, error in
                if let error {
                    print(error)
                    return
                }
                if let data {
                    do{
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(MovieData.self, from: data)
                        DispatchQueue.main.async {
                            completion(movies)
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
}
