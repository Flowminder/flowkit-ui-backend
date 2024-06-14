-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'data_providers' definition.
--


--
-- SELECT template for table `data_providers`
--
SELECT * FROM `flowkit_ui_backend`.`data_providers` WHERE 1;

--
-- INSERT template for table `data_providers`
--
INSERT INTO `flowkit_ui_backend`.`data_providers`(`data_providers`) VALUES (%s);

--
-- UPDATE template for table `data_providers`
--
UPDATE `flowkit_ui_backend`.`data_providers` SET `data_providers` = %s WHERE 1;

--
-- DELETE template for table `data_providers`
--
DELETE FROM `flowkit_ui_backend`.`data_providers` WHERE 1;

