-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'config' definition.
--


--
-- SELECT template for table `config`
--
SELECT * FROM `flowkit_ui_backend`.`config` WHERE 1;

--
-- INSERT template for table `config`
--
INSERT INTO `flowkit_ui_backend`.`config`(`languages`, `data_providers`, `categories`, `indicators`, `temporal_resolutions`, `spatial_resolutions`) VALUES (%s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `config`
--
UPDATE `flowkit_ui_backend`.`config` SET `languages` = %s, `data_providers` = %s, `categories` = %s, `indicators` = %s, `temporal_resolutions` = %s, `spatial_resolutions` = %s WHERE 1;

--
-- DELETE template for table `config`
--
DELETE FROM `flowkit_ui_backend`.`config` WHERE 1;

