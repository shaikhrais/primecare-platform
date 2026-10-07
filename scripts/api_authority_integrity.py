"""Fail closed on legacy API metadata; identity checks never grant authority."""
import json


class ApiAuthorityIntegrityError(ValueError):
    pass


def assert_api_authority_integrity(conn):
    """Reject orphaned, fabricated, or conflicting endpoint-linked metadata.

    Compare schemas to reviewed api_endpoints contracts, not registry row IDs.
    Matching permission keys are only an integrity check, never a role grant.
    """
    findings = []
    tables = {r[0] for r in conn.execute("SELECT name FROM sqlite_master WHERE type='table'")}
    for table, contract in (("api_request_schemas", "request_schema"),
                            ("api_response_schemas", "response_schema")):
        if table not in tables:
            continue
        for row in conn.execute(f"SELECT s.id,s.api_id,s.schema_json,e.id,e.{contract} FROM {table} s LEFT JOIN api_endpoints e ON e.id=s.api_id"):
            row_id, api_id, value, endpoint_id, reviewed = row
            try:
                actual,canonical=json.loads(value),json.loads(reviewed)
                matches = endpoint_id is not None and isinstance(actual,dict) and isinstance(canonical,dict) and actual == canonical
            except (TypeError, ValueError):
                matches = False
            if not matches:
                findings.append(f"{table}#{row_id}: unreviewed or conflicting contract for api_id {api_id}")
    if "api_permissions" in tables:
        for row in conn.execute("SELECT p.id,p.api_id,p.permission_key,e.id,e.permission_key FROM api_permissions p LEFT JOIN api_endpoints e ON e.id=p.api_id"):
            row_id, api_id, key, endpoint_id, reviewed = row
            if endpoint_id is None or not reviewed or key != reviewed or key.startswith("api_permission_"):
                findings.append(f"api_permissions#{row_id}: unreviewed permission origin for api_id {api_id}")
    if findings:
        raise ApiAuthorityIntegrityError(f"API authority integrity rejected {len(findings)} rows; " + "; ".join(findings[:10]))
