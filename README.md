# AirlineAppsTimes

Extract flight times from LogTen Pro for airline applications.

This tool reads your LogTen Pro logbook database and formats flight times
for entry into airline application forms (AirlineApps and Southwest).

## Requirements

AirlineAppsTimes is a macOS command-line tool written in Swift 6. To compile and
use it, you must be running macOS 14 or later, and you must have the Xcode
Developer Tools installed on your Mac.

You must have a recent copy of LogTen Pro for Mac installed on your computer.
This tool uses your LogTen Pro logbook to perform its calculations.

## Installation

AirlineAppsTimes uses Swift Package Manager, version 6.0 or later. Simply run
`swift run` to compile and run the project, or `swift build -c release` to build
a release binary that can be installed in the location of your choice.

## Usage

```
OVERVIEW: Extract flight times from LogTen Pro for airline applications.

This tool reads your LogTen Pro logbook database and formats flight times
for entry into airline application forms (AirlineApps and Southwest).

USAGE: airline-apps-times [--format <format>] [--logten-file <logten-file>] [--logten-managed-object-model <logten-managed-object-model>]

OPTIONS:
  --format <format>       Output format (values: airlineapps, southwest; default: airlineapps)
  --logten-file <logten-file>
                          The LogTenCoreDataStore.sql file containing the logbook entries. (default: normal location)
  --logten-managed-object-model <logten-managed-object-model>
                          The location of the LogTen Pro managed object model file. (default: normal location)
  --version               Show the version.
  -h, --help              Show help information.
```

## Tests

No tests are provided. Hopefully it just works if you run it.
