//
//  MovieListApiClient.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation

final class MovieListApiClient {
    
    func fetchMovieList(completionHandler: @escaping (Result<[MovieListModel], DataError>) -> Void) {
        
        NetworkManager.shared.getData(endpoint: .getMovie, params: ["apikey": "7ce45ee2",
                                                                    "type": "movie",
                                                                    "s": "Don",
                                                                    "page": "1"]) { (result: Result<MovieSearchResposne, DataError>) in
            switch result {
            case .success(let movies):
                let movies = movies.search
                completionHandler(.success(movies))
            case .failure(let error):
                print("Failed to fetch movies: \(error.localizedDescription)")
                completionHandler(.failure(.network(error)))
            }
        }
    }
}
