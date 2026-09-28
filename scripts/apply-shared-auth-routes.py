#!/usr/bin/env python3
"""Register the user-approved shared auth entry routes; no access grants."""
import sqlite3
from pathlib import Path

root = Path(__file__).resolve().parents[1]
connection = sqlite3.connect(root / '.agents/governance/governance.db')
with connection:
    for code, path, flow in [
        ('login', '/login', 'shared_credentials'),
        ('signup', '/signup', 'administrator_provisioning_only'),
        ('forgot_password', '/forgot-password', 'recovery_delivery_pending'),
        ('reset_password', '/reset-password', 'recovery_contract_pending'),
        ('mfa', '/mfa', 'challenge_contract_pending'),
        ('consent', '/consent', 'authenticated_consent_contract_pending'),
        ('success', '/success', 'authenticated_session_summary'),
        ('language', '/language', 'shared_locale'),
        ('sso_redirect', '/sso-redirect', 'legacy_local_login'),
    ]:
        connection.execute('''INSERT INTO auth_route_registry
            (route_code, route_path, flow_type) VALUES (?, ?, ?)
            ON CONFLICT(route_code) DO UPDATE SET
            route_path=excluded.route_path, flow_type=excluded.flow_type''',
            (code, path, flow))
connection.close()
