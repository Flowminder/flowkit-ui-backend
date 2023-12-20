-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'temporal_resolutions' definition.
--


--
-- SELECT template for table `temporal_resolutions`
--
SELECT * FROM `flowkit_ui_backend`.`temporal_resolutions` WHERE 1;

--
-- INSERT template for table `temporal_resolutions`
--
INSERT INTO `flowkit_ui_backend`.`temporal_resolutions`(`temporal_resolutions`) VALUES (%s);

--
-- UPDATE template for table `temporal_resolutions`
--
UPDATE `flowkit_ui_backend`.`temporal_resolutions` SET `temporal_resolutions` = %s WHERE 1;

--
-- DELETE template for table `temporal_resolutions`
--
DELETE FROM `flowkit_ui_backend`.`temporal_resolutions` WHERE 1;

