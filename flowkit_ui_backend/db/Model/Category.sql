-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'category' definition.
--


--
-- SELECT template for table `category`
--
SELECT * FROM `flowkit_ui_backend`.`category` WHERE 1;

--
-- INSERT template for table `category`
--
INSERT INTO `flowkit_ui_backend`.`category`(`category_id`, `type`, `order`, `flowgeek_url`, `label`, `description`, `translation`) VALUES (%s, %s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `category`
--
UPDATE `flowkit_ui_backend`.`category` SET `category_id` = %s, `type` = %s, `order` = %s, `flowgeek_url` = %s, `label` = %s, `description` = %s, `translation` = %s WHERE 1;

--
-- DELETE template for table `category`
--
DELETE FROM `flowkit_ui_backend`.`category` WHERE 1;

