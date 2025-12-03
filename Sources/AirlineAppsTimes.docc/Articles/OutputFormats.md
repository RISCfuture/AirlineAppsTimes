# Understanding Output Formats

Learn about the two output formats and how to interpret the results.

## Overview

AirlineAppsTimes supports two output formats designed for specific airline application systems. Each format includes different fields and may filter aircraft types differently.

## AirlineApps Format

The default format, designed for the AirlineApps.com online application system.

### Fields

| Field | Description |
|-------|-------------|
| **PIC** | Pilot in Command time |
| **D/G** | Dual Given (instruction given) |
| **SIC** | Second in Command time |
| **D/R** | Dual Received (instruction received) |
| **TT** | Total Time |

### Example Output

```
C172
  PIC: 150.3
  D/G: 0.0
  SIC: 0.0
  D/R: 45.2
  TT:  195.5

B737
  PIC: 1250.0
  D/G: 125.0
  SIC: 500.0
  D/R: 0.0
  TT:  1875.0
```

### Aircraft Filtering

The AirlineApps format includes **all aircraft types** in your logbook, regardless of category or engine type.

## Southwest Format

Specialized format for Southwest Airlines pilot applications.

### Fields

| Field | Description |
|-------|-------------|
| **Date last flown** | Most recent flight date for this type |
| **PIC time** | Pilot in Command time |
| **SIC time** | Second in Command time |
| **Total time** | PIC + SIC only (excludes dual given/received) |
| **Total time last 36 months** | PIC + SIC in the last 36 months |

### Example Output

```
B737
  Date last flown: 12/1/24
  PIC time: 1250.0
  SIC time: 500.0
  Total time: 1750.0
  Total time last 36 months: 850.0
```

### Aircraft Filtering

The Southwest format **only includes turbine-powered airplanes**. Aircraft must meet both criteria:

1. **Category:** Airplane
2. **Engine Type:** One of:
   - Turbine
   - Turbo-prop
   - Turbo-fan
   - Turbojet
   - Jet

Helicopters, gliders, and piston aircraft are excluded from Southwest format output.

## Time Categories Explained

### PIC (Pilot in Command)

Time during which you were the pilot responsible for the operation and safety of the aircraft. This is typically time when you were the sole manipulator of the controls or were designated as PIC in a multi-crew environment.

### SIC (Second in Command)

Time acting as second in command of an aircraft requiring more than one pilot. Common in Part 121 or Part 135 operations, or in aircraft type-certificated for two pilots.

### Dual Given

Time spent providing flight instruction to another pilot. This is logged when you are acting as a flight instructor.

### Dual Received

Time spent receiving flight instruction. This includes initial training, type ratings, and proficiency training.

### Total Time

In AirlineApps format, this is all flight time (PIC + SIC + Dual Given + Dual Received). In Southwest format, this is only PIC + SIC.

## Choosing a Format

Use `--format airlineapps` (default) when:
- Applying through the AirlineApps.com system
- You need to see all aircraft types
- You need dual given/received breakdowns

Use `--format southwest` when:
- Applying to Southwest Airlines
- You only need turbine airplane time
- You need the 36-month rolling totals
