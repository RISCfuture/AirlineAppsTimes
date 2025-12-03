import Foundation

/// Errors that can occur when reading the LogTen Pro database.
///
/// These errors indicate problems accessing or parsing the LogTen Pro
/// database files. Common causes include:
/// - LogTen Pro not installed
/// - Incorrect file paths
/// - Incompatible database version
enum Errors: Error {
  /// The Core Data store could not be initialized.
  ///
  /// This typically occurs when the LogTen Pro database file doesn't exist
  /// or the managed object model file is missing or incompatible.
  ///
  /// - Parameter path: The path that failed to load.
  case couldntCreateStore(path: URL)

  /// A required property is missing from a Core Data model.
  ///
  /// This can occur if the LogTen Pro database schema has changed
  /// in a way that's incompatible with this tool.
  ///
  /// - Parameters:
  ///   - property: The name of the missing property.
  ///   - model: The name of the model that should contain the property.
  case missingProperty(_ property: String, model: String)
}

extension Errors: LocalizedError {
  var errorDescription: String? {
    switch self {
      case .couldntCreateStore(let path):
        return String(localized: "Couldn’t create Core Data store for “\(path.lastPathComponent)”")
      case let .missingProperty(property, model):
        return String(localized: "\(model) must have a property named “\(property)”")
    }
  }
}
