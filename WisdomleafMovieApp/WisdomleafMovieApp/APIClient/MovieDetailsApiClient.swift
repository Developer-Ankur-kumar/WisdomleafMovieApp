//
//  MovieDetailsApiClient.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation

final class MovieDetailsApiClient{
    
    func fetchMovieDetails(selectedMovieID:String,
                           completionHandler:@escaping(Result<MovieDetailResponse,DataError>) -> Void){
        
    NetworkManager.shared.getData(endpoint: .getMovieDetail, params: ["apikey": "7ce45ee2",
                                                                      "i": selectedMovieID,
                                                                    "plot": "full"]) {(result: Result<MovieDetailResponse, DataError>) in
            switch result {
            case .success(let moviesDetails):
                completionHandler(.success(moviesDetails))
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
