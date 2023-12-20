-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'spatial_resolutions' definition.
--


--
-- SELECT template for table `spatial_resolutions`
--
SELECT * FROM `flowkit_ui_backend`.`spatial_resolutions` WHERE 1;

--
-- INSERT template for table `spatial_resolutions`
--
INSERT INTO `flowkit_ui_backend`.`spatial_resolutions`(`spatial_resolutions`) VALUES (%s);

--
-- UPDATE template for table `spatial_resolutions`
--
UPDATE `flowkit_ui_backend`.`spatial_resolutions` SET `spatial_resolutions` = %s WHERE 1;

--
-- DELETE template for table `spatial_resolutions`
--
DELETE FROM `flowkit_ui_backend`.`spatial_resolutions` WHERE 1;

