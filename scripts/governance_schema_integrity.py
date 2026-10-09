"""Preserve generated placeholder evidence while removing it from active contracts."""
import json
import hashlib

PLACEHOLDER = {'type': 'object', 'properties': {'id': {'type': 'integer'}}}
SCHEMA_TABLES = (('api_request_schemas', 'Req_', 'request_schema', 'request_schema_id'),
                 ('api_response_schemas', 'Res_', 'response_schema', 'response_schema_id'))


def parsed_contract(value):
    if not value:
        return None
    try:
        schema = json.loads(value)
    except (ValueError, TypeError):
        raise ValueError('Canonical schema is invalid JSON')
    if not isinstance(schema, dict):
        raise ValueError('Canonical schema must be an object')
    if schema == PLACEHOLDER:
        raise ValueError('Generated generic id schema is not an approved endpoint contract')
    return schema


def canonical_schema_rows(cursor, api_id, endpoint_code):
    """Only the already identity-validated API's explicit inline contracts qualify."""
    row = cursor.execute('SELECT request_schema,response_schema FROM api_endpoints WHERE id=?', (api_id,)).fetchone()
    if row is None:
        raise ValueError('Canonical API identity does not exist')
    result = []
    for index, prefix in enumerate(('Req_', 'Res_')):
        schema = parsed_contract(row[index])
        result.append((api_id, 1, prefix + endpoint_code, json.dumps(schema, sort_keys=True)) if schema is not None else None)
    return result


def validate_quarantine_surface(conn):
    """Reject mutation surfaces that could silently destroy unrelated evidence."""
    mutable = {'api_endpoints', 'api_request_schemas', 'api_response_schemas', 'governance_schema_quarantine'}
    for name, table in conn.execute("SELECT name,tbl_name FROM sqlite_master WHERE type='trigger'"):
        if table in mutable:
            raise ValueError('Unreviewed trigger on schema quarantine mutation surface: ' + name)
    for table, prefix, inline, pointer in SCHEMA_TABLES:
        info = conn.execute('PRAGMA table_info(' + table + ')').fetchall()
        names = {r[1] for r in info}
        if not {'id','api_id','schema_name','schema_json'} <= names or not names <= {'id','api_id','runtime_artifact_id','schema_name','schema_json','created_at'}:
            raise ValueError('Unreviewed schema table layout: ' + table)
        expected_types = {'id':'INTEGER','api_id':'INTEGER','runtime_artifact_id':'INTEGER','schema_name':'TEXT','schema_json':'TEXT','created_at':'TEXT'}
        if any(r[2].upper() != expected_types[r[1]] for r in info):
            raise ValueError('Unreviewed schema column types: ' + table)
        if [r[1] for r in info if r[5]] != ['id']:
            raise ValueError('Unreviewed schema identity: ' + table)
    archive_info = conn.execute('PRAGMA table_info(governance_schema_quarantine)').fetchall()
    if {r[1] for r in archive_info} != {'source_table','source_id','original_row_json','original_sha256','registry_row_json','linked_endpoint_json','cleared_references_json','reason','quarantined_at'} or [r[1] for r in archive_info if r[5]] != ['source_table','source_id']:
        raise ValueError('Unreviewed quarantine archive schema')
    if any(r[2].upper() != ('INTEGER' if r[1]=='source_id' else 'TEXT') for r in archive_info):
        raise ValueError('Unreviewed quarantine archive column types')
    for table in mutable:
        if not conn.execute("SELECT 1 FROM sqlite_master WHERE type='table' AND name=?", (table,)).fetchone():
            raise ValueError('Unreviewed quarantine table surface: ' + table)
    if conn.execute('PRAGMA foreign_key_list(governance_schema_quarantine)').fetchall():
        raise ValueError('Unreviewed archive foreign key')
    for (name,) in conn.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall():
        escaped = name.replace('"','""')
        for fk in conn.execute('PRAGMA foreign_key_list("' + escaped + '")'):
            if fk[2] in {'api_request_schemas','api_response_schemas','governance_schema_quarantine'}:
                expected = 'request_schema_id' if fk[2]=='api_request_schemas' else 'response_schema_id'
                if name != 'api_endpoints' or fk[3] != expected or fk[4] != 'id' or fk[6] not in {'SET NULL','NO ACTION','RESTRICT'}:
                    raise ValueError('Unreviewed incoming schema reference: ' + name)


def quarantine_generated_schemas(conn):
    """Atomic and idempotent; no writes to permissions, inline contracts or evidence."""
    conn.execute('SAVEPOINT schema_integrity_quarantine')
    try:
        conn.execute('''CREATE TABLE IF NOT EXISTS governance_schema_quarantine (
            source_table TEXT NOT NULL, source_id INTEGER NOT NULL,
            original_row_json TEXT NOT NULL, original_sha256 TEXT NOT NULL, registry_row_json TEXT NOT NULL, linked_endpoint_json TEXT, cleared_references_json TEXT NOT NULL,
            reason TEXT NOT NULL, quarantined_at TEXT DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY(source_table,source_id))''')
        validate_quarantine_surface(conn)
        counts = {}
        for table, prefix, inline, pointer in SCHEMA_TABLES:
            cursor = conn.execute(f'SELECT * FROM {table}')
            columns = [description[0] for description in cursor.description]
            candidates = [dict(zip(columns, row)) for row in cursor.fetchall()]
            count = 0
            for row in candidates:
                try:
                    is_placeholder = json.loads(row['schema_json'] or 'null') == PLACEHOLDER
                except (ValueError, TypeError):
                    continue
                if not is_placeholder or not conn.execute('SELECT 1 FROM api_endpoint_registry WHERE id=? AND ? = ? || endpoint_code LIMIT 1', (row['api_id'], row['schema_name'], prefix)).fetchone():
                    continue
                registry_cursor = conn.execute('SELECT * FROM api_endpoint_registry WHERE id=?', (row['api_id'],))
                registry = dict(zip([d[0] for d in registry_cursor.description], registry_cursor.fetchone()))
                endpoint_cursor = conn.execute('SELECT * FROM api_endpoints WHERE id=?', (row['api_id'],))
                endpoint = endpoint_cursor.fetchone()
                snapshot = dict(zip([d[0] for d in endpoint_cursor.description], endpoint)) if endpoint else None
                references = [dict(zip(['id','request_schema_id','response_schema_id'], r)) for r in conn.execute(f'SELECT id,request_schema_id,response_schema_id FROM api_endpoints WHERE {pointer}=? ORDER BY id', (row['id'],))]
                original = json.dumps(row, sort_keys=True)
                expected = (original, hashlib.sha256(original.encode()).hexdigest(), json.dumps(registry, sort_keys=True), json.dumps(snapshot, sort_keys=True), json.dumps(references, sort_keys=True), 'generated_generic_id_placeholder_not_verified_contract')
                saved = conn.execute('SELECT original_row_json,original_sha256,registry_row_json,linked_endpoint_json,cleared_references_json,reason FROM governance_schema_quarantine WHERE source_table=? AND source_id=?', (table, row['id'])).fetchone()
                if saved and tuple(saved) != expected:
                    raise ValueError('Quarantine source identity collision or corrupted provenance/digest; refusing to overwrite preserved evidence')
                conn.execute('INSERT OR IGNORE INTO governance_schema_quarantine(source_table,source_id,original_row_json,original_sha256,registry_row_json,linked_endpoint_json,cleared_references_json,reason) VALUES(?,?,?,?,?,?,?,?)',
                             (table, row['id'], *expected))
                verified = conn.execute('SELECT original_row_json,original_sha256,registry_row_json,linked_endpoint_json,cleared_references_json,reason FROM governance_schema_quarantine WHERE source_table=? AND source_id=?', (table, row['id'])).fetchone()
                if not verified or tuple(verified) != expected:
                    raise ValueError('Archive verification failed before schema deletion')
                conn.execute(f'UPDATE api_endpoints SET {pointer}=NULL WHERE {pointer}=?', (row['id'],))
                conn.execute(f'DELETE FROM {table} WHERE id=?', (row['id'],))
                count += 1
            counts[table] = count
        conn.execute('RELEASE schema_integrity_quarantine')
        return counts
    except Exception:
        conn.execute('ROLLBACK TO schema_integrity_quarantine')
        conn.execute('RELEASE schema_integrity_quarantine')
        raise
