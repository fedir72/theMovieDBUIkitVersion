//
//  MovieStore.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 28.01.2022.
//

import Foundation
import UIKit

class MovieStore: MovieService {

    static let shared = MovieStore()
    private init() {}

    private let apiKey = "2f3a88e5c9dde5f1837f7134848c4432"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder

    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURlandDecode(url: url, completion: completion)

    }

    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURlandDecode(url: url, params: [
            "language":"en-US",
            "include_adult":"false",
            "region":"US",
            "querry":query
        ], completion: completion)
    }


    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURlandDecode(url: url, params: [
                   "append_to_response": "videos,credits"
               ], completion: completion)
    }

    private func loadURlandDecode<D: Decodable>(url: URL, params: [String:String]? = nil, completion: @escaping ((Result<D,MovieError>) -> Void)) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(MovieError.invalidEndpoint))
            return
        }
        var querryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            querryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = querryItems

        guard let finalUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        urlSession.dataTask(with: finalUrl) { [weak self] data, responce, eror in
            guard let self = self else {return}
            if eror != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }

            guard let httpResponce = responce as? HTTPURLResponse, 200..<300 ~= httpResponce.statusCode else{
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }

            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }

            do {
                let decodeResponce = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodeResponce), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }

    private func executeCompletionHandlerInMainThread<D:Decodable>(with result: Result<D,MovieError>,completion: @escaping ((Result<D,MovieError>) -> Void) ) {
        DispatchQueue.main.async { completion(result)}
    }

}

import Foundation

//class MovieStore: MovieService {
//
//    static let shared = MovieStore()
//    private init() {}
//
//    private let apiKey = "2f3a88e5c9dde5f1837f7134848c4432"
//    private let baseAPIURL = "https://api.themoviedb.org/3"
//    private let urlSession = URLSession.shared
//    private let jsonDecoder = Utils.jsonDecoder
//
//    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
//        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//        self.loadURLAndDecode(url: url, completion: completion)
//    }
//
//    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
//        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//        self.loadURLAndDecode(url: url, params: [
//            "append_to_response": "videos,credits"
//        ], completion: completion)
//    }
//
//    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
//        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//        self.loadURLAndDecode(url: url, params: [
//            "language": "en-US",
//            "include_adult": "false",
//            "region": "US",
//            "query": query
//        ], completion: completion)
//    }
//
//    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
//        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//
//        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
//        if let params = params {
//            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
//        }
//
//        urlComponents.queryItems = queryItems
//
//        guard let finalURL = urlComponents.url else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//
//        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
//            guard let self = self else { return }
//
//            if error != nil {
//                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
//                return
//            }
//
//            guard let data = data else {
//                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
//                return
//            }
//
//            do {
//                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
//                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
//            } catch {
//                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
//            }
//        }.resume()
//    }
//
//    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
//        DispatchQueue.main.async {
//            completion(result)
//        }
//    }
//
//
//
//}
