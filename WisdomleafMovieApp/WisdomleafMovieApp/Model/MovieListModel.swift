//
//  MovieListModel.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation

struct MovieSearchResposne: Codable {
    let search: [MovieListModel]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct MovieListModel: Codable {
    let title :String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    var isFavourite: Bool = false
    var imageUrl: URL?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = try container.decode(String.self, forKey: .year)
        self.imdbID = try container.decode(String.self, forKey: .imdbID)
        self.type = try container.decode(String.self, forKey: .type)
        self.poster = try container.decode(String.self, forKey: .poster)
        
        self.imageUrl = URL(string: poster)
    }
    
    mutating func update(favourite: Bool) {
        self.isFavourite = favourite
    }
}

extension MovieListModel: Equatable {
    static func == (lhs: MovieListModel, rhs: MovieListModel) -> Bool {
        lhs.imdbID == rhs.imdbID
    }
}
