-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/* SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO"; */
/* SET AUTOCOMMIT = 0; */
/* START TRANSACTION; */
/* SET time_zone = "+00:00"; */
--
-- Database: `flowkit_ui_backend`
--
CREATE DATABASE IF NOT EXISTS `flowkit_ui_backend` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category` generated from model 'Category'
-- The category of data
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`category` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `category_id` VARCHAR(255) NOT NULL COMMENT 'A machine-readable, unique category ID',
  `type` ENUM('single_location', 'flow') NOT NULL COMMENT 'TODO: should use data_type enum. The type of data. single_location for data that relates to only one spatial entity and flow for data that describes movement from one to another.',
  `order` INT DEFAULT NULL COMMENT 'The order of categories in the UI',
  `flowgeek_url` TEXT DEFAULT NULL COMMENT 'A link to a Flowgeek page with further information about this category',
  `label` TEXT DEFAULT NULL COMMENT 'A human-readable label for this category',
  `description` TEXT DEFAULT NULL COMMENT 'A description of this category, what it represents, how it is calculated etc.',
  `translation` TEXT DEFAULT NULL COMMENT 'Serialised JSON containing an object with optional translations for other properties of this object. The keys are the language codes and the values are dicts (original label/translated value).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The category of data';

--
-- Table structure for table `data_provider` generated from model 'DataProvider'
-- A data provider configured in the flowkit-ui-backend
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`data_provider` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `dpid` INT DEFAULT NULL COMMENT 'The ID for this data provider',
  `name` TEXT NOT NULL COMMENT 'The name of the data provider',
  `logo` TEXT DEFAULT NULL COMMENT 'The URL for a logo for this data provider',
  `url` TEXT DEFAULT NULL COMMENT 'The URL of the data provider&#39;s website',
  `translation` TEXT DEFAULT NULL COMMENT 'Serialised JSON containing an object with optional translations for other properties of this object. The keys are the language codes and the values are dicts (original label/translated value).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A data provider configured in the flowkit-ui-backend';

--
-- Table structure for table `flow_data` generated from model 'FlowData'
-- Data representing a flow between two spatial entities for one metadata instance
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`flow_data` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `mdid` INT NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` TEXT NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` TEXT NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` DECIMAL(20, 9) DEFAULT NULL COMMENT 'The data'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';

--
-- Table structure for table `indicator` generated from model 'Indicator'
-- The type of data
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`indicator` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `indicator_id` VARCHAR(255) NOT NULL COMMENT 'The name of the indicator',
  `category_id` VARCHAR(255) NOT NULL COMMENT 'The category ID this indicator belongs to',
  `order` INT DEFAULT NULL COMMENT 'The order of indicators per category in the UI with the first one being the default indicator for each category',
  `flowgeek_url` TEXT DEFAULT NULL COMMENT 'A link to a Flowgeek page with further information about this indicator',
  `label` TEXT DEFAULT NULL COMMENT 'A human-readable label for this indicator',
  `description` TEXT DEFAULT NULL COMMENT 'A description of this indicator, what it represents, how it is calculated etc.',
  `method` TEXT DEFAULT NULL COMMENT 'A longer explanation of the method used to calculate the indicator',
  `scale` ENUM('sequential', 'diverging') DEFAULT NULL COMMENT 'The type of scale applicable to this indicator',
  `decimals` INT DEFAULT NULL COMMENT 'The number of decimals to use when rendering the value. 0 decimals mean it will be shown as an integer.',
  `min_value` DECIMAL(20, 9) DEFAULT NULL COMMENT 'The smallest value this indicator can have.',
  `max_value` DECIMAL(20, 9) DEFAULT NULL COMMENT 'The largest value this indicator can have.',
  `num_bins` DECIMAL(20, 9) DEFAULT NULL COMMENT 'The number of bins to render this indicator. If &#x60;bins&#x60; is specified, this will be ignored.',
  `bins` JSON DEFAULT NULL COMMENT 'An list of all bins',
  `translation` TEXT DEFAULT NULL COMMENT 'Serialised JSON containing an object with optional translations for other properties of this object. The keys are the language codes and the values are dicts (original label/translated value).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The type of data';

--
-- Table structure for table `language` generated from model 'Language'
-- A language that is part of the metadata
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`language` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `lid` INT DEFAULT NULL COMMENT 'The ID for this language',
  `code` CHAR(2) DEFAULT NULL COMMENT 'The ISO 639-1 alpha-2 code for this language',
  `name` TEXT NOT NULL COMMENT 'The name of the data provider',
  `flag` TEXT DEFAULT NULL COMMENT 'An emoji representing the flag for this langauage',
  `default` TINYINT(1) DEFAULT false COMMENT 'Whether this is the default langauage'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A language that is part of the metadata';

--
-- Table structure for table `metadata` generated from model 'Metadata'
-- Metadata relating to the actual data
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`metadata` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `mdid` INT DEFAULT NULL COMMENT 'The metadata ID',
  `date_added` VARCHAR(19) DEFAULT NULL COMMENT 'A date plus optionally time formatted as one of the following: YYYY, YYYY-mm, YYYYwWW, YYYY-mm-dd, YYYY-mm-ddTHH:MM or YYYY-mm-ddTHH:MM:SS',
  `revision` TEXT NOT NULL COMMENT 'A version number',
  `category_id` VARCHAR(255) NOT NULL COMMENT 'The identifier for the category that this metadata relates to',
  `indicator_id` VARCHAR(255) NOT NULL COMMENT 'The identifier for the indicator that this metadata relates to',
  `srid` INT NOT NULL COMMENT 'The identifier for the spatial resolution that this aggregate relates to',
  `trid` INT NOT NULL COMMENT 'The identifier for the temporal resolution that this aggregate relates to',
  `dt` DATETIME DEFAULT NULL COMMENT 'An actual timestamp',
  `min_value` INT DEFAULT NULL COMMENT 'The minimum value across all data associated with this metadata.',
  `max_value` INT DEFAULT NULL COMMENT 'The maximum value across all data associated with this metadata.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Metadata relating to the actual data';

--
-- Table structure for table `scope_mapping` generated from model 'ScopeMapping'
-- A mapping between scopes and metadata IDs to signify what a scope gives access to
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`scope_mapping` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `scope` VARCHAR(128) NOT NULL COMMENT 'The scope ID as defined in the Auth0 security schema',
  `mdid` INT NOT NULL COMMENT 'The metadata ID that the scope gives access to'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A mapping between scopes and metadata IDs to signify what a scope gives access to';

--
-- Table structure for table `single_location_data` generated from model 'SingleLocationData'
-- Data referring to exactly one spatial unit for one metadata instance
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`single_location_data` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `mdid` INT DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` TEXT NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` DECIMAL(20, 9) DEFAULT NULL COMMENT 'The data'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';

--
-- Table structure for table `spatial_resolution` generated from model 'SpatialResolution'
-- A spatial resolution available in flowkit-ui-backend
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`spatial_resolution` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `srid` INT DEFAULT NULL COMMENT 'A unique identifier',
  `label` TEXT NOT NULL COMMENT 'A human-readable name',
  `index` INT NOT NULL COMMENT 'A numeric index placing this resolution in relation to other available resolutions',
  `description` TEXT DEFAULT NULL COMMENT 'An explanation for this resolution',
  `boundaries` JSON DEFAULT NULL COMMENT 'A TopoJSON geometry',
  `translation` TEXT DEFAULT NULL COMMENT 'Serialised JSON containing an object with optional translations for other properties of this object. The keys are the language codes and the values are dicts (original label/translated value).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A spatial resolution available in flowkit-ui-backend';

--
-- Table structure for table `temporal_resolution` generated from model 'TemporalResolution'
-- A temporal resolution available in flowkit-ui-backend
--

CREATE TABLE IF NOT EXISTS `flowkit_ui_backend`.`temporal_resolution` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `trid` INT DEFAULT NULL COMMENT 'A unique identifier',
  `label` TEXT NOT NULL COMMENT 'A human-readable name',
  `index` INT UNSIGNED NOT NULL COMMENT 'A numeric index placing this resolution in relation to other available resolutions',
  `relativedelta_unit` ENUM('years', 'months', 'weeks', 'days', 'hours') NOT NULL COMMENT 'The unit for the timedelta that this stemporal resolution represents',
  `relativedelta_num` INT UNSIGNED NOT NULL COMMENT 'The number of timedelta units contained in one temporal unit at this resolution',
  `date_format` TEXT DEFAULT NULL COMMENT 'The Python format to be used for temporal units at this resolution',
  `default_selected` INT UNSIGNED NOT NULL COMMENT 'The number of time units to select by default for this temporal resolution',
  `description` TEXT DEFAULT NULL COMMENT 'An explanation for this resolution',
  `translation` TEXT DEFAULT NULL COMMENT 'Serialised JSON containing an object with optional translations for other properties of this object. The keys are the language codes and the values are dicts (original label/translated value).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A temporal resolution available in flowkit-ui-backend';


