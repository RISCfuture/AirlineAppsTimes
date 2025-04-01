import Foundation

enum Errors: Error {
    case couldntCreateStore(path: URL)
    case missingProperty(_ property: String, model: String)
}

extension Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
            case let .couldntCreateStore(path):
                return String(localized: "Couldn’t create Core Data store for “\(path.lastPathComponent)”")
            case let .missingProperty(property, model):
                return String(localized: "\(model) must have a property named “\(property)”")
        }
    }
}
