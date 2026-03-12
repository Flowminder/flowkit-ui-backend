#!/usr/bin/env python3
"""
Generate SQL UPDATE statements to sync indicator translations from config.json
into the flowkit_ui_backend MySQL database.

Usage:
    python3 resources/generate_translation_sql.py > /tmp/update_translations.sql
    tailscale ssh root@mobdash-sql-prod "mysql -u root -A flowkit_ui_backend" < /tmp/update_translations.sql

Or pipe directly:
    python3 resources/generate_translation_sql.py | tailscale ssh root@mobdash-sql-prod "mysql -u root -A flowkit_ui_backend"
"""

import json
import os
import sys

config_path = os.path.join(os.path.dirname(__file__), "config.json")

with open(config_path) as f:
    config = json.load(f)

langs = {l["code"] for l in config["languages"] if not l.get("default")}

print("-- Generated from config.json - updates indicator translations in flowkit_ui_backend")
print("-- Languages:", sorted(langs))
print()

for ind in config["indicators"]:
    iid = ind["indicator_id"]
    translation = {}
    for key, val in ind.items():
        parts = key.rsplit("_", 1)
        if len(parts) == 2 and parts[1] in langs:
            translation.setdefault(parts[1], {})[parts[0]] = val
    if translation:
        escaped = json.dumps(translation, ensure_ascii=False).replace("'", "\\'")
        print(f"UPDATE indicator SET translation = '{escaped}' WHERE indicator_id = '{iid}';")
