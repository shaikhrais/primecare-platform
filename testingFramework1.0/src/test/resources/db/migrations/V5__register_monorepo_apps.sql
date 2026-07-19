-- Seeding monorepo frontend applications (Cloudflare Pages URLs)
INSERT OR REPLACE INTO applications (application_id, application_key, application_name, base_url, api_base_url, environment, active, created_at, updated_at) VALUES
(1, 'primecare-core', 'PrimeCare Platform Core', 'https://primecare-core.pages.dev', 'https://primecare-worker-api-gateway.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 'primecare-auth', 'PrimeCare Authentication App', 'https://primecare-auth.pages.dev', 'https://primecare-worker-auth-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(3, 'primecare-client', 'PrimeCare Client Portal App', 'https://primecare-client.pages.dev', 'https://primecare-worker-client-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(4, 'primecare-corporate', 'PrimeCare Corporate Admin App', 'https://primecare-corporate.pages.dev', 'https://primecare-worker-provider-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(5, 'primecare-clinic', 'PrimeCare Clinic Operations App', 'https://primecare-clinic.pages.dev', 'https://primecare-worker-visit-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(6, 'primecare-franchise', 'PrimeCare Franchise Management App', 'https://primecare-franchise.pages.dev', 'https://primecare-worker-franchise-reporting-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(7, 'primecare-governance', 'PrimeCare Compliance & Governance App', 'https://primecare-governance.pages.dev', 'https://primecare-worker-governance-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(8, 'primecare-support', 'PrimeCare Customer Support App', 'https://primecare-support.pages.dev', 'https://primecare-worker-notes-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(9, 'primecare-business-development', 'PrimeCare Business Development App', 'https://primecare-business-development.pages.dev', 'https://primecare-worker-api-gateway.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(10, 'primecare-enterprise-blueprint', 'PrimeCare Enterprise Architecture App', 'https://primecare-enterprise-blueprint.pages.dev', 'https://primecare-worker-governance-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(11, 'primecare-marketing', 'PrimeCare Marketing Campaign App', 'https://primecare-marketing.pages.dev', 'https://primecare-worker-notification-api.itpro-mohammed.workers.dev/api', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- Seeding monorepo backend microservices (Cloudflare Workers URLs)
INSERT OR REPLACE INTO applications (application_id, application_key, application_name, base_url, api_base_url, environment, active, created_at, updated_at) VALUES
(12, 'api-gateway', 'API Gateway', NULL, 'https://primecare-worker-api-gateway.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(13, 'auth-api', 'Authentication API Service', NULL, 'https://primecare-worker-auth-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(14, 'billing-api', 'Billing Ledger API Service', NULL, 'https://primecare-worker-billing-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(15, 'client-api', 'Client Management API Service', NULL, 'https://primecare-worker-client-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(16, 'compliance-api', 'Compliance Audit API Service', NULL, 'https://primecare-worker-compliance-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(17, 'franchise-reporting-api', 'Franchise Analytics API Service', NULL, 'https://primecare-worker-franchise-reporting-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(18, 'governance-api', 'Governance Registry API Service', NULL, 'https://primecare-worker-governance-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(19, 'notes-api', 'Clinical Notes API Service', NULL, 'https://primecare-worker-notes-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(20, 'notification-api', 'Notification Broadcast API Service', NULL, 'https://primecare-worker-notification-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(21, 'provider-api', 'Staff/Provider API Service', NULL, 'https://primecare-worker-provider-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(22, 'scheduling-api', 'Visit Scheduling API Service', NULL, 'https://primecare-worker-scheduling-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(23, 'verification-api', 'Credential Verification API Service', NULL, 'https://primecare-verification-api.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(24, 'visit-api', 'Electronic Visit Verification API Service', NULL, 'https://primecare-worker-visit-api.itpro-mohammed.workers.dev', 'prod', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');
