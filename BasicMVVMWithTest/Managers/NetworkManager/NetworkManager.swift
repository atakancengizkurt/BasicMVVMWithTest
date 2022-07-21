//
//  NetworkManager.swift
//  BasicMVVMWithTest
//
//  Created by Atakan Cengiz KURT on 21.07.2022.
//

import Foundation

//MARK: - Networking
protocol Networking {
    func request<T:Codable>(request: RequestModel, completion: @escaping(Result<[T], ApiError>) -> Void)
}


//MARK: - Network Manager
final class NetworkManager: Networking {
    //MARK: Properties
    ///Shared url session
    private var session: URLSession
    
    //MARK: init
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    /// Use this func to making a network call request
    /// - Parameters:
    ///   - request: Any model that confirms `RequestModel`
    ///   - completion: Escaping closure
    func request<T: Codable>(request: RequestModel, completion: @escaping (Result<[T], ApiError>) -> Void)  {
        //TODO: Loading animation
        guard let generatedRequest = request.generateRequest() else {
            //TODO: Loading animation
            completion(.failure(.badRequest))
            return
        }
        
        let task = session.dataTask(with: generatedRequest) { data, response, error in
            //TODO: Loading animation
            if error != nil || data == nil {
                completion(.failure(.unknowError))
            }
            if let apiError = self.returnResponseErrorIfNeeded(response: response) {
                completion(.failure(apiError))
            }
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode([T].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.unknowError))
            }
        }
        task.resume()
    }
}


// MARK: - Helpers
private extension NetworkManager {
    func returnError(with responseCode: Int) -> ApiError {
        switch responseCode{
        case 400:
            return .notFound
        case 403:
            return .unknowError
        case 404:
            return .notFound
        case 500:
            return .serverError
        default:
            return .unknowError
        }
    }
    
    func returnResponseErrorIfNeeded(response: URLResponse?) -> ApiError? {
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            return returnError(with: httpResponse.statusCode)
        }
        return nil
    }
}


