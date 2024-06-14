-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'indicator' definition.
--


--
-- SELECT template for table `indicator`
--
SELECT * FROM `flowkit_ui_backend`.`indicator` WHERE 1;

--
-- INSERT template for table `indicator`
--
INSERT INTO `flowkit_ui_backend`.`indicator`(`indicator_id`, `category_id`, `order`, `flowgeek_url`, `label`, `description`, `method`, `scale`, `decimals`, `min_value`, `max_value`, `num_bins`, `bins`, `translation`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `indicator`
--
UPDATE `flowkit_ui_backend`.`indicator` SET `indicator_id` = %s, `category_id` = %s, `order` = %s, `flowgeek_url` = %s, `label` = %s, `description` = %s, `method` = %s, `scale` = %s, `decimals` = %s, `min_value` = %s, `max_value` = %s, `num_bins` = %s, `bins` = %s, `translation` = %s WHERE 1;

--
-- DELETE template for table `indicator`
--
DELETE FROM `flowkit_ui_backend`.`indicator` WHERE 1;

