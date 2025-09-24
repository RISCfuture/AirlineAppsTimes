import Foundation

enum Errors: Error {
  case couldntCreateStore(path: URL)
  case missingProperty(_ property: String, model: String)
}

extension Errors: LocalizedError {
  var errorDescription: String? {
    switch self {
      case .couldntCreateStore(let path):
        return String(localized: "Couldn’t create Core Data store for “\(path.lastPathComponent)”")
      case .missingProperty(let property, let model):
        return String(localized: "\(model) must have a property named “\(property)”")
    }
  }
}
