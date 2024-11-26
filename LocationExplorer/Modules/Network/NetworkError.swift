import Foundation

enum NetworkError: Error, Equatable {
    case invalidRequest
    case invalidResponse
    case badURL
    case noData
    case decodingError
    case requestFailed
    case serverError(statusCode: Int)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .decodingError:
            return "Decoding Error"
        case .invalidRequest:
            return "Invalid Request"
        case .invalidResponse:
            return "Invalid Response"
        case .noData:
            return "No Data"
        case .requestFailed:
            return "Request Failed"
        case .serverError(let statusCode):
            return "Server Error: \(statusCode)"
        }
    }
}
