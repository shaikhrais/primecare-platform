#!/usr/bin/env python3
"""Quarantine proven architecture-generated generic schemas in a local DB copy."""
import argparse
import json
import sqlite3
from governance_schema_integrity import quarantine_generated_schemas

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('database', help='Explicit local governance SQLite path')
    args = parser.parse_args()
    conn = sqlite3.connect(args.database)
    conn.execute('PRAGMA foreign_keys=ON')
    try:
        counts = quarantine_generated_schemas(conn)
        conn.commit()
        print(json.dumps({'quarantinedSchemaRows': counts, 'newCompletedOperations': 0}, sort_keys=True))
    finally:
        conn.close()
