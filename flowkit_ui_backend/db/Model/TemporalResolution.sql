-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'temporal_resolution' definition.
--


--
-- SELECT template for table `temporal_resolution`
--
SELECT * FROM `flowkit_ui_backend`.`temporal_resolution` WHERE 1;

--
-- INSERT template for table `temporal_resolution`
--
INSERT INTO `flowkit_ui_backend`.`temporal_resolution`(`trid`, `label`, `index`, `relativedelta_unit`, `relativedelta_num`, `date_format`, `default_selected`, `description`, `translation`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `temporal_resolution`
--
UPDATE `flowkit_ui_backend`.`temporal_resolution` SET `trid` = %s, `label` = %s, `index` = %s, `relativedelta_unit` = %s, `relativedelta_num` = %s, `date_format` = %s, `default_selected` = %s, `description` = %s, `translation` = %s WHERE 1;

--
-- DELETE template for table `temporal_resolution`
--
DELETE FROM `flowkit_ui_backend`.`temporal_resolution` WHERE 1;

