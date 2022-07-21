//
//  ApiError.swift
//  BasicMVVMWithTest
//
//  Created by Atakan Cengiz KURT on 21.07.2022.
//

import Foundation

///Custom `Error` for Network Manager fail cases
enum ApiError: Error {
    case unknowError
    case connectionError
    case notFound
    case serverError
    case timeOut
    case badRequest
}

//MARK: - Helpers
extension ApiError: CustomStringConvertible {
    ///For each error type return the appropriate description
    public var description: String {
        switch self {
        case .connectionError:
            return "Please make sure your are connected to the internet and try again."
        case .notFound:
            return "The value you were looking for was not found. Try looking for something else."
        case .serverError:
            return "There is a problem with the server. Please try again."
        case .timeOut:
            return "Request timed out."
        case .badRequest:
            return "Bad request. Please try again."
        case .unknowError:
            return "Something went wrong. Please try again."
        }
    }
}
