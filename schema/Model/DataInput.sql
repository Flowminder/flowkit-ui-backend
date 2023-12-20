-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'data_input' definition.
--


--
-- SELECT template for table `data_input`
--
SELECT * FROM `flowkit_ui_backend`.`data_input` WHERE 1;

--
-- INSERT template for table `data_input`
--
INSERT INTO `flowkit_ui_backend`.`data_input`(`spatial_unit_ids`, `data`) VALUES (%s, %s);

--
-- UPDATE template for table `data_input`
--
UPDATE `flowkit_ui_backend`.`data_input` SET `spatial_unit_ids` = %s, `data` = %s WHERE 1;

--
-- DELETE template for table `data_input`
--
DELETE FROM `flowkit_ui_backend`.`data_input` WHERE 1;

