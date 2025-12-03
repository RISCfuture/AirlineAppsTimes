# ``airline_apps_times``

Extract flight times from LogTen Pro for airline applications.

@Metadata {
    @DisplayName("AirlineAppsTimes")
}

## Overview

AirlineAppsTimes is a macOS command-line tool that reads your LogTen Pro flight logbook database and formats flight times for entry into airline application forms. The tool supports two output formats:

- **AirlineApps** - For the AirlineApps.com online application system
- **Southwest** - For Southwest Airlines pilot applications

The tool automatically aggregates your flight hours by aircraft type, calculating PIC, SIC, dual given, dual received, and total time for each type you've flown.

### Quick Start

Build and run the tool with default settings:

```bash
swift build -c release
.build/release/airline-apps-times
```

The tool reads your LogTen Pro database from its default location and outputs flight times in AirlineApps format.

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:CommandLineReference>
- <doc:OutputFormats>

### Output Formatting

- ``Formatter``
- ``AirlineAppsFormatter``
- ``SouthwestFormatter``

### Flight Data

- ``TimeEntry``
- ``Logbook``
- ``Flight``
- ``Aircraft``
- ``AircraftType``

### LogTen Pro Integration

- ``Reader``

### Error Handling

- ``Errors``
