-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

--
-- FlowKitUI Backend.
-- Database: `flowkit_ui_backend`
-- Prepared SQL queries for 'heartbeat' definition.
--


--
-- SELECT template for table `heartbeat`
--
SELECT * FROM `flowkit_ui_backend`.`heartbeat` WHERE 1;

--
-- INSERT template for table `heartbeat`
--
INSERT INTO `flowkit_ui_backend`.`heartbeat`(`datetime`, `docker_image`, `git_branch`, `git_commit`, `git_tag`, `python_package`, `python_version`) VALUES (%s, %s, %s, %s, %s, %s, %s);

--
-- UPDATE template for table `heartbeat`
--
UPDATE `flowkit_ui_backend`.`heartbeat` SET `datetime` = %s, `docker_image` = %s, `git_branch` = %s, `git_commit` = %s, `git_tag` = %s, `python_package` = %s, `python_version` = %s WHERE 1;

--
-- DELETE template for table `heartbeat`
--
DELETE FROM `flowkit_ui_backend`.`heartbeat` WHERE 1;

