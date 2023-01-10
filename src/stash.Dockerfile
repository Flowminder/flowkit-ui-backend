# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

FROM mysql:5.7

# Use config file to allow larger queries
COPY ./src/impl/mysql.cnf /etc/mysql/conf.d/mysql.cnf
