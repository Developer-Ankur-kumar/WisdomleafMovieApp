//
//  NetworkManager.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation


enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
    case Network(message:Error?)

}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}

    
    func getData<T: Decodable>(endpoint: APIString.Endpoints, params: [String: Any], completion: @escaping (Result<T, DataError>) -> Void) {
        guard let url = URL(string: "\(APIString.API_URL)\(params.queryItems())") else{
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            
            print(String(data: data, encoding: .utf8) as Any)
            do{
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            }catch{
                completion(.failure(.Network(message: error)))
                print(error)
            }
            
        }.resume()
    }
}


extension Dictionary where Key == String, Value == Any {
    func queryItems() -> String {
        var components = URLComponents()
        print(components.url!)
        components.queryItems = map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        return (components.url?.absoluteString)!
    }
}
