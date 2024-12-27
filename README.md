# AirlineAppsTimes

Uses your LogTen Pro logbook to calculate times for entry into AirlineApps.

## Requirements

AirlineAppsTimes is a macOS command-line tool written in Swift 6. To compile and
use it, you must be running macOS 13 or later, and you must have the Xcode
Developer Tools installed on your Mac.

You must have a recent copy of LogTen Pro for Mac installed on your computer.
This tool uses your LogTen Pro logbook to perform its calculations.

## Installation

AirlineAppsTimes uses Swift Package Manager, version 6.0 or later. Simply run
`swift run` to compile and run the project, or `swift build -c release` to build
a release binary that can be installed in the location of your choice.

## Usage

```
USAGE: airline-apps-times [--logten-file <logten-file>] [--logten-managed-object-model <logten-managed-object-model>]

OPTIONS:
  --logten-file <logten-file>
                          The LogTenCoreDataStore.sql file containing the logbook entries. (default: normal location)
  --logten-managed-object-model <logten-managed-object-model>
                          The location of the LogTen Pro managed object model file. (default: normal location)
  -h, --help              Show help information.
```

## Tests

No tests are provided. Hopefully it just works if you run it.
