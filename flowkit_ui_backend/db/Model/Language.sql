-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'language' definition.
--


--
-- SELECT template for table `language`
--
SELECT * FROM `flowkit_ui_backend`.`language` WHERE 1;

--
-- INSERT template for table `language`
--
INSERT INTO `flowkit_ui_backend`.`language`(`lid`, `code`, `name`, `flag`, `default`) VALUES (%s, %s, %s, %s, %s);

--
-- UPDATE template for table `language`
--
UPDATE `flowkit_ui_backend`.`language` SET `lid` = %s, `code` = %s, `name` = %s, `flag` = %s, `default` = %s WHERE 1;

--
-- DELETE template for table `language`
--
DELETE FROM `flowkit_ui_backend`.`language` WHERE 1;

