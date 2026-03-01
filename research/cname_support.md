# Custom Domain (CNAME) Support Research

## The Challenge
Tenants want to use `care.their-business.com` instead of `their-business.pc.ca`. This requires:
1. **Dynamic SSL**: Generating and renewing certificates for domains we don't own.
2. **Proxy Layer**: Routing traffic from external domains to our multi-tenant worker.

## Solutions

### 1. Cloudflare for Platforms (Recommended)
- **Mechanism**: Use Cloudflare's SSL for SaaS.
- **Pros**: Automated certificate generation (DCV), edge routing, and built-in security.
- **Implementation**:
    - Tenant adds a CNAME: `care.business.com` -> `domains.pc.ca`.
    - We call Cloudflare API to register the hostname.
    - Cloudflare handles SSL issuance.
    - Our Worker reads `c.req.header('Host')` to resolve tenant.

### 2. Reverse Proxy (Nginx/Fly.io)
- **Mechanism**: Run a custom Caddy or Nginx server with "On-Demand TLS".
- **Pros**: Full control, no platform lock-in.
- **Cons**: High maintenance, scaling SSL storage is hard.

## Strategy for PrimeCare
- Use **Cloudflare Custom Hostnames**.
- Update `prisma.middleware.ts` (Already done) to handle any `Host` header.
- Create a `CustomDomain` model in Prisma to map `hostname` -> `tenantId`.
