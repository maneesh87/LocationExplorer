import Foundation

class MockDataLoader {
    
    func getData(fromJSON filename: String) throws -> Data {
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json") else {
            throw MockError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            throw MockError.dataReadingFailed
        }
    }
    
}

enum MockError: Error {
    case fileNotFound
    case dataReadingFailed
}
