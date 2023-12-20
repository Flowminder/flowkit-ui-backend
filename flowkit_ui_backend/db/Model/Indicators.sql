-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'indicators' definition.
--


--
-- SELECT template for table `indicators`
--
SELECT * FROM `flowkit_ui_backend`.`indicators` WHERE 1;

--
-- INSERT template for table `indicators`
--
INSERT INTO `flowkit_ui_backend`.`indicators`(`indicators`) VALUES (%s);

--
-- UPDATE template for table `indicators`
--
UPDATE `flowkit_ui_backend`.`indicators` SET `indicators` = %s WHERE 1;

--
-- DELETE template for table `indicators`
--
DELETE FROM `flowkit_ui_backend`.`indicators` WHERE 1;

