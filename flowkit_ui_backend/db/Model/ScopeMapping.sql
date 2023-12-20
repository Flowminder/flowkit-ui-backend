-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'scope_mapping' definition.
--


--
-- SELECT template for table `scope_mapping`
--
SELECT * FROM `flowkit_ui_backend`.`scope_mapping` WHERE 1;

--
-- INSERT template for table `scope_mapping`
--
INSERT INTO `flowkit_ui_backend`.`scope_mapping`(`scope`, `mdid`) VALUES (%s, %s);

--
-- UPDATE template for table `scope_mapping`
--
UPDATE `flowkit_ui_backend`.`scope_mapping` SET `scope` = %s, `mdid` = %s WHERE 1;

--
-- DELETE template for table `scope_mapping`
--
DELETE FROM `flowkit_ui_backend`.`scope_mapping` WHERE 1;

