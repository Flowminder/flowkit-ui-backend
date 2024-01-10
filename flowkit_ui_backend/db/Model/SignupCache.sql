-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'signup_cache' definition.
--


--
-- SELECT template for table `signup_cache`
--
SELECT * FROM `flowkit_ui_backend`.`signup_cache` WHERE 1;

--
-- INSERT template for table `signup_cache`
--
INSERT INTO `flowkit_ui_backend`.`signup_cache`(`first_name`, `last_name`, `email`, `org`, `industry`, `purpose`, `terms`, `no_harm`, `privacy`, `marketing`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `signup_cache`
--
UPDATE `flowkit_ui_backend`.`signup_cache` SET `first_name` = %s, `last_name` = %s, `email` = %s, `org` = %s, `industry` = %s, `purpose` = %s, `terms` = %s, `no_harm` = %s, `privacy` = %s, `marketing` = %s WHERE 1;

--
-- DELETE template for table `signup_cache`
--
DELETE FROM `flowkit_ui_backend`.`signup_cache` WHERE 1;

