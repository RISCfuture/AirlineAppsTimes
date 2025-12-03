# Getting Started

Install and run AirlineAppsTimes to extract your flight times.

## Overview

AirlineAppsTimes reads your LogTen Pro flight logbook and formats the data for airline application forms. This guide walks you through installation and your first run.

## Prerequisites

Before using AirlineAppsTimes, ensure you have:

- **macOS 14** (Sonoma) or later
- **Xcode Command Line Tools** - Install with `xcode-select --install`
- **LogTen Pro for Mac** - The tool reads from your LogTen Pro database

## Installation

AirlineAppsTimes uses Swift Package Manager. Clone the repository and build:

```bash
git clone https://github.com/RISCfuture/AirlineAppsTimes.git
cd AirlineAppsTimes
swift build -c release
```

The compiled binary is located at `.build/release/airline-apps-times`.

### Optional: Install to PATH

Copy the binary to a location in your PATH for easier access:

```bash
cp .build/release/airline-apps-times /usr/local/bin/
```

## First Run

Run the tool with no arguments to use default settings:

```bash
airline-apps-times
```

This reads your LogTen Pro database from its default location and outputs flight times in AirlineApps format.

### Example Output

```
C172
PIC: 150.3  D/G: 0.0  SIC: 0.0  D/R: 45.2  TT: 195.5

B737
PIC: 1250.0  D/G: 125.0  SIC: 500.0  D/R: 0.0  TT: 1875.0
```

Each entry shows an aircraft type code followed by time breakdowns.

## Next Steps

- See <doc:CommandLineReference> for all available options
- See <doc:OutputFormats> to understand the different output formats
