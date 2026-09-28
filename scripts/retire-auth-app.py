#!/usr/bin/env python3
"""Retire the standalone auth deployment without deleting shared auth screens."""
from pathlib import Path
import sqlite3
root = Path(__file__).resolve().parents[1]
with sqlite3.connect(root / '.agents/governance/governance.db') as db:
    db.execute("UPDATE apps SET active=0, description=? WHERE app_code='au'",
               ('Retired standalone application; auth pages and routes are shared by all product apps through primecare_ui and flutter_core.',))
    # Fix legacy template output at the source so future generations stay compatible.
    for table, in db.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall():
        for column in db.execute('PRAGMA table_info("' + table + '")').fetchall():
            if column[2].upper() not in ('TEXT', 'VARCHAR'): continue
            name = column[1]
            if not any(key in name.lower() for key in ('template','code','content')): continue
            query = 'SELECT rowid, "' + name + '" FROM "' + table + '" WHERE "' + name + '" LIKE ?'
            for rowid, value in db.execute(query, ('%StateNotifier%',)).fetchall():
                if not isinstance(value, str) or "import 'package:flutter_riverpod/flutter_riverpod.dart';" not in value: continue
                if "import 'package:flutter_riverpod/legacy.dart';" in value: continue
                value = value.replace("import 'package:flutter_riverpod/flutter_riverpod.dart';", "import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:flutter_riverpod/legacy.dart';")
                db.execute('UPDATE "' + table + '" SET "' + name + '"=? WHERE rowid=?', (value, rowid))
