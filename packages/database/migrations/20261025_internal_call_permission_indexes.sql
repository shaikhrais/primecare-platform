-- Additive nonunique indexes only; run each statement outside a transaction.
-- Runtime joins must preserve native bigint/text types to use these indexes.
CREATE INDEX CONCURRENTLY "primecare_call_api_permission_lookup" ON "governance_68b0b02dd1215f58630d2c1a"."govt_api_permissions" ("role_id", "api_id");
CREATE INDEX CONCURRENTLY "primecare_call_screen_permission_lookup" ON "governance_68b0b02dd1215f58630d2c1a"."govt_role_screen_permissions" ("role_id", "screen_id");
CREATE INDEX CONCURRENTLY "primecare_call_screen_api_lookup" ON "governance_68b0b02dd1215f58630d2c1a"."govt_screen_api_links" ("api_id", "screen_id");
CREATE INDEX CONCURRENTLY "primecare_call_role_code_lookup" ON "governance_68b0b02dd1215f58630d2c1a"."govt_roles" ("role_code");
CREATE INDEX CONCURRENTLY "primecare_call_endpoint_route_lookup" ON "governance_68b0b02dd1215f58630d2c1a"."govt_api_endpoints" ("http_method", "route_path", "service_name");
