import Foundation

class DecodableMapper {
    
    static func decode<T: Decodable>(result: Data) async throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(T.self, from: result)
            return result
        } catch let error {
            print("❌ Decoding failed, error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
