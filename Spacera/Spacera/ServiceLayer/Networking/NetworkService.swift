//
//  NetworkService.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

typealias RocketResult = Result<[Rocket]?, NetworkError>
typealias LaunchResult = Result<[Launch]?, NetworkError>

protocol NetworkServiceProtocol {
    func getRockets(completion: @escaping (RocketResult) -> Void)
    func getLaunches(completion: @escaping (LaunchResult) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    // MARK: - Rockets request
    func getRockets(completion: @escaping (RocketResult) -> Void) {
        guard let apiURL = URL(string: Links.rockets.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: apiURL)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([Rocket].self, from: data)
                //                DispatchQueue.main.async {
                completion(.success(result))
                //                }
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
    func getLaunches(completion: @escaping (LaunchResult) -> Void) {
        guard let apiURL = URL(string: Links.launches.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: apiURL)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([Launch].self, from: data)
                //                DispatchQueue.main.async {
                completion(.success(result))
                //                }
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}

