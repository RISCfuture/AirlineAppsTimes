import ArgumentParser
import CoreData

@main
struct AirlineAppsTimes: AsyncParsableCommand {
    private static let logtenDataStorePath = "Library/Group Containers/group.com.coradine.LogTenPro/LogTenProData_6583aa561ec1cc91302449b5/LogTenCoreDataStore.sql"
    private static let managedObjectModelPath = "LogTen.app/Contents/Resources/CNLogBookDocument.momd"

    private static var logtenDataStoreURL: URL {
        let homeDir = FileManager.default.homeDirectoryForCurrentUser
        return homeDir.appendingPathComponent(logtenDataStorePath)
    }

    private static var managedObjectModelURL: URL { .applicationDirectory.appending(path: managedObjectModelPath) }

    @Option(help: "The LogTenCoreDataStore.sql file containing the logbook entries. (default: normal location)",
            completion: .file(extensions: ["sql"]),
            transform: { .init(filePath: $0, directoryHint: .notDirectory) })
    var logtenFile = Self.logtenDataStoreURL

    @Option(help: "The location of the LogTen Pro managed object model file. (default: normal location)",
            completion: .file(extensions: ["momd"]),
            transform: { .init(filePath: $0, directoryHint: .isDirectory) })
    var logtenManagedObjectModel = Self.managedObjectModelURL

    mutating func run() async throws {
        let logbook = try await Reader(storeURL: logtenFile, modelURL: logtenManagedObjectModel).read()
        let entries = generateTimes(logbook: logbook)

        for entry in entries {
            print(entry.output)
            print()
        }
    }

    private func generateTimes(logbook: Logbook) -> [TimeEntry] {
        let entries = logbook.flights.reduce(into: [String: TimeEntry]()) { entries, flight in
            guard let type = flight.aircraft?.type.typeCode else { return }
            if let entry = entries[type] {
                entry.addFlight(flight)
            } else {
                entries[type] = .init(flight: flight)
            }
        }

        return entries.values.sorted().reversed()
    }
}
