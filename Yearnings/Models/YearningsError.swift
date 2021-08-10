//
//  YearningsError.swift
//  Yearnings
//

//

import Foundation

enum YearningsError: Error, LocalizedError {
    case httpError(statusCode: Int)
    case graphqlError(error: Error)
    case accountVaultPositionNotFound

    var errorDescription: String? {
        switch self {
        case .httpError(let statusCode):
            return "http error - status code \(statusCode)"
        case .graphqlError(let error):
            return "graphql error - \(error.localizedDescription)"
        case .accountVaultPositionNotFound:
            return "account vault position not found"
        }
    }
}

struct YearningsErrorType: Identifiable {
    let id = UUID()
    let error: YearningsError
}
