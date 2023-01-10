# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Fixed

### Removed

## [1.2.1]

### Added

-   Request time log output added to debug logging
-   Flowgeek URL fields for categories and indicators

### Changed

-   Log entries now include a persistent request id to allow them to be correlated.
-   Now using asynchronous database connector throughout.
-   Using asynchronous file i/o
-   Improved data ingestion
-   Improved speed for time_range endpoint
-   Creating one data table per mdid instead of using partitioning
-   API responses now use orjson

### Fixed

-   Fixed server failing to start because of missing import in `logging.py`

## [1.1.1]

### Added

-   Request time log output added to debug logging
-   Minimum/maximum values are now being computed on ingestion and served alongside the time_range.

### Changed

-   Log entries now include a persistent request id to allow them to be correlated.
-   Now using asynchronous database connector throughout.
-   Using asynchronous file i/o
-   Improved data ingestion
-   Improved speed for time_range endpoint
-   Creating one data table per mdid instead of using partitioning
-   API responses now use orjson

### Fixed

-   Fixed server failing to start because of missing import in `logging.py`

## [1.0.1]

### Added

-   A changelog

## [1.0.0]

### Changed

-   The db schema

[unreleased]: https://github.com/Flowminder/flowkit-ui-backend/compare/v1.2.1...HEAD
[1.2.1]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.2.1
[1.1.1]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.1.1
[1.0.1]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.0.1
[1.0.0]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.0.0
