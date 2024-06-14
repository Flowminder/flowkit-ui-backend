-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'metadata' definition.
--


--
-- SELECT template for table `metadata`
--
SELECT * FROM `flowkit_ui_backend`.`metadata` WHERE 1;

--
-- INSERT template for table `metadata`
--
INSERT INTO `flowkit_ui_backend`.`metadata`(`mdid`, `date_added`, `revision`, `category_id`, `indicator_id`, `srid`, `trid`, `dt`, `min_value`, `max_value`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `metadata`
--
UPDATE `flowkit_ui_backend`.`metadata` SET `mdid` = %s, `date_added` = %s, `revision` = %s, `category_id` = %s, `indicator_id` = %s, `srid` = %s, `trid` = %s, `dt` = %s, `min_value` = %s, `max_value` = %s WHERE 1;

--
-- DELETE template for table `metadata`
--
DELETE FROM `flowkit_ui_backend`.`metadata` WHERE 1;

