-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'spatial_resolution' definition.
--


--
-- SELECT template for table `spatial_resolution`
--
SELECT * FROM `flowkit_ui_backend`.`spatial_resolution` WHERE 1;

--
-- INSERT template for table `spatial_resolution`
--
INSERT INTO `flowkit_ui_backend`.`spatial_resolution`(`srid`, `label`, `index`, `description`, `boundaries`, `translation`) VALUES (%s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `spatial_resolution`
--
UPDATE `flowkit_ui_backend`.`spatial_resolution` SET `srid` = %s, `label` = %s, `index` = %s, `description` = %s, `boundaries` = %s, `translation` = %s WHERE 1;

--
-- DELETE template for table `spatial_resolution`
--
DELETE FROM `flowkit_ui_backend`.`spatial_resolution` WHERE 1;

