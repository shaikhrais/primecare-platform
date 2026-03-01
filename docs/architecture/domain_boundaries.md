# Domain Boundary Definition: Company vs. Tenant

## 🏢 Company (PrimeCare Platform)
*These tasks ensure the "Mall" is running well.*

| Feature | Logic | Data Ownership |
| :--- | :--- | :--- |
| **Tenant Lifecycle** | Registration, Suspension, Billing Tiers | Global Admin |
| **Marketplace Oversight** | Approving listings, Conflict resolution | Global Admin |
| **SLA Monitoring** | System uptime, Latency, Error rates | Global Admin |
| **Network Compliance** | Setting global clinical standards | Global Admin |
| **Aggregated Data** | Industry benchmarks, Burnout trends | Global Admin (Anonymized) |

## 🏥 Tenant (Care Agency)
*These tasks ensure the "Shop" is making sales and delivering care.*

| Feature | Logic | Data Ownership |
| :--- | :--- | :--- |
| **Agency Branding** | Logos, Colors, Custom Domains | Tenant Admin |
| **Staff Management** | Hiring, Payroll, Credentials | Tenant Admin |
| **Client Care** | Care Plans, Visits, Medical Notes | Tenant Admin |
| **Local Revenue** | Client Invoicing, Stripe Payouts | Tenant Admin |
| **Operational AI** | Clinical Assistant, Local Insights | Tenant Admin |

## 🛡️ The Firewall
- **Prisma Middlewares**: Rejects any cross-tenant queries unless `isSuperAdmin`.
- **UI Context**: The `ThemeProvider` and `AuthContext` must explicitly detect if the user is in "Platform Mode" or "Agency Mode".
