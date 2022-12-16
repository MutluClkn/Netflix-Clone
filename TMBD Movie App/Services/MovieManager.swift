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
    

    //MARK: - Fetch a Specific Movie Details with External ID
    func fetchSpecificMovie(with externalId: String, completion: @escaping (Result<ExternalIDMovieData, Error>) -> Void){
        let url = "\(MovieConstants.baseURL)/find/\(externalId)?\(MovieConstants.apiKey)&language=en-US&external_source=imdb_id"
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
                        let movies = try decoder.decode(ExternalIDMovieData.self, from: data)
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
        let url = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(String(movieID))?\(MovieConstants.apiKey)&language=en-US"
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
    
    //MARK: - Fetch Youtube Video
    func fetchYoutubeVideo(with query: String, completion: @escaping (Result<YoutubeItems, Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let url = "\(YoutubeConstants.youtubeBaseURL)?q=\(query)&\(YoutubeConstants.youtubeApiKey)"
        
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
                        let movies = try decoder.decode(YoutubeData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(movies.items[0]))
                        }
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Fetch Genre Data
    func fetchGenreData(completion: @escaping (Result<GenreData, Error>) -> Void){
        if let urlString = URL(string: URLAddress().genreData) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, _, error in
                if let error {
                    print(error)
                    return
                }
                if let data {
                    do{
                        let decoder = JSONDecoder()
                        let genres = try decoder.decode(GenreData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(genres))
                        }
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Fetch Credits
    func fetchCredits(movieID: Int, completion: @escaping (Result<CreditsData, Error>) -> Void){
        let url = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(String(movieID))/credits?\(MovieConstants.apiKey)&language=en-US"
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
                        let casts = try decoder.decode(CreditsData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(casts))
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
