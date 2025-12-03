# Command-Line Reference

Complete reference for all command-line options.

## Overview

AirlineAppsTimes accepts several options to customize its behavior. All options have sensible defaults, so in most cases you can run the tool with no arguments.

## Usage

```
airline-apps-times [--format <format>] [--logten-file <path>] [--logten-managed-object-model <path>]
```

## Options

### --format

Specifies the output format for flight times.

**Values:**
- `airlineapps` (default) - Format for AirlineApps.com applications
- `southwest` - Format for Southwest Airlines applications

**Example:**
```bash
airline-apps-times --format southwest
```

See <doc:OutputFormats> for details on each format.

### --logten-file

Path to the LogTen Pro database file.

**Default:** `~/Library/Group Containers/group.com.coradine.LogTenPro/LogTenProData_*/LogTenCoreDataStore.sql`

Use this option if your LogTen Pro database is in a non-standard location or if you want to process a backup.

**Example:**
```bash
airline-apps-times --logten-file /path/to/LogTenCoreDataStore.sql
```

### --logten-managed-object-model

Path to the LogTen Pro Core Data model file.

**Default:** `/Applications/LogTen.app/Contents/Resources/CNLogBookDocument.momd`

Use this option if LogTen Pro is installed in a non-standard location.

**Example:**
```bash
airline-apps-times --logten-managed-object-model /path/to/CNLogBookDocument.momd
```

## Built-in Options

### --help, -h

Display usage information and exit.

```bash
airline-apps-times --help
```

### --version

Display the version number and exit.

```bash
airline-apps-times --version
```

## Examples

### Basic Usage

Run with all defaults (AirlineApps format, standard LogTen paths):

```bash
airline-apps-times
```

### Southwest Format

Output in Southwest Airlines format:

```bash
airline-apps-times --format southwest
```

### Custom Database Location

Process a LogTen backup file:

```bash
airline-apps-times --logten-file ~/Backups/LogTenCoreDataStore.sql
```

### All Options Combined

```bash
airline-apps-times \
    --format southwest \
    --logten-file /custom/path/LogTenCoreDataStore.sql \
    --logten-managed-object-model /custom/LogTen.app/Contents/Resources/CNLogBookDocument.momd
```
