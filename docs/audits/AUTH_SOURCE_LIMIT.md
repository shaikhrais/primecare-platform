# Source login protection

Governance migration registers 120 attempts / 60 seconds in auth_source_policy. The generated auth-source-policy.json supplies the auth Worker's native Cloudflare Rate Limiting binding. Both gateway aliases route to the same auth Worker, so the limiter is called once, before body parsing, PostgreSQL connection or password hashing. Direct Worker /login is also covered. Logout, identity and health remain available.

Only Cloudflare's CF-Connecting-IP header selects the source; forwarded-for and real-ip headers are ignored. Native Cloudflare ingress is the trust boundary. Same-account/zone Workers must remain trusted and preserve the header; cross-zone Worker requests may share Cloudflare's Worker address. Missing/invalid source or unavailable binding returns generic no-store 503. Denial returns no-store 429 with Retry-After 60. Counter keys are SHA-256 hashes; raw addresses and provider errors are not logged by the limiter. Hashing is pseudonymization, not anonymization.

This supplements PostgreSQL's per-account limits. Native counters are approximate, eventually consistent and local to each Cloudflare location. Shared offices/NAT/proxies share a budget; this is not global DDoS prevention or a substitute for monitoring. Deployment uses namespace 2026092801 for this policy only.

Tests cover permitted/denied sources, IPv6, missing/invalid headers, forwarded-header changes, fail-closed provider errors, logout exemption, direct/gateway paths and generated deployment binding. Local Worker suite: 69 passing tests and TypeScript checks. Production deployment and live verification must be recorded separately.

References: https://developers.cloudflare.com/workers/runtime-apis/bindings/rate-limit/ and https://developers.cloudflare.com/fundamentals/reference/http-headers/
