-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'flow_data' definition.
--


--
-- SELECT template for table `flow_data`
--
SELECT * FROM `flowkit_ui_backend`.`flow_data` WHERE 1;

--
-- INSERT template for table `flow_data`
--
INSERT INTO `flowkit_ui_backend`.`flow_data`(`mdid`, `origin`, `destination`, `data`) VALUES (%s, %s, %s, %s);

--
-- UPDATE template for table `flow_data`
--
UPDATE `flowkit_ui_backend`.`flow_data` SET `mdid` = %s, `origin` = %s, `destination` = %s, `data` = %s WHERE 1;

--
-- DELETE template for table `flow_data`
--
DELETE FROM `flowkit_ui_backend`.`flow_data` WHERE 1;

