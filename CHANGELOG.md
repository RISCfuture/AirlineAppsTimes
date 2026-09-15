# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Require Swift 6.4 and macOS 27.
- Adopt strict memory safety.
- Build, test, and release on the Xcode 27 runner image.

## [1.0.0] - 2026-09-15

### Added

- `airline-apps-times`, a macOS command-line tool that reads a LogTen Pro for
  Mac logbook and totals flight time by aircraft type for entry into airline
  application forms.
- AirlineApps output format (the default), listing PIC, dual given, SIC, dual
  received, and total time for every real aircraft type in the logbook.
- Southwest output format, listing date last flown, PIC time, SIC time, total
  time, and total time in the last 36 months, restricted to turbine-powered
  airplanes.
- Simulators, FTDs, and BATDs are excluded from the aircraft totals, since they
  log no flight time and would overstate the totals on an application.
- `--format` to choose the output format, and `--logten-file` and
  `--logten-managed-object-model` to override the default locations of the
  LogTen Pro data store and managed object model.

[Unreleased]: https://github.com/RISCfuture/AirlineAppsTimes/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/RISCfuture/AirlineAppsTimes/releases/tag/v1.0.0
