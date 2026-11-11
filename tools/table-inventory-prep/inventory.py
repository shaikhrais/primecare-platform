"""Unbound PostgreSQL inventory draft. No production entry point or secrets.
Caller must encrypt returned JSON before any storage/upload and suppress driver errors.
"""
import time

CATALOG_SQL = """
WITH RECURSIVE foreign_ancestors(oid) AS (
    SELECT i.inhparent FROM pg_catalog.pg_inherits i
    JOIN pg_catalog.pg_class f ON f.oid=i.inhrelid WHERE f.relkind='f'
    UNION
    SELECT i.inhparent FROM pg_catalog.pg_inherits i
    JOIN foreign_ancestors a ON a.oid=i.inhrelid
)
SELECT n.nspname, c.relname, c.relkind, c.reltuples,
       c.relrowsecurity, c.relforcerowsecurity, c.relispartition,
       EXISTS (SELECT 1 FROM pg_catalog.pg_inherits i WHERE i.inhparent=c.oid),
       pg_catalog.has_table_privilege(c.oid, 'SELECT'),
       EXISTS (SELECT 1 FROM foreign_ancestors a WHERE a.oid=c.oid)
FROM pg_catalog.pg_class c
JOIN pg_catalog.pg_namespace n ON n.oid=c.relnamespace
WHERE c.relkind IN ('r','p','m','f')
  AND n.nspname <> 'information_schema'
  AND n.nspname !~ '^pg_'
ORDER BY n.nspname, c.relname
LIMIT 10001
"""

def ident(value):
    return '"' + value.replace('"', '""') + '"'


def transaction(cur):
    cur.execute('BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY')
    cur.execute("SET LOCAL statement_timeout = '5s'")
    cur.execute("SET LOCAL lock_timeout = '1s'")
    cur.execute("SET LOCAL idle_in_transaction_session_timeout = '10s'")
    cur.execute('SET LOCAL search_path = pg_catalog')


def inventory(conn, budget_seconds=180, clock=time.monotonic):
    """Requires fresh psycopg connection, autocommit=True, TLS verified by caller.
    No queries return records. Counts are per-table snapshots, not one global snapshot.
    Foreign tables are reported but never queried. Estimates are raw planner estimates.
    Counts for inherited parents include descendants; consumers MUST NOT sum all rows.
    """
    if not conn.autocommit:
        raise ValueError('Fresh autocommit connection required')
    started = clock()
    with conn.cursor() as cur:
        try:
            transaction(cur)
            cur.execute(CATALOG_SQL)
            catalog = cur.fetchall()
        finally:
            cur.execute('ROLLBACK')
    if len(catalog) > 10000:
        raise ValueError('Inventory exceeds fixed relation limit')
    rows = []
    for schema, table, kind, estimate, rls, force_rls, partition, descendants, allowed, foreign_descendants in catalog:
        row = dict(schema=schema, table=table, relation_kind=kind,
                   estimated_rows=None if estimate < 0 else int(estimate),
                   estimate_source='pg_class.reltuples; may be stale; not an exact count',
                   row_security_enabled=rls, force_row_security=force_rls,
                   is_partition=partition, includes_descendants=descendants,
                   exact_count=None, count_status='not_attempted',
                   count_scope='rows visible to connected role at this table snapshot',
                   purpose='Not determined by database; map from reviewed application code')
        rows.append(row)
        if kind == 'f' or foreign_descendants:
            row['count_status'] = 'skipped_foreign_table_or_descendants'
            continue
        if not allowed:
            row['count_status'] = 'no_select_privilege'
            continue
        if clock() - started >= budget_seconds:
            row['count_status'] = 'overall_time_budget_reached'
            continue
        with conn.cursor() as cur:
            try:
                transaction(cur)
                cur.execute('SELECT count(*) FROM ' + ident(schema) + '.' + ident(table))
                row['exact_count'] = int(cur.fetchone()[0])
                row['count_status'] = 'exact_visible_rows' if rls else 'exact_table_rows'
            except Exception as error:
                # No error text, SQL, DSN, host, username or stack trace is retained.
                code = getattr(error, 'sqlstate', None) or getattr(error, 'pgcode', None)
                row['count_status'] = {'57014': 'statement_timeout', '55P03': 'lock_timeout',
                                       '42501': 'permission_denied', '42P01': 'relation_changed'}.get(code, 'query_failed')
            finally:
                cur.execute('ROLLBACK')
    return {'scope': 'non-system ordinary/partitioned tables, materialized views and foreign tables',
            'complete_catalog': True, 'snapshot': 'separate snapshot for each table',
            'warning': 'Parent and child counts overlap; do not sum. RLS counts may be partial.',
            'tables': rows}
