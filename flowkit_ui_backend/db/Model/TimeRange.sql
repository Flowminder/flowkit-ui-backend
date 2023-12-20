-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'time_range' definition.
--


--
-- SELECT template for table `time_range`
--
SELECT * FROM `flowkit_ui_backend`.`time_range` WHERE 1;

--
-- INSERT template for table `time_range`
--
INSERT INTO `flowkit_ui_backend`.`time_range`(`start_date`, `end_date`, `all_dates`, `min_value`, `max_value`) VALUES (%s, %s, %s, %s, %s);

--
-- UPDATE template for table `time_range`
--
UPDATE `flowkit_ui_backend`.`time_range` SET `start_date` = %s, `end_date` = %s, `all_dates` = %s, `min_value` = %s, `max_value` = %s WHERE 1;

--
-- DELETE template for table `time_range`
--
DELETE FROM `flowkit_ui_backend`.`time_range` WHERE 1;

