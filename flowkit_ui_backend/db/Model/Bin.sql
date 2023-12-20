-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'bin' definition.
--


--
-- SELECT template for table `bin`
--
SELECT * FROM `flowkit_ui_backend`.`bin` WHERE 1;

--
-- INSERT template for table `bin`
--
INSERT INTO `flowkit_ui_backend`.`bin`(`min`, `max`, `width`) VALUES (%s, %s, %s);

--
-- UPDATE template for table `bin`
--
UPDATE `flowkit_ui_backend`.`bin` SET `min` = %s, `max` = %s, `width` = %s WHERE 1;

--
-- DELETE template for table `bin`
--
DELETE FROM `flowkit_ui_backend`.`bin` WHERE 1;

