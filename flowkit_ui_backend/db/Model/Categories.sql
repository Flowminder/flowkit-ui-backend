-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'categories' definition.
--


--
-- SELECT template for table `categories`
--
SELECT * FROM `flowkit_ui_backend`.`categories` WHERE 1;

--
-- INSERT template for table `categories`
--
INSERT INTO `flowkit_ui_backend`.`categories`(`categories`) VALUES (%s);

--
-- UPDATE template for table `categories`
--
UPDATE `flowkit_ui_backend`.`categories` SET `categories` = %s WHERE 1;

--
-- DELETE template for table `categories`
--
DELETE FROM `flowkit_ui_backend`.`categories` WHERE 1;

