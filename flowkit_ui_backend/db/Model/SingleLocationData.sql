-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'single_location_data' definition.
--


--
-- SELECT template for table `single_location_data`
--
SELECT * FROM `flowkit_ui_backend`.`single_location_data` WHERE 1;

--
-- INSERT template for table `single_location_data`
--
INSERT INTO `flowkit_ui_backend`.`single_location_data`(`mdid`, `spatial_unit_id`, `data`) VALUES (%s, %s, %s);

--
-- UPDATE template for table `single_location_data`
--
UPDATE `flowkit_ui_backend`.`single_location_data` SET `mdid` = %s, `spatial_unit_id` = %s, `data` = %s WHERE 1;

--
-- DELETE template for table `single_location_data`
--
DELETE FROM `flowkit_ui_backend`.`single_location_data` WHERE 1;

