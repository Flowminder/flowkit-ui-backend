-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'query_parameters' definition.
--


--
-- SELECT template for table `query_parameters`
--
SELECT * FROM `flowkit_ui_backend`.`query_parameters` WHERE 1;

--
-- INSERT template for table `query_parameters`
--
INSERT INTO `flowkit_ui_backend`.`query_parameters`(`category_id`, `indicator_id`, `srid`, `trid`, `start_date`, `duration`, `mdids_only`) VALUES (%s, %s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `query_parameters`
--
UPDATE `flowkit_ui_backend`.`query_parameters` SET `category_id` = %s, `indicator_id` = %s, `srid` = %s, `trid` = %s, `start_date` = %s, `duration` = %s, `mdids_only` = %s WHERE 1;

--
-- DELETE template for table `query_parameters`
--
DELETE FROM `flowkit_ui_backend`.`query_parameters` WHERE 1;

