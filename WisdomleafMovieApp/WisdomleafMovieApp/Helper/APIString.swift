//
//  APIString.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation


struct APIString {
    static let API_URL = "http://www.omdbapi.com"
    
    enum Endpoints {
        case getMovie
        case getMovieDetail
    }
}
