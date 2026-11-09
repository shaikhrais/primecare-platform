"""One-shot Login diagnostic wrapper. No workflow binds credentials to this file.

Only fixed status output; never serialize candidate receipt or connection data.
Requires separately approved protected execution and tenant/privilege verification.
"""
import json
import os
import signal
import sys

import login_production_candidate as candidate
import narrow_authority_reader as connection_policy

CODES = frozenset({
    'ARGUMENTS_REFUSED', 'CONFIGURATION_UNAVAILABLE', 'MISSING_DATABASE_URL',
    'CONFLICTING_DATABASE_URLS', 'INVALID_DATABASE_URL', 'UNEXPECTED_DATABASE_TARGET',
    'CONNECTION_OPTIONS_REFUSED', 'ENVIRONMENT_OPTIONS_REFUSED', 'HOME_CREDENTIALS_REFUSED',
    'CA_UNAVAILABLE', 'PIN_MISMATCH', 'DEPENDENCY_UNAVAILABLE', 'CONNECTION_UNVERIFIED',
    'CONNECTION_DENIED', 'TLS_REQUIRED', 'READONLY_UNVERIFIED', 'MANIFEST_UNVERIFIED',
    'INVALID_METADATA', 'ROW_LIMIT', 'BYTE_LIMIT', 'QUERY_LIMIT', 'TIME_LIMIT',
    'READ_DENIED', 'RELATION_UNAVAILABLE', 'COLUMN_UNAVAILABLE', 'QUERY_UNAVAILABLE',
    'ROLLBACK_UNVERIFIED', 'CLOSE_UNVERIFIED', 'TOTAL_TIMEOUT',
})


def receipt(code):
    return {'status': code if code in CODES or code == 'READ_COMPLETED' else 'QUERY_UNAVAILABLE',
            'productionAuthorityEstablished': False, 'contractComplete': False,
            'releaseReady': False, 'privateDataExported': False}


def _once(env, connector):
    """Private injection seam for offline tests, not a configurable CLI."""
    db = None
    code = 'QUERY_UNAVAILABLE'
    try:
        config = connection_policy.production_config(env)
        connection_policy.validate_local_configuration(env)
        config['application_name'] = 'primecare-login-read-once'
        try:
            db = connector(**config)
        except Exception as error:
            code = 'CONNECTION_DENIED' if getattr(error, 'sqlstate', None) in ('28P01', '28000') else 'CONNECTION_UNVERIFIED'
            return receipt(code)
        # Discard metadata receipt. Public output is deliberately not expandable.
        candidate.read_candidate(db)
        code = 'READ_COMPLETED'
    except (candidate.Fault, connection_policy.Fault) as error:
        code = error.code if error.code in CODES else 'QUERY_UNAVAILABLE'
    except Exception:
        code = 'QUERY_UNAVAILABLE'
    finally:
        if db is not None:
            try:
                db.close()
            except Exception:
                code = 'CLOSE_UNVERIFIED'
    return receipt(code)


def main():
    if len(sys.argv) != 1:
        print(json.dumps(receipt('ARGUMENTS_REFUSED'), sort_keys=True))
        return 1
    if not hasattr(signal, 'SIGALRM'):
        print(json.dumps(receipt('CONFIGURATION_UNAVAILABLE'), sort_keys=True))
        return 1
    expired = False
    def timeout(_signum, _frame):
        nonlocal expired
        if expired:
            os.write(1, (json.dumps(receipt('TOTAL_TIMEOUT')) + '\n').encode())
            os._exit(1)
        expired = True
        signal.alarm(5)
        raise candidate.Fault('TIME_LIMIT')
    signal.signal(signal.SIGALRM, timeout)
    signal.alarm(55)
    try:
        try:
            import psycopg
        except Exception:
            result = receipt('DEPENDENCY_UNAVAILABLE')
        else:
            result = _once(os.environ, psycopg.connect)
        if expired:
            result = receipt('TOTAL_TIMEOUT')
    finally:
        signal.alarm(0)
    print(json.dumps(result, sort_keys=True, separators=(',', ':')))
    return 0 if result['status'] == 'READ_COMPLETED' else 1


if __name__ == '__main__':
    raise SystemExit(main())
