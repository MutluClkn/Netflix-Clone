//
//  MovieManager.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

import Foundation

// MARK: - MovieManager
struct MovieManager {

    //MARK: - Fetch Movie
    func performRequest(url: String, completion: @escaping (MovieData) -> Void){
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
    
    //MARK: - Fetch Search & Query
    func fetchSearchQuery(with query: String, url: String, completion: @escaping (MovieData) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        if let urlString = URL(string: url + query) {
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
