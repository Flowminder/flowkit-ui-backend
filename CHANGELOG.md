# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added

### Changed

### Fixed
- Fixed profile page erroring due to a change in the auth0 api
- Fixed not deleting data when patching a dataset
- User actions now restricted to the logged in user only

### Removed

## [1.3.1]
### Added
- Added new endpoint 'csv' to return a query as a CSV text object.


### Fixed
- Fixed users not being able to view their own profile


## [1.3.0]
### Added
- Access to datasets is now restricted based on the scopes present in the provided token.
- Added new endpoint `scope_mapping` to mark and unmark a dataset as accessible with a scope.

### Changed
- The `query` endpoint can now optionally return just the identifiers for datasets instead of complete datasets
- `categories`, `indicators`, `temporal_resolutions`, `spatial_resolutions`, and `indicators_for_category` endpoints will only return items where the provided token permits access to at least one dataset.

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

[unreleased]: https://github.com/Flowminder/flowkit-ui-backend/compare/v1.3.1...HEAD
[1.3.1]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.3.1
[1.3.0]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.3.0
[1.2.1]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.2.1
[1.1.1]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.1.1
[1.0.1]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.0.1
[1.0.0]: https://github.com/Flowminder/flowkit-ui-backend/releases/tag/v1.0.0
