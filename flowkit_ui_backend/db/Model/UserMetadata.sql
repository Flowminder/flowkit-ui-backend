-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'user_metadata' definition.
--


--
-- SELECT template for table `user_metadata`
--
SELECT * FROM `flowkit_ui_backend`.`user_metadata` WHERE 1;

--
-- INSERT template for table `user_metadata`
--
INSERT INTO `flowkit_ui_backend`.`user_metadata`(`preferred_language`, `show_tutorial`, `signup_cache`, `roles_expiry`, `account_expiry`) VALUES (%s, %s, %s, %s, %s);

--
-- UPDATE template for table `user_metadata`
--
UPDATE `flowkit_ui_backend`.`user_metadata` SET `preferred_language` = %s, `show_tutorial` = %s, `signup_cache` = %s, `roles_expiry` = %s, `account_expiry` = %s WHERE 1;

--
-- DELETE template for table `user_metadata`
--
DELETE FROM `flowkit_ui_backend`.`user_metadata` WHERE 1;

