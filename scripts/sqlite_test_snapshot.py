"""Read-only logical snapshots for isolated SQLite regression tests."""

def logical_snapshot(db):
    """Compare all schema and row multisets without validating historical FKs.

    Recent Python versions' iterdump checks foreign keys, which can reject
    unrelated historical fixture schemas before the authority guard is exercised.
    Include allocation counters: an aborted registrar must change nothing.
    """
    schema = db.execute(
        'SELECT type,name,tbl_name,sql FROM sqlite_schema ORDER BY type,name'
    ).fetchall()
    rows = []
    for kind, name, _, _ in schema:
        if kind != 'table':
            continue
        quoted_name = '"' + name.replace('"', '""') + '"'
        rows.append((name, sorted(repr(row) for row in db.execute('SELECT * FROM ' + quoted_name))))
    return schema, rows

