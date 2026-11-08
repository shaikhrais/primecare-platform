"""Read-only CSS export for isolated historical browser test fixtures."""
import json
import sqlite3
from contextlib import closing
from pathlib import Path
from theme_manifest import css_theme


def read_theme(db):
    db.row_factory = sqlite3.Row
    return css_theme(db.execute(
        'SELECT theme_id,active,css_variable_name,token_value FROM theme_design_tokens'
    ))


def load_fixture_theme(path):
    # Missing fixtures fail; never create or modify a database during browser setup.
    with closing(sqlite3.connect(Path(path).resolve().as_uri() + '?mode=ro', uri=True)) as db:
        db.execute('PRAGMA query_only=ON')
        return read_theme(db)


if __name__ == '__main__':
    print(json.dumps(load_fixture_theme('.agents/governance/governance.db')))
