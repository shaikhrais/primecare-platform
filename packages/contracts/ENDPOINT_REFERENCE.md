# PrimeCare endpoint reference â€” DRAFT

All operations below are registered, not verified implementations. Descriptions preserve missing requirements explicitly. No production requests are executed.

# 1: POST /v1/auth/register

## Registered operation
`POST /v1/auth/register`

Governance ID: 1. Registry code: `API__V1_AUTH_REGISTER`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 2: POST /v1/auth/login

## Registered operation
`POST /v1/auth/login`

Governance ID: 2. Registry code: `API__V1_AUTH_LOGIN`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 3: POST /v1/auth/switch-role

## Registered operation
`POST /v1/auth/switch-role`

Governance ID: 3. Registry code: `API__V1_AUTH_SWITCH-ROLE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 4: POST /v1/auth/refresh

## Registered operation
`POST /v1/auth/refresh`

Governance ID: 4. Registry code: `API__V1_AUTH_REFRESH`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 5: POST /v1/auth/logout

## Registered operation
`POST /v1/auth/logout`

Governance ID: 5. Registry code: `API__V1_AUTH_LOGOUT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 6: POST /v1/auth/whoami

## Registered operation
`POST /v1/auth/whoami`

Governance ID: 6. Registry code: `API__V1_AUTH_WHOAMI`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 7: POST /v1/auth/impersonate

## Registered operation
`POST /v1/auth/impersonate`

Governance ID: 7. Registry code: `API__V1_AUTH_IMPERSONATE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 8: POST /v1/auth/onboard-business

## Registered operation
`POST /v1/auth/onboard-business`

Governance ID: 8. Registry code: `API__V1_AUTH_ONBOARD-BUSINESS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 9: POST /v1/auth/osm

## Registered operation
`POST /v1/auth/osm`

Governance ID: 9. Registry code: `API__V1_AUTH_OSM`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 10: POST /v1/auth/osm/callback

## Registered operation
`POST /v1/auth/osm/callback`

Governance ID: 10. Registry code: `API__V1_AUTH_OSM_CALLBACK`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 11: POST /v1/admin/users

## Registered operation
`POST /v1/admin/users`

Governance ID: 11. Registry code: `API__V1_ADMIN_USERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 866: GET /v1/admin/users

## Registered operation
`GET /v1/admin/users`

Governance ID: 866. Registry code: `API__V1_ADMIN_USERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 12: POST /v1/admin/users/churn-heatmap

## Registered operation
`POST /v1/admin/users/churn-heatmap`

Governance ID: 12. Registry code: `API__V1_ADMIN_USERS_CHURN-HEATMAP`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 13: POST /v1/admin/settings/business-model

## Registered operation
`POST /v1/admin/settings/business-model`

Governance ID: 13. Registry code: `API__V1_ADMIN_SETTINGS_BUSINESS-MODEL`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 14: POST /v1/admin/settings/branding

## Registered operation
`POST /v1/admin/settings/branding`

Governance ID: 14. Registry code: `API__V1_ADMIN_SETTINGS_BRANDING`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 15: POST /v1/admin/settings/security

## Registered operation
`POST /v1/admin/settings/security`

Governance ID: 15. Registry code: `API__V1_ADMIN_SETTINGS_SECURITY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 16: POST /v1/admin/settings/security/devices

## Registered operation
`POST /v1/admin/settings/security/devices`

Governance ID: 16. Registry code: `API__V1_ADMIN_SETTINGS_SECURITY_DEVICES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 17: POST /v1/admin/settings/security/forensic-trails

## Registered operation
`POST /v1/admin/settings/security/forensic-trails`

Governance ID: 17. Registry code: `API__V1_ADMIN_SETTINGS_SECURITY_FORENSIC-TRAILS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 18: POST /v1/admin/settings/security/daily-summary

## Registered operation
`POST /v1/admin/settings/security/daily-summary`

Governance ID: 18. Registry code: `API__V1_ADMIN_SETTINGS_SECURITY_DAILY-SUMMARY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 19: POST /v1/admin/settings/security/cors

## Registered operation
`POST /v1/admin/settings/security/cors`

Governance ID: 19. Registry code: `API__V1_ADMIN_SETTINGS_SECURITY_CORS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 20: POST /v1/admin/settings/security/verify-integrity

## Registered operation
`POST /v1/admin/settings/security/verify-integrity`

Governance ID: 20. Registry code: `API__V1_ADMIN_SETTINGS_SECURITY_VERIFY-INTEGRITY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 21: POST /v1/admin/settings/usage-stats

## Registered operation
`POST /v1/admin/settings/usage-stats`

Governance ID: 21. Registry code: `API__V1_ADMIN_SETTINGS_USAGE-STATS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 22: POST /v1/admin/search

## Registered operation
`POST /v1/admin/search`

Governance ID: 22. Registry code: `API__V1_ADMIN_SEARCH`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 23: POST /v1/admin/staff-groups

## Registered operation
`POST /v1/admin/staff-groups`

Governance ID: 23. Registry code: `API__V1_ADMIN_STAFF-GROUPS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 24: POST /v1/admin/services

## Registered operation
`POST /v1/admin/services`

Governance ID: 24. Registry code: `API__V1_ADMIN_SERVICES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 25: POST /v1/admin/scrum/env-audit

## Registered operation
`POST /v1/admin/scrum/env-audit`

Governance ID: 25. Registry code: `API__V1_ADMIN_SCRUM_ENV-AUDIT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 26: POST /v1/admin/scrum/audits

## Registered operation
`POST /v1/admin/scrum/audits`

Governance ID: 26. Registry code: `API__V1_ADMIN_SCRUM_AUDITS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 27: POST /v1/admin/scrum/response-bot/audit

## Registered operation
`POST /v1/admin/scrum/response-bot/audit`

Governance ID: 27. Registry code: `API__V1_ADMIN_SCRUM_RESPONSE-BOT_AUDIT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 28: POST /v1/admin/scrum/registry/sync

## Registered operation
`POST /v1/admin/scrum/registry/sync`

Governance ID: 28. Registry code: `API__V1_ADMIN_SCRUM_REGISTRY_SYNC`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 29: POST /v1/admin/developer/keys

## Registered operation
`POST /v1/admin/developer/keys`

Governance ID: 29. Registry code: `API__V1_ADMIN_DEVELOPER_KEYS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 30: POST /v1/admin/developer/db-push

## Registered operation
`POST /v1/admin/developer/db-push`

Governance ID: 30. Registry code: `API__V1_ADMIN_DEVELOPER_DB-PUSH`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 31: POST /v1/admin/actions/commit-overrides

## Registered operation
`POST /v1/admin/actions/commit-overrides`

Governance ID: 31. Registry code: `API__V1_ADMIN_ACTIONS_COMMIT-OVERRIDES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 32: POST /v1/admin/actions/export

## Registered operation
`POST /v1/admin/actions/export`

Governance ID: 32. Registry code: `API__V1_ADMIN_ACTIONS_EXPORT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 33: POST /v1/admin/actions/trigger-automation

## Registered operation
`POST /v1/admin/actions/trigger-automation`

Governance ID: 33. Registry code: `API__V1_ADMIN_ACTIONS_TRIGGER-AUTOMATION`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 34: POST /v1/admin/actions/optimize

## Registered operation
`POST /v1/admin/actions/optimize`

Governance ID: 34. Registry code: `API__V1_ADMIN_ACTIONS_OPTIMIZE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 35: POST /v1/admin/actions/backup

## Registered operation
`POST /v1/admin/actions/backup`

Governance ID: 35. Registry code: `API__V1_ADMIN_ACTIONS_BACKUP`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 36: POST /v1/admin/actions/publish-content

## Registered operation
`POST /v1/admin/actions/publish-content`

Governance ID: 36. Registry code: `API__V1_ADMIN_ACTIONS_PUBLISH-CONTENT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 37: POST /v1/admin/actions/reindex-search

## Registered operation
`POST /v1/admin/actions/reindex-search`

Governance ID: 37. Registry code: `API__V1_ADMIN_ACTIONS_REINDEX-SEARCH`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 38: POST /v1/admin/actions/suspend-reseller

## Registered operation
`POST /v1/admin/actions/suspend-reseller`

Governance ID: 38. Registry code: `API__V1_ADMIN_ACTIONS_SUSPEND-RESELLER`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 39: POST /v1/admin/actions/shifts

## Registered operation
`POST /v1/admin/actions/shifts`

Governance ID: 39. Registry code: `API__V1_ADMIN_ACTIONS_SHIFTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 40: POST /v1/admin/actions/regions

## Registered operation
`POST /v1/admin/actions/regions`

Governance ID: 40. Registry code: `API__V1_ADMIN_ACTIONS_REGIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 41: POST /v1/admin/actions/surveys

## Registered operation
`POST /v1/admin/actions/surveys`

Governance ID: 41. Registry code: `API__V1_ADMIN_ACTIONS_SURVEYS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 42: POST /v1/admin/actions/training-modules

## Registered operation
`POST /v1/admin/actions/training-modules`

Governance ID: 42. Registry code: `API__V1_ADMIN_ACTIONS_TRAINING-MODULES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 43: POST /v1/admin/actions/emergency/trigger

## Registered operation
`POST /v1/admin/actions/emergency/trigger`

Governance ID: 43. Registry code: `API__V1_ADMIN_ACTIONS_EMERGENCY_TRIGGER`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 44: POST /v1/admin/actions/audit-chain/verify

## Registered operation
`POST /v1/admin/actions/audit-chain/verify`

Governance ID: 44. Registry code: `API__V1_ADMIN_ACTIONS_AUDIT-CHAIN_VERIFY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 45: POST /v1/admin/actions/audit-chain/stats

## Registered operation
`POST /v1/admin/actions/audit-chain/stats`

Governance ID: 45. Registry code: `API__V1_ADMIN_ACTIONS_AUDIT-CHAIN_STATS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 46: POST /v1/admin/insurance-providers

## Registered operation
`POST /v1/admin/insurance-providers`

Governance ID: 46. Registry code: `API__V1_ADMIN_INSURANCE-PROVIDERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 47: POST /v1/admin/billing-codes

## Registered operation
`POST /v1/admin/billing-codes`

Governance ID: 47. Registry code: `API__V1_ADMIN_BILLING-CODES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 48: POST /v1/admin/visits

## Registered operation
`POST /v1/admin/visits`

Governance ID: 48. Registry code: `API__V1_ADMIN_VISITS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 49: POST /v1/admin/visits/assign

## Registered operation
`POST /v1/admin/visits/assign`

Governance ID: 49. Registry code: `API__V1_ADMIN_VISITS_ASSIGN`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 50: POST /v1/admin/timesheets

## Registered operation
`POST /v1/admin/timesheets`

Governance ID: 50. Registry code: `API__V1_ADMIN_TIMESHEETS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 51: POST /v1/admin/incidents

## Registered operation
`POST /v1/admin/incidents`

Governance ID: 51. Registry code: `API__V1_ADMIN_INCIDENTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 52: POST /v1/admin/booking-requests

## Registered operation
`POST /v1/admin/booking-requests`

Governance ID: 52. Registry code: `API__V1_ADMIN_BOOKING-REQUESTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 53: POST /v1/admin/clients

## Registered operation
`POST /v1/admin/clients`

Governance ID: 53. Registry code: `API__V1_ADMIN_CLIENTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 54: POST /v1/admin/leads

## Registered operation
`POST /v1/admin/leads`

Governance ID: 54. Registry code: `API__V1_ADMIN_LEADS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 846: GET /v1/admin/leads

## Registered operation
`GET /v1/admin/leads`

Governance ID: 846. Registry code: `API__V1_ADMIN_LEADS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 55: POST /v1/admin/reports/export

## Registered operation
`POST /v1/admin/reports/export`

Governance ID: 55. Registry code: `API__V1_ADMIN_REPORTS_EXPORT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 56: POST /v1/admin/referrals

## Registered operation
`POST /v1/admin/referrals`

Governance ID: 56. Registry code: `API__V1_ADMIN_REFERRALS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 57: POST /v1/admin/referrals/analytics

## Registered operation
`POST /v1/admin/referrals/analytics`

Governance ID: 57. Registry code: `API__V1_ADMIN_REFERRALS_ANALYTICS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 58: POST /v1/admin/notifications

## Registered operation
`POST /v1/admin/notifications`

Governance ID: 58. Registry code: `API__V1_ADMIN_NOTIFICATIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 59: POST /v1/admin/notifications/broadcast

## Registered operation
`POST /v1/admin/notifications/broadcast`

Governance ID: 59. Registry code: `API__V1_ADMIN_NOTIFICATIONS_BROADCAST`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 60: POST /v1/admin/documents

## Registered operation
`POST /v1/admin/documents`

Governance ID: 60. Registry code: `API__V1_ADMIN_DOCUMENTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 61: POST /v1/admin/documents/pending

## Registered operation
`POST /v1/admin/documents/pending`

Governance ID: 61. Registry code: `API__V1_ADMIN_DOCUMENTS_PENDING`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 62: POST /v1/admin/documents/upload

## Registered operation
`POST /v1/admin/documents/upload`

Governance ID: 62. Registry code: `API__V1_ADMIN_DOCUMENTS_UPLOAD`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 63: POST /v1/admin/evv

## Registered operation
`POST /v1/admin/evv`

Governance ID: 63. Registry code: `API__V1_ADMIN_EVV`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 64: POST /v1/admin/evv/exceptions

## Registered operation
`POST /v1/admin/evv/exceptions`

Governance ID: 64. Registry code: `API__V1_ADMIN_EVV_EXCEPTIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 65: POST /v1/admin/evv/compliance-summary

## Registered operation
`POST /v1/admin/evv/compliance-summary`

Governance ID: 65. Registry code: `API__V1_ADMIN_EVV_COMPLIANCE-SUMMARY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 66: POST /v1/admin/evv/export

## Registered operation
`POST /v1/admin/evv/export`

Governance ID: 66. Registry code: `API__V1_ADMIN_EVV_EXPORT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 67: POST /v1/admin/consent

## Registered operation
`POST /v1/admin/consent`

Governance ID: 67. Registry code: `API__V1_ADMIN_CONSENT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 68: POST /v1/admin/consent/templates

## Registered operation
`POST /v1/admin/consent/templates`

Governance ID: 68. Registry code: `API__V1_ADMIN_CONSENT_TEMPLATES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 69: POST /v1/admin/consent/expiring

## Registered operation
`POST /v1/admin/consent/expiring`

Governance ID: 69. Registry code: `API__V1_ADMIN_CONSENT_EXPIRING`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 70: POST /v1/admin/authorizations

## Registered operation
`POST /v1/admin/authorizations`

Governance ID: 70. Registry code: `API__V1_ADMIN_AUTHORIZATIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 71: POST /v1/admin/authorizations/alerts

## Registered operation
`POST /v1/admin/authorizations/alerts`

Governance ID: 71. Registry code: `API__V1_ADMIN_AUTHORIZATIONS_ALERTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 72: POST /v1/admin/pharmacy/prescriptions

## Registered operation
`POST /v1/admin/pharmacy/prescriptions`

Governance ID: 72. Registry code: `API__V1_ADMIN_PHARMACY_PRESCRIPTIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 73: POST /v1/admin/pharmacy/orders

## Registered operation
`POST /v1/admin/pharmacy/orders`

Governance ID: 73. Registry code: `API__V1_ADMIN_PHARMACY_ORDERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 74: POST /v1/admin/pharmacy/verify-barcode

## Registered operation
`POST /v1/admin/pharmacy/verify-barcode`

Governance ID: 74. Registry code: `API__V1_ADMIN_PHARMACY_VERIFY-BARCODE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 75: POST /v1/admin/pharmacy/mar/sync

## Registered operation
`POST /v1/admin/pharmacy/mar/sync`

Governance ID: 75. Registry code: `API__V1_ADMIN_PHARMACY_MAR_SYNC`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 76: POST /v1/admin/automation/clinical-autopilot/clinical-autopilot/run

## Registered operation
`POST /v1/admin/automation/clinical-autopilot/clinical-autopilot/run`

Governance ID: 76. Registry code: `API__V1_ADMIN_AUTOMATION_CLINICAL-AUTOPILOT_CLINICAL-AUTOPILOT_RUN`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 77: POST /v1/admin/financial

## Registered operation
`POST /v1/admin/financial`

Governance ID: 77. Registry code: `API__V1_ADMIN_FINANCIAL`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 78: POST /v1/admin/financial/accounts

## Registered operation
`POST /v1/admin/financial/accounts`

Governance ID: 78. Registry code: `API__V1_ADMIN_FINANCIAL_ACCOUNTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 79: POST /v1/admin/financial/initialize

## Registered operation
`POST /v1/admin/financial/initialize`

Governance ID: 79. Registry code: `API__V1_ADMIN_FINANCIAL_INITIALIZE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 80: POST /v1/admin/financial/invoices

## Registered operation
`POST /v1/admin/financial/invoices`

Governance ID: 80. Registry code: `API__V1_ADMIN_FINANCIAL_INVOICES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 81: POST /v1/admin/financial/balances

## Registered operation
`POST /v1/admin/financial/balances`

Governance ID: 81. Registry code: `API__V1_ADMIN_FINANCIAL_BALANCES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 82: POST /v1/admin/financial/reconcile

## Registered operation
`POST /v1/admin/financial/reconcile`

Governance ID: 82. Registry code: `API__V1_ADMIN_FINANCIAL_RECONCILE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 83: POST /v1/admin/financial/reconcile/auto

## Registered operation
`POST /v1/admin/financial/reconcile/auto`

Governance ID: 83. Registry code: `API__V1_ADMIN_FINANCIAL_RECONCILE_AUTO`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 84: POST /v1/admin/financial/reconciliation-summary

## Registered operation
`POST /v1/admin/financial/reconciliation-summary`

Governance ID: 84. Registry code: `API__V1_ADMIN_FINANCIAL_RECONCILIATION-SUMMARY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 85: POST /v1/admin/financial/reports/p-and-l

## Registered operation
`POST /v1/admin/financial/reports/p-and-l`

Governance ID: 85. Registry code: `API__V1_ADMIN_FINANCIAL_REPORTS_P-AND-L`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 86: POST /v1/admin/financial/reports/balance-sheet

## Registered operation
`POST /v1/admin/financial/reports/balance-sheet`

Governance ID: 86. Registry code: `API__V1_ADMIN_FINANCIAL_REPORTS_BALANCE-SHEET`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 87: POST /v1/admin/financial/reports/daily-summary

## Registered operation
`POST /v1/admin/financial/reports/daily-summary`

Governance ID: 87. Registry code: `API__V1_ADMIN_FINANCIAL_REPORTS_DAILY-SUMMARY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 88: POST /v1/admin/financial/reports/trading-account

## Registered operation
`POST /v1/admin/financial/reports/trading-account`

Governance ID: 88. Registry code: `API__V1_ADMIN_FINANCIAL_REPORTS_TRADING-ACCOUNT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 89: POST /v1/admin/financial/reports/forecast

## Registered operation
`POST /v1/admin/financial/reports/forecast`

Governance ID: 89. Registry code: `API__V1_ADMIN_FINANCIAL_REPORTS_FORECAST`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 90: POST /v1/admin/financial/reports/tax-filing

## Registered operation
`POST /v1/admin/financial/reports/tax-filing`

Governance ID: 90. Registry code: `API__V1_ADMIN_FINANCIAL_REPORTS_TAX-FILING`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 91: POST /v1/admin/financial/tax-remittance

## Registered operation
`POST /v1/admin/financial/tax-remittance`

Governance ID: 91. Registry code: `API__V1_ADMIN_FINANCIAL_TAX-REMITTANCE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 92: POST /v1/admin/financial/earnings

## Registered operation
`POST /v1/admin/financial/earnings`

Governance ID: 92. Registry code: `API__V1_ADMIN_FINANCIAL_EARNINGS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 93: POST /v1/admin/financial/reconciliation/unmatched

## Registered operation
`POST /v1/admin/financial/reconciliation/unmatched`

Governance ID: 93. Registry code: `API__V1_ADMIN_FINANCIAL_RECONCILIATION_UNMATCHED`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 94: POST /v1/admin/financial/reconciliation/match

## Registered operation
`POST /v1/admin/financial/reconciliation/match`

Governance ID: 94. Registry code: `API__V1_ADMIN_FINANCIAL_RECONCILIATION_MATCH`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 95: POST /v1/admin/payroll/pending

## Registered operation
`POST /v1/admin/payroll/pending`

Governance ID: 95. Registry code: `API__V1_ADMIN_PAYROLL_PENDING`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 96: POST /v1/admin/payroll/batch/approve

## Registered operation
`POST /v1/admin/payroll/batch/approve`

Governance ID: 96. Registry code: `API__V1_ADMIN_PAYROLL_BATCH_APPROVE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 97: POST /v1/admin/payroll/run

## Registered operation
`POST /v1/admin/payroll/run`

Governance ID: 97. Registry code: `API__V1_ADMIN_PAYROLL_RUN`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 98: POST /v1/admin/claims

## Registered operation
`POST /v1/admin/claims`

Governance ID: 98. Registry code: `API__V1_ADMIN_CLAIMS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 99: POST /v1/admin/claims/scrub

## Registered operation
`POST /v1/admin/claims/scrub`

Governance ID: 99. Registry code: `API__V1_ADMIN_CLAIMS_SCRUB`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 100: POST /v1/admin/claims/era

## Registered operation
`POST /v1/admin/claims/era`

Governance ID: 100. Registry code: `API__V1_ADMIN_CLAIMS_ERA`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 101: POST /v1/admin/claims/system/sync

## Registered operation
`POST /v1/admin/claims/system/sync`

Governance ID: 101. Registry code: `API__V1_ADMIN_CLAIMS_SYSTEM_SYNC`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 102: POST /v1/admin/claims/system/submit

## Registered operation
`POST /v1/admin/claims/system/submit`

Governance ID: 102. Registry code: `API__V1_ADMIN_CLAIMS_SYSTEM_SUBMIT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 103: POST /v1/admin/erp/inventory

## Registered operation
`POST /v1/admin/erp/inventory`

Governance ID: 103. Registry code: `API__V1_ADMIN_ERP_INVENTORY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 104: POST /v1/admin/erp/purchase-orders

## Registered operation
`POST /v1/admin/erp/purchase-orders`

Governance ID: 104. Registry code: `API__V1_ADMIN_ERP_PURCHASE-ORDERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 105: POST /v1/admin/erp/po/create

## Registered operation
`POST /v1/admin/erp/po/create`

Governance ID: 105. Registry code: `API__V1_ADMIN_ERP_PO_CREATE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 106: POST /v1/admin/erp/inventory/add

## Registered operation
`POST /v1/admin/erp/inventory/add`

Governance ID: 106. Registry code: `API__V1_ADMIN_ERP_INVENTORY_ADD`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 107: POST /v1/admin/blog

## Registered operation
`POST /v1/admin/blog`

Governance ID: 107. Registry code: `API__V1_ADMIN_BLOG`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 108: POST /v1/admin/faqs

## Registered operation
`POST /v1/admin/faqs`

Governance ID: 108. Registry code: `API__V1_ADMIN_FAQS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 840: GET /v1/admin/faqs

## Registered operation
`GET /v1/admin/faqs`

Governance ID: 840. Registry code: `API__V1_ADMIN_FAQS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 109: POST /v1/admin/dam/design/sync-fonts

## Registered operation
`POST /v1/admin/dam/design/sync-fonts`

Governance ID: 109. Registry code: `API__V1_ADMIN_DAM_DESIGN_SYNC-FONTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 110: POST /v1/admin/dam/design/sync-tokens

## Registered operation
`POST /v1/admin/dam/design/sync-tokens`

Governance ID: 110. Registry code: `API__V1_ADMIN_DAM_DESIGN_SYNC-TOKENS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 111: POST /v1/admin/dam/traffic/routing-rules

## Registered operation
`POST /v1/admin/dam/traffic/routing-rules`

Governance ID: 111. Registry code: `API__V1_ADMIN_DAM_TRAFFIC_ROUTING-RULES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 112: POST /v1/admin/dam/workflows/visual-logic

## Registered operation
`POST /v1/admin/dam/workflows/visual-logic`

Governance ID: 112. Registry code: `API__V1_ADMIN_DAM_WORKFLOWS_VISUAL-LOGIC`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 113: POST /v1/admin/dam/workflows/rollback

## Registered operation
`POST /v1/admin/dam/workflows/rollback`

Governance ID: 113. Registry code: `API__V1_ADMIN_DAM_WORKFLOWS_ROLLBACK`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 114: POST /v1/admin/dam/workflows/schemas

## Registered operation
`POST /v1/admin/dam/workflows/schemas`

Governance ID: 114. Registry code: `API__V1_ADMIN_DAM_WORKFLOWS_SCHEMAS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 115: POST /v1/admin/dam/workflows/rate-limits

## Registered operation
`POST /v1/admin/dam/workflows/rate-limits`

Governance ID: 115. Registry code: `API__V1_ADMIN_DAM_WORKFLOWS_RATE-LIMITS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 116: POST /v1/admin/dam/templates/no-code

## Registered operation
`POST /v1/admin/dam/templates/no-code`

Governance ID: 116. Registry code: `API__V1_ADMIN_DAM_TEMPLATES_NO-CODE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 117: POST /v1/admin/dam/security/rbac-matrix

## Registered operation
`POST /v1/admin/dam/security/rbac-matrix`

Governance ID: 117. Registry code: `API__V1_ADMIN_DAM_SECURITY_RBAC-MATRIX`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 118: POST /v1/admin/dam/media/redact-document

## Registered operation
`POST /v1/admin/dam/media/redact-document`

Governance ID: 118. Registry code: `API__V1_ADMIN_DAM_MEDIA_REDACT-DOCUMENT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 119: POST /v1/admin/dam/media/cdn-sync

## Registered operation
`POST /v1/admin/dam/media/cdn-sync`

Governance ID: 119. Registry code: `API__V1_ADMIN_DAM_MEDIA_CDN-SYNC`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 120: POST /v1/admin/dam/media/lifecycle-policies

## Registered operation
`POST /v1/admin/dam/media/lifecycle-policies`

Governance ID: 120. Registry code: `API__V1_ADMIN_DAM_MEDIA_LIFECYCLE-POLICIES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 121: POST /v1/admin/dam/localization/i18n-dictionary

## Registered operation
`POST /v1/admin/dam/localization/i18n-dictionary`

Governance ID: 121. Registry code: `API__V1_ADMIN_DAM_LOCALIZATION_I18N-DICTIONARY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 122: POST /v1/admin/dam/governance/scripts-manifest

## Registered operation
`POST /v1/admin/dam/governance/scripts-manifest`

Governance ID: 122. Registry code: `API__V1_ADMIN_DAM_GOVERNANCE_SCRIPTS-MANIFEST`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 123: POST /v1/admin/dam/compliance/legal-blockers

## Registered operation
`POST /v1/admin/dam/compliance/legal-blockers`

Governance ID: 123. Registry code: `API__V1_ADMIN_DAM_COMPLIANCE_LEGAL-BLOCKERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 124: POST /v1/admin/dam/analytics/browser-matrix

## Registered operation
`POST /v1/admin/dam/analytics/browser-matrix`

Governance ID: 124. Registry code: `API__V1_ADMIN_DAM_ANALYTICS_BROWSER-MATRIX`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 125: POST /v1/admin/dam/accessibility/aria-labels

## Registered operation
`POST /v1/admin/dam/accessibility/aria-labels`

Governance ID: 125. Registry code: `API__V1_ADMIN_DAM_ACCESSIBILITY_ARIA-LABELS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 126: POST /v1/admin/dam/content/rich-text-policies

## Registered operation
`POST /v1/admin/dam/content/rich-text-policies`

Governance ID: 126. Registry code: `API__V1_ADMIN_DAM_CONTENT_RICH-TEXT-POLICIES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 127: POST /v1/admin/dam/content/dynamic-routing

## Registered operation
`POST /v1/admin/dam/content/dynamic-routing`

Governance ID: 127. Registry code: `API__V1_ADMIN_DAM_CONTENT_DYNAMIC-ROUTING`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 128: POST /v1/admin/marketing/churn-risks

## Registered operation
`POST /v1/admin/marketing/churn-risks`

Governance ID: 128. Registry code: `API__V1_ADMIN_MARKETING_CHURN-RISKS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 129: POST /v1/admin/marketing/drip-sequences

## Registered operation
`POST /v1/admin/marketing/drip-sequences`

Governance ID: 129. Registry code: `API__V1_ADMIN_MARKETING_DRIP-SEQUENCES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 130: POST /v1/admin/marketing/revenue-attribution

## Registered operation
`POST /v1/admin/marketing/revenue-attribution`

Governance ID: 130. Registry code: `API__V1_ADMIN_MARKETING_REVENUE-ATTRIBUTION`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 131: POST /v1/admin/marketing/subscribers

## Registered operation
`POST /v1/admin/marketing/subscribers`

Governance ID: 131. Registry code: `API__V1_ADMIN_MARKETING_SUBSCRIBERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 132: POST /v1/admin/marketing/promotions

## Registered operation
`POST /v1/admin/marketing/promotions`

Governance ID: 132. Registry code: `API__V1_ADMIN_MARKETING_PROMOTIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 133: POST /v1/admin/marketing/syndication/vault

## Registered operation
`POST /v1/admin/marketing/syndication/vault`

Governance ID: 133. Registry code: `API__V1_ADMIN_MARKETING_SYNDICATION_VAULT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 134: POST /v1/admin/marketing/syndication/post

## Registered operation
`POST /v1/admin/marketing/syndication/post`

Governance ID: 134. Registry code: `API__V1_ADMIN_MARKETING_SYNDICATION_POST`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 135: POST /v1/admin/telehealth/sessions

## Registered operation
`POST /v1/admin/telehealth/sessions`

Governance ID: 135. Registry code: `API__V1_ADMIN_TELEHEALTH_SESSIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 136: POST /v1/admin/telehealth/vitals

## Registered operation
`POST /v1/admin/telehealth/vitals`

Governance ID: 136. Registry code: `API__V1_ADMIN_TELEHEALTH_VITALS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 137: POST /v1/admin/telehealth/session/start

## Registered operation
`POST /v1/admin/telehealth/session/start`

Governance ID: 137. Registry code: `API__V1_ADMIN_TELEHEALTH_SESSION_START`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 138: POST /v1/admin/telehealth/triage/open

## Registered operation
`POST /v1/admin/telehealth/triage/open`

Governance ID: 138. Registry code: `API__V1_ADMIN_TELEHEALTH_TRIAGE_OPEN`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 139: POST /v1/admin/telehealth/vitals/verify

## Registered operation
`POST /v1/admin/telehealth/vitals/verify`

Governance ID: 139. Registry code: `API__V1_ADMIN_TELEHEALTH_VITALS_VERIFY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 140: POST /v1/admin/system-data/iot-events

## Registered operation
`POST /v1/admin/system-data/iot-events`

Governance ID: 140. Registry code: `API__V1_ADMIN_SYSTEM-DATA_IOT-EVENTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 141: POST /v1/admin/system-data/gamification

## Registered operation
`POST /v1/admin/system-data/gamification`

Governance ID: 141. Registry code: `API__V1_ADMIN_SYSTEM-DATA_GAMIFICATION`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 142: POST /v1/admin/system-data/notifications

## Registered operation
`POST /v1/admin/system-data/notifications`

Governance ID: 142. Registry code: `API__V1_ADMIN_SYSTEM-DATA_NOTIFICATIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 143: POST /v1/admin/system-data/ai-inferences

## Registered operation
`POST /v1/admin/system-data/ai-inferences`

Governance ID: 143. Registry code: `API__V1_ADMIN_SYSTEM-DATA_AI-INFERENCES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 144: POST /v1/admin/system-data/communication-logs

## Registered operation
`POST /v1/admin/system-data/communication-logs`

Governance ID: 144. Registry code: `API__V1_ADMIN_SYSTEM-DATA_COMMUNICATION-LOGS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 145: POST /v1/admin/audit-export/download

## Registered operation
`POST /v1/admin/audit-export/download`

Governance ID: 145. Registry code: `API__V1_ADMIN_AUDIT-EXPORT_DOWNLOAD`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 146: POST /v1/admin/audit-export/compliance-home

## Registered operation
`POST /v1/admin/audit-export/compliance-home`

Governance ID: 146. Registry code: `API__V1_ADMIN_AUDIT-EXPORT_COMPLIANCE-HOME`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 147: POST /v1/admin/audit-export/regulatory-report

## Registered operation
`POST /v1/admin/audit-export/regulatory-report`

Governance ID: 147. Registry code: `API__V1_ADMIN_AUDIT-EXPORT_REGULATORY-REPORT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 148: POST /v1/admin/webhooks

## Registered operation
`POST /v1/admin/webhooks`

Governance ID: 148. Registry code: `API__V1_ADMIN_WEBHOOKS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 149: POST /v1/admin/webhooks/deliveries

## Registered operation
`POST /v1/admin/webhooks/deliveries`

Governance ID: 149. Registry code: `API__V1_ADMIN_WEBHOOKS_DELIVERIES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 150: POST /v1/admin/cron/compliance-sweep

## Registered operation
`POST /v1/admin/cron/compliance-sweep`

Governance ID: 150. Registry code: `API__V1_ADMIN_CRON_COMPLIANCE-SWEEP`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 151: POST /v1/admin/cron/training-reminders

## Registered operation
`POST /v1/admin/cron/training-reminders`

Governance ID: 151. Registry code: `API__V1_ADMIN_CRON_TRAINING-REMINDERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 152: POST /v1/admin/cron/authorization-exhaustion

## Registered operation
`POST /v1/admin/cron/authorization-exhaustion`

Governance ID: 152. Registry code: `API__V1_ADMIN_CRON_AUTHORIZATION-EXHAUSTION`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 153: POST /v1/admin/cron/inventory-reorder

## Registered operation
`POST /v1/admin/cron/inventory-reorder`

Governance ID: 153. Registry code: `API__V1_ADMIN_CRON_INVENTORY-REORDER`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 154: POST /v1/admin/interop/fhir/export

## Registered operation
`POST /v1/admin/interop/fhir/export`

Governance ID: 154. Registry code: `API__V1_ADMIN_INTEROP_FHIR_EXPORT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 155: POST /v1/admin/interop/fhir/import

## Registered operation
`POST /v1/admin/interop/fhir/import`

Governance ID: 155. Registry code: `API__V1_ADMIN_INTEROP_FHIR_IMPORT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 156: POST /v1/admin/interop/fhir/sync-log

## Registered operation
`POST /v1/admin/interop/fhir/sync-log`

Governance ID: 156. Registry code: `API__V1_ADMIN_INTEROP_FHIR_SYNC-LOG`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 157: POST /v1/admin/ai-iot/predictions

## Registered operation
`POST /v1/admin/ai-iot/predictions`

Governance ID: 157. Registry code: `API__V1_ADMIN_AI-IOT_PREDICTIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 158: POST /v1/admin/ai-iot/telehealth/session

## Registered operation
`POST /v1/admin/ai-iot/telehealth/session`

Governance ID: 158. Registry code: `API__V1_ADMIN_AI-IOT_TELEHEALTH_SESSION`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 159: POST /v1/admin/system/platform/stats

## Registered operation
`POST /v1/admin/system/platform/stats`

Governance ID: 159. Registry code: `API__V1_ADMIN_SYSTEM_PLATFORM_STATS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 160: POST /v1/admin/system/risk-surveillance

## Registered operation
`POST /v1/admin/system/risk-surveillance`

Governance ID: 160. Registry code: `API__V1_ADMIN_SYSTEM_RISK-SURVEILLANCE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 161: POST /v1/admin/insights/predictive-staffing

## Registered operation
`POST /v1/admin/insights/predictive-staffing`

Governance ID: 161. Registry code: `API__V1_ADMIN_INSIGHTS_PREDICTIVE-STAFFING`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 162: POST /v1/admin/reseller

## Registered operation
`POST /v1/admin/reseller`

Governance ID: 162. Registry code: `API__V1_ADMIN_RESELLER`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 163: POST /v1/admin/reseller/provision

## Registered operation
`POST /v1/admin/reseller/provision`

Governance ID: 163. Registry code: `API__V1_ADMIN_RESELLER_PROVISION`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 164: POST /v1/admin/stats

## Registered operation
`POST /v1/admin/stats`

Governance ID: 164. Registry code: `API__V1_ADMIN_STATS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 165: POST /v1/admin/ops/center

## Registered operation
`POST /v1/admin/ops/center`

Governance ID: 165. Registry code: `API__V1_ADMIN_OPS_CENTER`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 166: POST /v1/manager/home/stats

## Registered operation
`POST /v1/manager/home/stats`

Governance ID: 166. Registry code: `API__V1_MANAGER_HOME_STATS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 167: POST /v1/manager/home/today

## Registered operation
`POST /v1/manager/home/today`

Governance ID: 167. Registry code: `API__V1_MANAGER_HOME_TODAY`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 168: POST /v1/manager/home/kpi

## Registered operation
`POST /v1/manager/home/kpi`

Governance ID: 168. Registry code: `API__V1_MANAGER_HOME_KPI`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 169: POST /v1/manager/finance/payroll-audit

## Registered operation
`POST /v1/manager/finance/payroll-audit`

Governance ID: 169. Registry code: `API__V1_MANAGER_FINANCE_PAYROLL-AUDIT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 170: POST /v1/manager/ops/stats

## Registered operation
`POST /v1/manager/ops/stats`

Governance ID: 170. Registry code: `API__V1_MANAGER_OPS_STATS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 171: POST /v1/manager/ops/compliance/sync

## Registered operation
`POST /v1/manager/ops/compliance/sync`

Governance ID: 171. Registry code: `API__V1_MANAGER_OPS_COMPLIANCE_SYNC`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 172: POST /v1/manager/ops/branch-health

## Registered operation
`POST /v1/manager/ops/branch-health`

Governance ID: 172. Registry code: `API__V1_MANAGER_OPS_BRANCH-HEALTH`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 173: POST /v1/manager/ops/intake/waitlist

## Registered operation
`POST /v1/manager/ops/intake/waitlist`

Governance ID: 173. Registry code: `API__V1_MANAGER_OPS_INTAKE_WAITLIST`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 174: POST /v1/manager/ops/schedule/logistics-board

## Registered operation
`POST /v1/manager/ops/schedule/logistics-board`

Governance ID: 174. Registry code: `API__V1_MANAGER_OPS_SCHEDULE_LOGISTICS-BOARD`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 175: POST /v1/manager/ops/incidents

## Registered operation
`POST /v1/manager/ops/incidents`

Governance ID: 175. Registry code: `API__V1_MANAGER_OPS_INCIDENTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 176: POST /v1/manager/ops/locations

## Registered operation
`POST /v1/manager/ops/locations`

Governance ID: 176. Registry code: `API__V1_MANAGER_OPS_LOCATIONS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 177: POST /v1/manager/ops/approvals

## Registered operation
`POST /v1/manager/ops/approvals`

Governance ID: 177. Registry code: `API__V1_MANAGER_OPS_APPROVALS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 178: POST /v1/manager/reviews

## Registered operation
`POST /v1/manager/reviews`

Governance ID: 178. Registry code: `API__V1_MANAGER_REVIEWS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 179: POST /v1/manager/training/assign

## Registered operation
`POST /v1/manager/training/assign`

Governance ID: 179. Registry code: `API__V1_MANAGER_TRAINING_ASSIGN`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 180: POST /v1/manager/training/compliance

## Registered operation
`POST /v1/manager/training/compliance`

Governance ID: 180. Registry code: `API__V1_MANAGER_TRAINING_COMPLIANCE`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 181: POST /v1/manager/training/modules

## Registered operation
`POST /v1/manager/training/modules`

Governance ID: 181. Registry code: `API__V1_MANAGER_TRAINING_MODULES`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 182: POST /v1/staff/home/stats

## Registered operation
`POST /v1/staff/home/stats`

Governance ID: 182. Registry code: `API__V1_STAFF_HOME_STATS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 183: POST /v1/staff/visits

## Registered operation
`POST /v1/staff/visits`

Governance ID: 183. Registry code: `API__V1_STAFF_VISITS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 184: POST /v1/staff/tickets

## Registered operation
`POST /v1/staff/tickets`

Governance ID: 184. Registry code: `API__V1_STAFF_TICKETS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 185: POST /v1/staff/customers

## Registered operation
`POST /v1/staff/customers`

Governance ID: 185. Registry code: `API__V1_STAFF_CUSTOMERS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 186: POST /v1/staff/ops/compliance/scan

## Registered operation
`POST /v1/staff/ops/compliance/scan`

Governance ID: 186. Registry code: `API__V1_STAFF_OPS_COMPLIANCE_SCAN`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 187: POST /v1/staff/tasks/grid

## Registered operation
`POST /v1/staff/tasks/grid`

Governance ID: 187. Registry code: `API__V1_STAFF_TASKS_GRID`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 188: POST /v1/staff/tasks

## Registered operation
`POST /v1/staff/tasks`

Governance ID: 188. Registry code: `API__V1_STAFF_TASKS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 189: POST /v1/staff/ops/incidents

## Registered operation
`POST /v1/staff/ops/incidents`

Governance ID: 189. Registry code: `API__V1_STAFF_OPS_INCIDENTS`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 190: POST /v1/staff/ops/incidents/submit

## Registered operation
`POST /v1/staff/ops/incidents/submit`

Governance ID: 190. Registry code: `API__V1_STAFF_OPS_INCIDENTS_SUBMIT`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 191: POST /v1/staff/messages/hub

## Registered operation
`POST /v1/staff/messages/hub`

Governance ID: 191. Registry code: `API__V1_STAFF_MESSAGES_HUB`. Registry status: `active` (not runtime evidence).

## Purpose and behavior
The route identifies the registered operation. A verified business-purpose description, side effects, prerequisites and completion criteria are not supplied by this endpoint record. Do not infer them from its name.

## Authentication and permissions
Registered auth_required: `1`. Permission key: `NOT DEFINED`. No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established by this export. Missing security metadata does not mean anonymous access is allowed.

## Request contract
No endpoint-level request schema is registered. Required fields, types, limits, content types, query parameters and validation behavior need approval.

## Response contract
No endpoint-level response schema is registered. Success codes, payloads, pagination and error bodies are unverified. The default response below is a documentation placeholder, not a runtime guarantee.

## Persistence and tenant isolation
Database mappings, tenant predicates, transaction boundaries, idempotency and write/read-back evidence must be validated before this operation is considered functional.

## Rate limiting and audit
Rate-limit key: `NOT DEFINED`. Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.

## Required verification
- Approved successful journey and persistence/read-back where applicable.
- Missing, expired and invalid credentials.
- Forbidden roles and cross-tenant requests.
- Invalid input, resource absence and database failure.
- Rate limiting and audit event emission.
These are proposed checks, not passed tests.

## Blocking findings
- missing_request_schema
- missing_response_schema
- missing_permission_key
- missing_rate_limit_key
- runtime_security_persistence_and_tests_not_verified

# 192: POST /v1/staff/messages/hub/audit

## Registered operation
`POST /v1/staff/messages/hub/audit`

Governance ID: 192. Registry code: `API__V1_STAFF_MESSAGES_HUB_AUDIT`. Registry status: `active` (not runtime evidence).

## Purpose ÛNuçmÊ×¬¢h­µç[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌˆÔÕÝŒKÙ^XÝ]]™KXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ^XÝ]]™KXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑVPÕUU‘KPÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌNˆÔÕÝŒKÙ^[œÙK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ^[œÙK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑVS”ÑKSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŽˆÔÕÝŒKÙš[˜[˜ÙKY\™XÝÜ‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙš[˜[˜ÙKY\™XÝÜ‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ’SSÑKQT‘PÕÔ‹PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÎˆÔÕÝŒKÙš[˜[˜ÙKY\™XÝÜ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙš[˜[˜ÙKY\™XÝÜ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ’SSÑKQT‘PÕÔ‹UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌˆÔÕÝŒKÙš[˜[˜ÚX[Y\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙš[˜[˜ÚX[Y\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ’SSÒPSQTÒ“ÐT‘ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌNˆÔÕÝŒKÙš[˜[˜ÚX[[Ü\˜][ÛœÍZËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙš[˜[˜ÚX[[Ü\˜][ÛœÍZËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ’SSÒPSSÔTUSÓ”ÍR×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŽˆÔÕÝŒKÙ›ÛÝÝ\ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ›ÛÝÝ\ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ“ÓÕÕTÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÎˆÔÕÝŒKÙœ˜[˜Ú\ÙKXÛÛ[X[™XÙ[\ZËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙKXÛÛ[X[™XÙ[\ZËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKPÓÓSPS‘PÑS•TR×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌˆÔÕÝŒKÙœ˜[˜Ú\ÙKXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙKXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKPÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌNˆÔÕÝŒKÙœ˜[˜Ú\ÙK[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕ‘T•’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌLˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹X\Ú[Y[ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹X\Ú[Y[ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌLˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹PTÒS•QS•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌLNˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹Xœ˜[˜Ú[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹Xœ˜[˜Ú[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌLKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹P”SÒSÕ‘T•’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌLŽˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹XÛY[ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹XÛY[ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌL‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹PÓQS•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌLÎˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌLËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹PÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌMˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹XÛÛ\X[˜ÙKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹XÛÛ\X[˜ÙKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹PÓÓTPSÑWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌMNˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹Yš[˜[˜ÙK\Û˜\ÚÝØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹Yš[˜[˜ÙK\Û˜\ÚÝØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹Q’SSÑKTÓTÒÕÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌMŽˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹\™\ÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹\™\ÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹T‘TÔ•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌMÎˆÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹\ÝY™‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[ÝÛ™\‹\ÝY™‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSÕÓ‘T‹TÕQ‘—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌNˆÔÕÝŒKÙœ˜[˜Ú\ÙK\Ø[\ËX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK\Ø[\ËX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌNˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKTÐSTËPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌNNˆÔÕÝŒKÙœ˜[˜Ú\ÙK\Ø[\Ë]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK\Ø[\Ë]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌNKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKTÐSTËUÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŒˆÔÕÝŒKÚ‹Y\™XÝÜ‹XÜ™Y[X[Y^\žKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Y\™XÝÜ‹XÜ™Y[X[Y^\žKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌŒˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹QT‘PÕÔ‹PÔ‘QS•PSQVT–WÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŒNˆÔÕÝŒKÚ‹Y\™XÝÜ‹Z\š[™Ë\\[[™KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Y\™XÝÜ‹Z\š[™Ë\\[[™KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌŒKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹QT‘PÕÔ‹RT’S‘ËTTSS‘WÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŒŽˆÔÕÝŒKÚ‹Y\™XÝÜ‹[Û˜›Ø\™[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Y\™XÝÜ‹[Û˜›Ø\™[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌŒ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹QT‘PÕÔ‹SÓ“ÐT‘S‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŒÎˆÔÕÝŒKÚ‹Y\™XÝÜ‹\ÝY™‹Yš[\ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Y\™XÝÜ‹\ÝY™‹Yš[\ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌŒËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹QT‘PÕÔ‹TÕQ‘‹Q’ST×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌˆÔÕÝŒKÚ‹Y\™XÝÜ‹]˜Z[š[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Y\™XÝÜ‹]˜Z[š[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹QT‘PÕÔ‹URS’S‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌNˆÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹X\ÜÙ\ÜÛY[\]Y]YKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹X\ÜÙ\ÜÛY[\]Y]YKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•RÑKPÓÓÔ‘SUÔ‹PTÔÑTÔÓQS•TUQUQWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŽˆÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹X›ÛÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹X›ÛÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•RÑKPÓÓÔ‘SUÔ‹P“ÓÒÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÎˆÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹YØÝ[Y[ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹YØÝ[Y[ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•RÑKPÓÓÔ‘SUÔ‹QÐÕSQS•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŽˆÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹Y›ÛÝË]\ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹Y›ÛÝË]\ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌŽˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•RÑKPÓÓÔ‘SUÔ‹Q“ÓÕËUTÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌŽNˆÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹[™]ËXÛY[Z[ZÙKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹[™]ËXÛY[Z[ZÙKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌŽKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•RÑKPÓÓÔ‘SUÔ‹S‘UËPÓQS•RS•RÑWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÌˆÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹\™Y™\œ˜[ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[ZÙKXÛÛÜ™[˜]Ü‹\™Y™\œ˜[ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•RÑKPÓÓÔ‘SUÔ‹T‘Q‘T”S×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÌNˆÔÕÝŒKÛÜ\˜][ÛœËXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛÜ\˜][ÛœËXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓÔTUSÓ”ËPÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÌŽˆÔÕÝŒKÜ^\›ÛØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ^\›ÛØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÌ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔVT“ÓÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÌÎˆÔÕÝŒKÜ™Y™\œ˜[[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™Y™\œ˜[[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÌËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘Q‘T”SSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÍˆÔÕÝŒKÜ™YÚ[Û˜[™X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™YÚ[Û˜[™X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘QÒSÓS‘PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÍNˆÔÕÝŒKÜ™YÚ[Û˜[™]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™YÚ[Û˜[™]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘QÒSÓS‘UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÍŽˆÔÕÝŒKÜ™YÚ[Û˜[X[˜YÙ\\ØX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™YÚ[Û˜[X[˜YÙ\\ØX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÍ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘QÒSÓSPSQÑT•TÐPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÍÎˆÔÕÝŒKÜ™YÚ[Û˜[X[˜YÙ\\Ø]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™YÚ[Û˜[X[˜YÙ\\Ø]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÍËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘QÒSÓSPSQÑT•TÐUÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÎˆÔÕÝŒKÜ™[X\ÙK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™[X\ÙK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÎˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘SPTÑKSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÌÎNˆÔÕÝŒKÜ™]™[YKX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™]™[YKX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÌÎKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘U‘S•QKPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍˆÔÕÝŒKÜ™]™[YKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™]™[YKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘U‘S•QWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍNˆÔÕÝŒKÜ™]™[YK\Û˜\ÚÝØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™]™[YK\Û˜\ÚÝØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘U‘S•QKTÓTÒÕÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŽˆÔÕÝŒKÜš\ÚË[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜš\ÚË[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ’TÒËSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÎˆÔÕÝŒKÜÙXÝ\š]KX]Y]ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÙXÝ\š]KX]Y]ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÑPÕT’UKPUQUÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍˆÔÕÝŒKÜÙ\šXÙK\]X[]KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÙ\šXÙK\]X[]KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÑT•’PÑKTUPSUWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍNˆÔÕÝŒKÜÚ\™ZÛ\‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÚ\™ZÛ\‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÒT‘RÓT‹PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŽˆÔÕÝŒKÜÚ\™ZÛ\‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÚ\™ZÛ\‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÒT‘RÓT‹UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÎˆÔÕÝŒKÜÝY™š[™Ë[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝY™š[™Ë[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕQ‘’S‘ËSÕ‘T•’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍˆÔÕÝŒKÜÝY™‹[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝY™‹[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕQ‘‹SPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍNˆÔÕÝŒKÜÞ\Ý[KZX[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÞ\Ý[KZX[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÖTÕSKRPSÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍLˆÔÕÝŒKÝ^XÛÛ\X[˜ÙKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ^XÛÛ\X[˜ÙKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍLˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕVPÓÓTPSÑWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍLNˆÔÕÝŒKÝ˜Z[š[™ËY\™XÝÜ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ˜Z[š[™ËY\™XÝÜ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍLKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕRS’S‘ËQT‘PÕÔ‹UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍLŽˆÔÕÝŒKÝš\[X[˜YÙ\‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝš\[X[˜YÙ\‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍL‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ’TSPSQÑT‹PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍLÎˆÔÕÝŒKÝš\[X[˜YÙ\‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝš\[X[˜YÙ\‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍLËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ’TSPSQÑT‹UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍMˆÔÕÝŒKÝÛÜšÙ›ÝËZ\ÜÝYKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝÛÜšÙ›ÝËZ\ÜÝYKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕÓÔ’Ñ“ÕËRTÔÕQWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍMNˆÔÕÝŒKØ][™[˜ÙKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØ][™[˜ÙKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐUS‘SÑWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍMŽˆÔÕÝŒKØ]Y]\™]šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØ]Y]\™]šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐUQUT‘U’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍMÎˆÔÕÝŒKØœ˜[™[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØœ˜[™[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐ”S‘SPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍNˆÔÕÝŒKØØ[\ZYÛ‹Y\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ[\ZYÛ‹Y\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍNˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐSTRQÓ‹QTÒ“ÐT‘ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍNNˆÔÕÝŒKØÛÛ\X[˜ÙKY\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÛ\X[˜ÙKY\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍNKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÓTPSÑKQTÒ“ÐT‘ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŒˆÔÕÝŒKØÛÜœ™XÝ]™KXXÝ[Û‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÜœ™XÝ]™KXXÝ[Û‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍŒˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÔ”‘PÕU‘KPPÕSÓ—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŒNˆÔÕÝŒKØÜ™Y[X[Y^\žKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÜ™Y[X[Y^\žKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍŒKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÔ‘QS•PSQVT–WÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŒŽˆÔÕÝŒKÙZ[K[Ü\˜][ÛœËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙZ[K[Ü\˜][ÛœËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍŒ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑRSKSÔTUSÓ”×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŒÎˆÔÕÝŒKÙ[\ÞYYK\™XÛÜ™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ[\ÞYYK\™XÛÜ™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍŒËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑSTÖQQKT‘PÓÔ‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍˆÔÕÝŒKÙœ˜[˜Ú\ÙK[XYØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙœ˜[˜Ú\ÙK[XYØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑ”SÒTÑKSPQÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍNˆÔÕÝŒKÙÜ›ÝÝX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙÜ›ÝÝX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑÔ“ÕÕPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŽˆÔÕÝŒKÚ\š[™Ë\\[[™KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ\š[™Ë\\[[™KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒT’S‘ËTTSS‘WÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÎˆÔÕÝŒKÚ[˜ÚY[[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[˜ÚY[[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒSÒQS•SPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŽˆÔÕÝŒKÛXYX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛXYX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍŽˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓPQPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍŽNˆÔÕÝŒKÛYØ[[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛYØ[[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍŽKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓQÐSSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÌˆÔÕÝŒKÛYØ[ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛYØ[ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓQÐSÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÌNˆÔÕÝŒKÛÛ˜›Ø\™[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛÛ˜›Ø\™[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓÓ“ÐT‘S‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÌŽˆÔÕÝŒKÛÝ]™XXÚXØ[\ZYÛ‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛÝ]™XXÚXØ[\ZYÛ‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÌ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓÕU‘PPÒPÐSTRQÓ—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÌÎˆÔÕÝŒKÜ\™\œÚ\[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ\™\œÚ\[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÌËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔT•‘T”ÒTSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÍˆÔÕÝŒKÜÛXÞK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÛXÞK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÓPÖKSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÍNˆÔÕÝŒKØÛÛ˜ÚY\™ÙKÜ›ÝšY\œËÙ\Ü]Ú‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÛ˜ÚY\™ÙKÜ›ÝšY\œËÙ\Ü]Ú‚‘ÛÝ™\›˜[˜ÙHQˆLÍÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÓÒQT‘ÑWÔ“Õ’QT”×ÑTÔUÒˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÍŽˆÔÕÝŒKØÛÛ˜ÚY\™ÙKÝš\Ù\ØØ[]B‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÛ˜ÚY\™ÙKÝš\Ù\ØØ[]X‚‘ÛÝ™\›˜[˜ÙHQˆLÍÍ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÓÒQT‘ÑWÕ’TÑTÐÐSUXˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÍÎˆÔÕÝŒKÜØÚY[[™ËZX[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[[™ËZX[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÍËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQSS‘ËRPSÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÎˆÔÕÝŒKÜÙ\šXÙKZ\ÜÝYKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÙ\šXÙKZ\ÜÝYKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÎˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÑT•’PÑKRTÔÕQWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÍÎNˆÔÕÝŒKÜÛØÚX[[YYXKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÛØÚX[[YYXKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÍÎKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÓÐÒPSSQQPWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎˆÔÕÝŒKÝ˜Z[š[™Ë[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ˜Z[š[™Ë[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕRS’S‘ËSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎNˆÔÕÝŒKÝš\ÝÝXÚÚ[ËÛÙÂ‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝš\ÝÝXÚÚ[ËÛÙØ‚‘ÛÝ™\›˜[˜ÙHQˆLÎKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ’TÕÕPÒÒS•×ÓÑØˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎŽˆÔÕÝŒKÝš\Ú\ÜÝY\ËÜ™\ÛÛ™B‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝš\Ú\ÜÝY\ËÜ™\ÛÛ™X‚‘ÛÝ™\›˜[˜ÙHQˆLÎ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ’TÒTÔÕQT×Ô‘TÓÓ‘Xˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎÎˆÔÕÝŒKÜ™[Z][KXÛÛ˜ÚY\™ÙKX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™[Z][KXÛÛ˜ÚY\™ÙKX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘SRUSKPÓÓÒQT‘ÑKPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎˆÔÕÝŒKÜ™[Z][KXÛÛ˜ÚY\™ÙK]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™[Z][KXÛÛ˜ÚY\™ÙK]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘SRUSKPÓÓÒQT‘ÑKUÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎNˆÔÕÝŒKØØ\™YÚ]™\‹XÛY[\›Ùš[KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ\™YÚ]™\‹XÛY[\›Ùš[KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐT‘QÒU‘T‹PÓQS•T“Ñ’SWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎŽˆÔÕÝŒKØØ\™YÚ]™\‹Z[˜ÚY[\™\ÜØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ\™YÚ]™\‹Z[˜ÚY[\™\ÜØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐT‘QÒU‘T‹RSÒQS•T‘TÔ•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎÎˆÔÕÝŒKØØ\™YÚ]™\‹\ØÚY[KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ\™YÚ]™\‹\ØÚY[KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐT‘QÒU‘T‹TÐÒQSWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎˆÔÕÝŒKØØ\™YÚ]™\‹]\ÚÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ\™YÚ]™\‹]\ÚÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐT‘QÒU‘T‹UTÒÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎNˆÔÕÝŒKØØ\™YÚ]™\‹]š\Ú][›Ý\ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ\™YÚ]™\‹]š\Ú][›Ý\ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐT‘QÒU‘T‹U’TÒUS“ÕT×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎLˆÔÕÝŒKÚ[˜ÚY[\™\ÜØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[˜ÚY[\™\ÜØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎLˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒSÒQS•T‘TÔ•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎLNˆÔÕÝŒKÛY\ÜØYÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛY\ÜØYÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎLKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓQTÔÐQÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎLŽˆÔÕÝŒKÜÝËXØ\™K\[‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝËXØ\™K\[‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎL‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËPÐT‘KTS—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎLÎˆÔÕÝŒKÜÝËXÛY[\›Ùš[KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝËXÛY[\›Ùš[KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎLËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËPÓQS•T“Ñ’SWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎMˆÔÕÝŒKÜÝËXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝËXÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËPÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎMNˆÔÕÝŒKÜÝËYØÝ[Y[ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝËYØÝ[Y[ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËQÐÕSQS•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎMŽˆÔÕÝŒKÜÝËZ[˜ÚY[\™\ÜØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝËZ[˜ÚY[\™\ÜØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËRSÒQS•T‘TÔ•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎMÎˆÔÕÝŒKÜÝË[Y\ÜØYÙ\ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝË[Y\ÜØYÙ\ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËSQTÔÐQÑT×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎNˆÔÕÝŒKÜÝË[^K\ÚYËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝË[^K\ÚYËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎNˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËSVKTÒQ•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈLÎNNˆÔÕÝŒKÜÝË]š\Ú][›Ý\ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝË]š\Ú][›Ý\ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆLÎNKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËU’TÒUS“ÕT×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÜÝË]š][Ë[ÙËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝË]š][Ë[ÙËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕËU’USËSÑ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÜØÚY[KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQSWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKÜÚY]\ÚÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÚY]\ÚÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÒQ•UTÒÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKÝš\Ú][›Ý\ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝš\Ú][›Ý\ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ’TÒUS“ÕT×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÝš][ËY[žKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝš][ËY[žKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ’USËQS•–WÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKØØ\™K\[‹\™]šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ\™K\[‹\™]šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐT‘KTS‹T‘U’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKØÛœËX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛœËX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓ”ËPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKØÛœË]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛœË]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓ”ËUÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÚ[˜ÚY[\™]šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[˜ÚY[\™]šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒSÒQS•T‘U’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÛYYXØ][Û‹XYZ[š\Ý˜][Û‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛYYXØ][Û‹XYZ[š\Ý˜][Û‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓQQPÐUSÓ‹PQRS’TÕUSÓ—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLˆÔÕÝŒKÛœX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛœX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMLˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓ”PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLNˆÔÕÝŒKÛœ]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛœ]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMLKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓ”UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLŽˆÔÕÝŒKÜ]Y[XÚ\[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ]Y[XÚ\[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆML‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔUQS•PÒT•S‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLÎˆÔÕÝŒKÜ›‹XØ\™K\[‹\™]šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹XØ\™K\[‹\™]šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMLËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹PÐT‘KTS‹T‘U’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMˆÔÕÝŒKÜ›‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹PÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMNˆÔÕÝŒKÜ›‹YšY[\Ý\\š\ÛÜ‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹YšY[\Ý\\š\ÛÜ‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹Q’QSTÕTT•’TÓÔ‹PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMŽˆÔÕÝŒKÜ›‹Ø]Y]ËÜÝX›Z]‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹Ø]Y]ËÜÝX›Z]‚‘ÛÝ™\›˜[˜ÙHQˆMM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“—ÐUQU×ÔÕP“RUˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMÎˆÔÕÝŒKÜ›‹Ø\ÜÙ\ÜÛY[ËÜÚYÛ›Ù™‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹Ø\ÜÙ\ÜÛY[ËÜÚYÛ›Ù™˜‚‘ÛÝ™\›˜[˜ÙHQˆMMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“—ÐTÔÑTÔÓQS•×ÔÒQÓ“Ñ‘˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÜ›‹YšY[\Ý\\š\ÛÜ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹YšY[\Ý\\š\ÛÜ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMNˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹Q’QSTÕTT•’TÓÔ‹UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNNˆÔÕÝŒKÜ›‹Z[˜ÚY[\™]šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹Z[˜ÚY[\™]šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMNKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹RSÒQS•T‘U’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒˆÔÕÝŒKÜ›‹[YYXØ][ÛœËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹[YYXØ][ÛœËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹SQQPÐUSÓ”×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒNˆÔÕÝŒKÜ›‹\]Y[XÚ\[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹\]Y[XÚ\[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹TUQS•PÒT•S‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒŽˆÔÕÝŒKÜ›‹\™\ÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹\™\ÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹T‘TÔ•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒÎˆÔÕÝŒKÜ›‹]\ÚÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹]\ÚÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹UTÒÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÜ›‹]š][ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ›‹]š][ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ“‹U’US×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÜÚY\™\ÜØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÚY\™\ÜØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÒQ•T‘TÔ•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKÛ‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛ‹X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓ‹PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKÛ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛ‹]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓ‹UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKÜœ‹XØ\™K\[‹\™]šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹XØ\™K\[‹\™]šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŽˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹PÐT‘KTS‹T‘U’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽNˆÔÕÝŒKÜœ‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŽKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹PÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌˆÔÕÝŒKÜœ‹Z[˜ÚY[\™]šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹Z[˜ÚY[\™]šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹RSÒQS•T‘U’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌNˆÔÕÝŒKÜœ‹[YYXØ][ÛœËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹[YYXØ][ÛœËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹SQQPÐUSÓ”×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌŽˆÔÕÝŒKÜœ‹\]Y[XÚ\[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹\]Y[XÚ\[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹TUQS•PÒT•S‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌÎˆÔÕÝŒKÜœ‹\™\ÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹\™\ÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹T‘TÔ•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍˆÔÕÝŒKÜœ‹]\ÚÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹]\ÚÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹UTÒÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍNˆÔÕÝŒKÜœ‹]š][ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜœ‹]š][ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ”‹U’US×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍŽˆÔÕÝŒKØ\XØ[]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØ\XØ[]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐTPÐS•UPÒÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍÎˆÔÕÝŒKØØ[[™\‹[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØØ[[™\‹[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÐSS‘T‹SPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKØÙ\YšXØ][Û‹]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÙ\YšXØ][Û‹]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÎˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÑT•Q’PÐUSÓ‹UPÒÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎNˆÔÕÝŒKØÚ\ÛØ[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÚ\ÛØ[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÎKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÒTÓÐSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKØÚ\ÛÝÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÚ\ÛÝÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÒTÓÕÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKØÛZ[\Ë\›ØÙ\ÜÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛZ[\Ë\›ØÙ\ÜÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓRSTËT“ÐÑTÔÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKØÛY[Z\ÜÝYKØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛY[Z\ÜÝYKØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓQS•RTÔÕQWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKØÛÛ[][šXØ][Û‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÛ[][šXØ][Û‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÓSUS’PÐUSÓ—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKØÛÛ[][š][Ý]™XXÚ[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÛ[][š][Ý]™XXÚ[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÓSUS’USÕU‘PPÒSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKØÛÛ[][š][Ý]™XXÚÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÛ[][š][Ý]™XXÚÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÓSUS’USÕU‘PPÒÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKØÛÛ™›XÝ\™\ÛÛ][Û‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÛ™›XÝ\™\ÛÛ][Û‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÓ‘“PÕT‘TÓÓUSÓ—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKØÛÝ\œÙKX\ÜÚYÛ›Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛÝ\œÙKX\ÜÚYÛ›Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓÕT”ÑKPTÔÒQÓ“QS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÙY™XÝ]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙY™XÝ]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑQ‘PÕUPÒÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÙ[\ÞYYKX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ[\ÞYYKX[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑSTÖQQKPSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLˆÔÕÝŒKÙ[\ÞYYKÜËÜ™\]Y\Ý‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ[\ÞYYKÜËÜ™\]Y\Ý‚‘ÛÝ™\›˜[˜ÙHQˆMLˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑSTÖQQWÔ×Ô‘TUQTÕˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLNˆÔÕÝŒKÙ[\ÞYYKÝ^ÙÝÛ›ØY‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ[\ÞYYKÝ^ÙÝÛ›ØY‚‘ÛÝ™\›˜[˜ÙHQˆMLKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑSTÖQQWÕVÑÕÓ“ÐQˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLŽˆÔÕÝŒKÙ[\ÞYYK]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ[\ÞYYK]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆML‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑSTÖQQKUÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLÎˆÔÕÝŒKÙ˜Z[Y]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÙ˜Z[Y]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMLËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÑRSQUÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMˆÔÕÝŒKÚ‹Z\š[™ËX\XØ[ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Z\š[™ËX\XØ[ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹RT’S‘ËPTPÐS•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMNˆÔÕÝŒKÚ‹Z\š[™ËXÜ™Y[X[ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Z\š[™ËXÜ™Y[X[ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹RT’S‘ËPÔ‘QS•PS×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMŽˆÔÕÝŒKÚ‹Z\š[™ËZ[\šY]ÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Z\š[™ËZ[\šY]ÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹RT’S‘ËRS•T•’QUÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMMÎˆÔÕÝŒKÚ‹Z\š[™Ë[Ù™™\œËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Z\š[™Ë[Ù™™\œËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹RT’S‘ËSÑ‘‘T”×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÚ‹Z\š[™Ë[Û˜›Ø\™[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ‹Z\š[™Ë[Û˜›Ø\™[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMNˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒ‹RT’S‘ËSÓ“ÐT‘S‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNNˆÔÕÝŒKÚ[™œ˜\ÝXÝ\™X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[™œ˜\ÝXÝ\™X[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMNKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS‘”TÕ•PÕT‘PSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒˆÔÕÝŒKÚ[™œ˜\ÝXÝ\™]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[™œ˜\ÝXÝ\™]ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS‘”TÕ•PÕT‘UÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒNˆÔÕÝŒKÚ[\šY]Ë\ØÚY[[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[\šY]Ë\ØÚY[[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•T•’QUËTÐÒQSS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒŽˆÔÕÝŒKÚ[›ÚXÙK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÚ[›ÚXÙK[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÒS•“ÒPÑKSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŒÎˆÔÕÝŒKÛÙ™™\‹[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛÙ™™\‹[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŒËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓÑ‘‘T‹SPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÛÛ˜›Ø\™[™ËXÚXÚÛ\ÝØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛÛ˜›Ø\™[™ËXÚXÚÛ\ÝØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓÓ“ÐT‘S‘ËPÒPÒÓTÕÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÛÜ[‹\ÚYØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛÜ[‹\ÚYØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓÔS‹TÒQ•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKÜ^[Y[]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ^[Y[]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔVSQS•UPÒÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKÜ]X[]KX]Y]ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ]X[]KX]Y]ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔUPSUKPUQUÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKÜ™Y[™[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™Y[™[X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŽˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘Q•S‘SPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽNˆÔÕÝŒKÜ™\ÛÛ][Û‹]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜ™\ÛÛ][Û‹]˜XÚÚ[™ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMŽKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔ‘TÓÓUSÓ‹UPÒÒS‘×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌˆÔÕÝŒKÜØÚY[\‹X›ÛÚÚ[™Ë\™\]Y\ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[\‹X›ÛÚÚ[™Ë\™\]Y\ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQST‹P“ÓÒÒS‘ËT‘TUQTÕ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌNˆÔÕÝŒKÜØÚY[\‹XØ[[™\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[\‹XØ[[™\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQST‹PÐSS‘T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌŽˆÔÕÝŒKÜØÚY[\‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[\‹XÛÛ[X[™XÙ[\‹ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQST‹PÓÓSPS‘PÑS•T—ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÌÎˆÔÕÝŒKÜØÚY[\‹XÛÛ™›XÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[\‹XÛÛ™›XÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÌËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQST‹PÓÓ‘“PÕ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍˆÔÕÝŒKÜØÚY[\‹[Ü[‹\ÚYËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[\‹[Ü[‹\ÚYËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQST‹SÔS‹TÒQ•×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍNˆÔÕÝŒKÜØÚY[\‹\›ÝšY\‹X]˜Z[Xš[]KØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[\‹\›ÝšY\‹X]˜Z[Xš[]KØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQST‹T“Õ’QT‹PURSP’SUWÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍŽˆÔÕÝŒKÜØÚY[[™ËY\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[[™ËY\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍ‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQSS‘ËQTÒ“ÐT‘ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÍÎˆÔÕÝŒKÜØÚY[[™Ë[Ü\˜][ÛœÍZËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÚY[[™Ë[Ü\˜][ÛœÍZËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÍËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÒQSS‘ËSÔTUSÓ”ÍR×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKÜØÜ[[X\Ý\˜[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÜ[[X\Ý\˜[˜[]XÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÎˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÔ•SSPTÕTSSUPÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎNˆÔÕÝŒKÜØÜ[[X\Ý\ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜØÜ[[X\Ý\ÛÜšÙ›ÝËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMÎKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÐÔ•SSPTÕT•ÓÔ’Ñ“Õ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÜÝY™‹\›ÙÜ™\ÜËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÜÝY™‹\›ÙÜ™\ÜËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÔÕQ‘‹T“ÑÔ‘TÔ×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÝ\Ý[™Ë[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ\Ý[™Ë[Ý™\šY]ËØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕTÕS‘ËSÕ‘T•’QU×ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMŽˆÔÕÝŒKÝXÚÙ][X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝXÚÙ][X[˜YÙ[Y[ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆM‹ˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕPÒÑUSPSQÑSQS•ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKÝ˜Z[š[™ËY\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ˜Z[š[™ËY\Ú›Ø\™ØÛÛ\X[˜ÙKÜØØ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕRS’S‘ËQTÒ“ÐT‘ÐÓÓTPSÑWÔÐÐS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKÝ›Û[Y\‹ÜÚYØÚXÚÚ[‚‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ›Û[Y\‹ÜÚYØÚXÚÚ[˜‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ“ÓS•QT—ÔÒQ•ÐÒPÒÒS˜ˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÝ›Û[Y\‹Ýš\Ú]ËÛÙÂ‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ›Û[Y\‹Ýš\Ú]ËÛÙØ‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕ“ÓS•QT—Õ’TÒU×ÓÑØˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMÎˆÔÕÝŒKØš[[™ËÜÝ[[X\žB‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØš[[™ËÜÝ[[X\žX‚‘ÛÝ™\›˜[˜ÙHQˆMËˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐ’SS‘×ÔÕSSPT–Xˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMˆÔÕÝŒKØÛ[šXØ[Ü]Y[Â‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØÛ[šXØ[Ü]Y[Ø‚‘ÛÝ™\›˜[˜ÙHQˆMˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐÓS’PÐSÔUQS•Øˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMNˆÔÕÝŒKÛÜ\˜][ÛœËÛÙÚ\ÝXÜÂ‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÛÜ\˜][ÛœËÛÙÚ\ÝXÜØ‚‘ÛÝ™\›˜[˜ÙHQˆMKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÓÔTUSÓ”×ÓÑÒTÕPÔØˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLˆÔÕÝŒKØ]]‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKØ]]‚‘ÛÝ™\›˜[˜ÙHQˆMLˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÐUUˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY‚ˆÈMLNˆÔÕÝŒKÝ\Ý‚ˆÈÈ™YÚ\Ý\™YÜ\˜][Û‚˜ÔÕÝŒKÝ\Ý‚‘ÛÝ™\›˜[˜ÙHQˆMLKˆ™YÚ\ÝžHÛÙNˆTW×ÕŒWÕTÕˆ™YÚ\ÝžHÝ]\ÎˆXÝ]™X
›Ý[[YH]šY[˜ÙJK‚‚ˆÈÈ\œÜÙH[™™Z]š[Ü‚•H›Ý]HY[YšY\ÈH™YÚ\Ý\™YÜ\˜][Û‹ˆH™\šYšYY\Ú[™\ÜË\\œÜÙH\ØÜš\[Û‹ÚYHY™™XÝË™\™\]Z\Ú]\È[™ÛÛ\][ÛˆÜš]\šXH\™H›ÝÝ\YYžH\È[™Ú[™XÛÜ™ˆÈ›Ý[™™\ˆ[Hœ›ÛH]È˜[YK‚‚ˆÈÈ]][XØ][Ûˆ[™\›Z\ÜÚ[ÛœÂ”™YÚ\Ý\™Y]]Ü™\]Z\™YˆXˆ\›Z\ÜÚ[ÛˆÙ^Nˆ“ÕQ’S‘Qˆ›È™]šY]ÙY[™Ú[\ÜXÚYšXÈ›ÛH[ÝÛ\Ý]][XØ][ÛˆØÚ[YKÜˆ[˜[ØÛÜH\È\ÝX›\ÚYžH\È^ÜˆZ\ÜÚ[™ÈÙXÝ\š]HY]Y]HÙ\È›ÝYX[ˆ[›Ûž[[Ý\ÈXØÙ\ÜÈ\È[ÝÙY‚‚ˆÈÈ™\]Y\ÝÛÛ˜XÝ“›È[™Ú[[]™[™\]Y\ÝØÚ[XH\È™YÚ\Ý\™Yˆ™\]Z\™YšY[Ë\\Ë[Z]ËÛÛ[\\Ë]Y\žH\˜[Y]\œÈ[™˜[Y][Ûˆ™Z]š[Üˆ™YY\›Ý˜[‚‚ˆÈÈ™\ÜÛœÙHÛÛ˜XÝ“›È[™Ú[[]™[™\ÜÛœÙHØÚ[XH\È™YÚ\Ý\™YˆÝXØÙ\ÜÈÛÙ\Ë^[ØYËYÚ[˜][Ûˆ[™\œ›Üˆ›ÙY\È\™H[™\šYšYYˆHY˜][™\ÜÛœÙH™[ÝÈ\ÈHØÝ[Y[][ÛˆXÙZÛ\‹›ÝH[[YHÝX\˜[YK‚‚ˆÈÈ\œÚ\Ý[˜ÙH[™[˜[\ÛÛ][Û‚‘]X˜\ÙHX\[™ÜË[˜[™YXØ]\Ë˜[œØXÝ[Ûˆ›Ý[™\šY\ËY[\Ý[˜ÞH[™Üš]KÜ™XYX˜XÚÈ]šY[˜ÙH]\Ý™H˜[Y]Y™Y›Ü™H\ÈÜ\˜][Ûˆ\ÈÛÛœÚY\™Y[˜Ý[Û˜[‚‚ˆÈÈ˜]H[Z][™È[™]Y]”˜]K[[Z]Ù^Nˆ“ÕQ’S‘Qˆ]Y]]™[Ë™][[Ûˆ[™™]žHÛXÞH™\]Z\™HH™]šY]ÙYÛÛ˜XÝˆÈ›Ý]]ÛX]XØ[H™]žH]]][ÛœË‚‚ˆÈÈ™\]Z\™Y™\šYšXØ][Û‚‹H\›Ý™YÝXØÙ\ÜÙ[›Ý\›™^H[™\œÚ\Ý[˜ÙKÜ™XYX˜XÚÈÚ\™H\XØX›K‚‹HZ\ÜÚ[™Ë^\™Y[™[˜[YÜ™Y[X[Ë‚‹H›Ü˜šY[ˆ›Û\È[™Ü›ÜÜË][˜[™\]Y\ÝË‚‹H[˜[Y[œ]™\ÛÝ\˜ÙHXœÙ[˜ÙH[™]X˜\ÙH˜Z[\™K‚‹H˜]H[Z][™È[™]Y]]™[[Z\ÜÚ[Û‹‚•\ÙH\™H›ÜÜÙYÚXÚÜË›Ý\ÜÙY\ÝË‚‚ˆÈÈ›ØÚÚ[™Èš[™[™ÜÂ‹HZ\ÜÚ[™×Ü™\]Y\ÝÜØÚ[XB‹HZ\ÜÚ[™×Ü™\ÜÛœÙWÜØÚ[XB‹HZ\ÜÚ[™×Ü\›Z\ÜÚ[Û—ÚÙ^B‹HZ\ÜÚ[™×Ü˜]WÛ[Z]ÚÙ^B‹H[[YWÜÙXÝ\š]WÜ\œÚ\Ý[˜ÙWØ[™Ý\Ý×Û›ÝÝ™\šYšYY