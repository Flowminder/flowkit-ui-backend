-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'data_provider' definition.
--


--
-- SELECT template for table `data_provider`
--
SELECT * FROM `flowkit_ui_backend`.`data_provider` WHERE 1;

--
-- INSERT template for table `data_provider`
--
INSERT INTO `flowkit_ui_backend`.`data_provider`(`dpid`, `name`, `logo`, `url`, `translation`) VALUES (%s, %s, %s, %s, %s);

--
-- UPDATE template for table `data_provider`
--
UPDATE `flowkit_ui_backend`.`data_provider` SET `dpid` = %s, `name` = %s, `logo` = %s, `url` = %s, `translation` = %s WHERE 1;

--
-- DELETE template for table `data_provider`
--
DELETE FROM `flowkit_ui_backend`.`data_provider` WHERE 1;

