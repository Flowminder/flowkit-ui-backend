-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'query_result' definition.
--


--
-- SELECT template for table `query_result`
--
SELECT * FROM `flowkit_ui_backend`.`query_result` WHERE 1;

--
-- INSERT template for table `query_result`
--
INSERT INTO `flowkit_ui_backend`.`query_result`(`min`, `max`, `data_by_date`, `mdids`) VALUES (%s, %s, %s, %s);

--
-- UPDATE template for table `query_result`
--
UPDATE `flowkit_ui_backend`.`query_result` SET `min` = %s, `max` = %s, `data_by_date` = %s, `mdids` = %s WHERE 1;

--
-- DELETE template for table `query_result`
--
DELETE FROM `flowkit_ui_backend`.`query_result` WHERE 1;

