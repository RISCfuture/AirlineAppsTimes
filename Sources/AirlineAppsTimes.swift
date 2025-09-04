import ArgumentParser
import CoreData

@main
struct AirlineAppsTimes: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Extract flight times from LogTen Pro for airline applications.",
        discussion: """
            This tool reads your LogTen Pro logbook database and formats flight times
            for entry into airline application forms (AirlineApps and Southwest).
            """,
        version: "1.0.0"
    )

    private static let logtenDataStorePath = "Library/Group Containers/group.com.coradine.LogTenPro/LogTenProData_6583aa561ec1cc91302449b5/LogTenCoreDataStore.sql"
    private static let managedObjectModelPath = "LogTen.app/Contents/Resources/CNLogBookDocument.momd"

    private static var logtenDataStoreURL: URL {
        let homeDir = FileManager.default.homeDirectoryForCurrentUser
        return homeDir.appendingPathComponent(logtenDataStorePath)
    }

    private static var managedObjectModelURL: URL { .applicationDirectory.appending(path: managedObjectModelPath) }

    @Option(help: "Output format")
    var format: OutputFormat = .airlineapps

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
        let formatter = format.formatter
        let entries = generateTimes(logbook: logbook, formatter: formatter)

        for entry in entries {
            print(formatter.format(entry))
            print()
        }
    }

    private func generateTimes(logbook: Logbook, formatter: Formatter) -> [TimeEntry] {
        let entries = logbook.flights
            .filter { flight in
                guard let aircraftType = flight.aircraft?.type else { return false }
                return formatter.shouldIncludeAircraft(aircraftType)
            }
            .reduce(into: [String: TimeEntry]()) { entries, flight in
                guard let type = flight.aircraft?.type.typeCode else { return }
                if let entry = entries[type] {
                    entry.addFlight(flight)
                } else {
                    entries[type] = .init(flight: flight)
                }
            }

        return entries.values.sorted().reversed()
    }

    enum OutputFormat: String, CaseIterable, ExpressibleByArgument {
        case airlineapps
        case southwest

        var formatter: Formatter {
            switch self {
                case .airlineapps:
                    return AirlineAppsFormatter()
                case .southwest:
                    return SouthwestFormatter()
            }
        }
    }
}
