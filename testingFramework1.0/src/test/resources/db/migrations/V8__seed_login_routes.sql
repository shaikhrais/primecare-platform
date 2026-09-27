-- Schema Migration: V8__seed_login_routes
-- Created: 2026-07-16

CREATE TABLE IF NOT EXISTS sso_routes (
    route_id TEXT PRIMARY KEY,
    application_id TEXT NOT NULL,
    host TEXT NOT NULL,
    route TEXT NOT NULL,
    screen_identifier TEXT,
    route_type TEXT NOT NULL,
    authentication_role TEXT NOT NULL,
    public_route INTEGER NOT NULL,
    expected_next_route TEXT
);

INSERT OR REPLACE INTO sso_routes (route_id, application_id, host, route, screen_identifier, route_type, authentication_role, public_route, expected_next_route)
VALUES (
    'CLINIC_LOGIN', 
    'primecare-clinic', 
    'primecare-clinic.pages.dev', 
    '/login', 
    'clinic-login-screen', 
    'SSO_BRIDGE', 
    'ANY', 
    1, 
    'https://primecare-auth.pages.dev/login'
);

INSERT OR REPLACE INTO sso_routes (route_id, application_id, host, route, screen_identifier, route_type, authentication_role, public_route, expected_next_route)
VALUES (
    'CENTRAL_AUTH_LOGIN', 
    'primecare-auth', 
    'primecare-auth.pages.dev', 
    '/login', 
    'auth-login-screen', 
    'CREDENTIAL_ENTRY', 
    'ANY', 
    1, 
    'https://primecare-clinic.pages.dev/auth/callback'
);
