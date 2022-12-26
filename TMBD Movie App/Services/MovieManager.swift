//
//  MovieManager.swift
//  TMBD Movie App
//
//  Created by Mutlu Çalkan on 2.12.2022.
//

//MARK: - Frameworks
import Foundation

//MARK: - Enums
//Selection of constant movie URL addresses
enum MovieURL: String{
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case discover
    case none
}

//Movie selection related to movie ID
enum movieIDSelection{
    case movieDetails
    case credits
    case videos
    case none
}

//Errors
enum NetworkingError: Error{
    case invalidURL
    case custom(error: Error)
    case invalidData
    case failedToDecode(error: Error)
}

//MARK: - MovieManager
final class MovieManager {
    
    static let shared = MovieManager()
    
    private init() {}
    
    //MARK: - Fetch Movie
    func performRequest<T: Codable>(type: T.Type, query q: String, externalID exID: String, movieID mID: Int, movieIDSelection selection: movieIDSelection, movieURL: MovieURL, completion: @escaping (Result<T, Error>) -> Void){
        
        var url = ""
        
        switch movieURL{
        case .nowPlaying:
            url = URLAddress().urlNowPlaying
        case .popular:
            url = URLAddress().urlPopular
        case .topRated:
            url = URLAddress().urlTopRated
        case .upcoming:
            url = URLAddress().urlUpcoming
        case .discover:
            url = URLAddress().discoverURL
        case .none:
            url = ""
        default:
            break
        }
        if mID != 0{
            switch selection{
            case .movieDetails:
                url = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(String(mID))?\(MovieConstants.apiKey)&language=en-US"
            case .credits:
                url = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(String(mID))/credits?\(MovieConstants.apiKey)&language=en-US"
            case .videos:
                url = "\(MovieConstants.baseURL)/\(MovieConstants.type)/\(String(mID))/videos?\(MovieConstants.apiKey)&language=en-US"
            case .none:
                url = ""
            default:
                break
            }
        }
        
        if q != "" {
            guard let q = q.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            url = URLAddress().searchQueryURL + q
        }
        
        if exID != "" {
            url = "\(MovieConstants.baseURL)/find/\(exID)?\(MovieConstants.apiKey)&language=en-US&external_source=imdb_id"
        }
        
        if type == GenreData.self {
            url = URLAddress().genreData
        }
        
        guard let urlString = URL(string: url) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { data, _, error in
            if let error {
                completion(.failure(NetworkingError.custom(error: error)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let res = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            }catch{
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }
        task.resume()
    }
}
