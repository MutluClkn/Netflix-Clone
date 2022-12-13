//
//  MovieManager.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

//MARK: - Frameworks
import Foundation

//MARK: - MovieManager
struct MovieManager {

    //MARK: - Fetch Movie
    func performRequest(url: String, completion: @escaping (Result<MovieData, Error>) -> Void){
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
                            completion(.success(movies))
                        }
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Fetch Search & Query
    func fetchSearchQuery(with query: String, url: String, completion: @escaping (Result<MovieData, Error>) -> Void){
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
                            completion(.success(movies))
                        }
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    

    //MARK: - Fetch Specific Movie with External ID
    func fetchMovie(with externalId: String, completion: @escaping (Result<MovieData, Error>) -> Void){
        let url = "\(URLConstants.baseURL)/find/\(externalId)?\(URLConstants.apiKey)&language=en-US&external_source=imdb_id"
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
                            completion(.success(movies))
                        }
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Fetch Movie Details
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsData, Error>) -> Void){
        let url = "\(URLConstants.baseURL)/\(URLConstants.type)/\(String(movieID))?\(URLConstants.apiKey)&language=en-US"
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
                        let movies = try decoder.decode(MovieDetailsData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(movies))
                        }
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
