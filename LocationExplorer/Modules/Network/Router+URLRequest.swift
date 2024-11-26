import Foundation

extension Router {
    
    func createUrlRequest(withBaseURL baseURL: String) throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + self.path) else {
            throw NetworkError.invalidRequest
        }
        
        if let queryParameters = self.queryParameters, !queryParameters.isEmpty {
            var parameters: [String: Any] = [:]
            
            queryParameters.forEach { tuple in
                parameters [tuple.key] = tuple.value
            }
            components.queryItems = parameters.compactMap({ (key, value) -> URLQueryItem in
                URLQueryItem(name: key, value: "\(value)")
            })
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidRequest
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.httpBody = self.body
                
        urlRequest.addValue(
            contentType,
            forHTTPHeaderField: "Content-Type"
        )
        
        if let requestHeaders = self.headers, !requestHeaders.isEmpty {
            for requestHeader in requestHeaders.enumerated() {
                urlRequest.setValue("\(requestHeader.element.value)", forHTTPHeaderField: requestHeader.element.key)
            }
        }
        return urlRequest
    }
    
}
