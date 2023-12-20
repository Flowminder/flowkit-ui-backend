-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'dataset' definition.
--


--
-- SELECT template for table `dataset`
--
SELECT * FROM `flowkit_ui_backend`.`dataset` WHERE 1;

--
-- INSERT template for table `dataset`
--
INSERT INTO `flowkit_ui_backend`.`dataset`(`metadata`, `data_type`, `data_input`) VALUES (%s, %s, %s);

--
-- UPDATE template for table `dataset`
--
UPDATE `flowkit_ui_backend`.`dataset` SET `metadata` = %s, `data_type` = %s, `data_input` = %s WHERE 1;

--
-- DELETE template for table `dataset`
--
DELETE FROM `flowkit_ui_backend`.`dataset` WHERE 1;

