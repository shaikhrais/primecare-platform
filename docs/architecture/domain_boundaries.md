# PrimeCare Domain-Driven Architecture Blueprint

## Domain Boundary Definition: Company vs. Tenant

### 🏢 Company (PrimeCare Platform)
*These tasks ensure the "Mall" is running well.*

| Feature | Logic | Data Ownership |
| :--- | :--- | :--- |
| **Tenant Lifecycle** | Registration, Suspension, Billing Tiers | Global Admin |
| **Marketplace Oversight** | Approving listings, Conflict resolution | Global Admin |
| **SLA Monitoring** | System uptime, Latency, Error rates | Global Admin |
| **Network Compliance** | Setting global clinical standards | Global Admin |
| **Aggregated Data** | Industry benchmarks, Burnout trends | Global Admin (Anonymized) |

### 🏥 Tenant (Care Agency)
*These tasks ensure the "Shop" is making sales and delivering care.*

| Feature | Logic | Data Ownership |
| :--- | :--- | :--- |
| **Agency Branding** | Logos, Colors, Custom Domains | Tenant Admin |
| **Staff Management** | Hiring, Payroll, Credentials | Tenant Admin |
| **Client Care** | Care Plans, Visits, Medical Notes | Tenant Admin |
| **Local Revenue** | Client Invoicing, Stripe Payouts | Tenant Admin |
| **Operational AI** | Clinical Assistant, Local Insights | Tenant Admin |

### 🛡️ The Firewall
- **Prisma Middlewares**: Rejects any cross-tenant queries unless `isSuperAdmin`.
- **UI Context**: The `ThemeProvider` and `AuthContext` must explicitly detect if the user is in "Platform Mode" or "Agency Mode".

---

## 📊 Domain-Driven Microservice Matrix (Deployed `/v1`)

Splitting by **Domain** instead of **Role** is the absolute correct path for a healthcare/logistics platform like PrimeCare. We are launching as a **Modular Monolith** with these exact boundaries, deferring the extraction of high-load services until traffic demands it.

| Domain Service | Core Responsibilities | APIs | Key Events (Pub/Sub) | Primary Roles | Status |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **Identity & Access** | Authentication, RBAC, session management. | `/auth/*` | `user.login`, `role.assigned` | System-wide | **LIVE** |
| **Provider Mgmt** | Clinician profiles, skills, availability matching. | `/providers/*` | `provider.created`, `provider.updated` | HR, Ops, Scheduler | **LIVE** |
| **Client & Family** | EHR profiles, addresses, emergency contacts. | `/clients/*` | `client.created`, `client.flagged` | Intake, Providers | **LIVE** |
| **Scheduling** | Shifts, routing, time conflict detection. | `/schedules/*` | `visit.booked`, `shift.cancelled` | Scheduler, Ops | **LIVE** |
| **Visit Execution** | GPS check-in/out, task execution, incident flags. | `/visits/*` | `visit.started`, `visit.completed` | PSW, RN, RMT | **LIVE** |
| **Clinical Docs** | Legal charting (SOAP), versioning, audit trails. | `/notes/*` | `note.signed`, `note.amended` | Providers, QA | **LIVE** |
| **Billing & Payroll** | Client invoicing, claims, provider payout rules. | `/billing/*` | `invoice.generated`, `payroll.run` | CFO, Billing Admin | **LIVE** |
| **Notifications** | Universal alerts (Email, SMS, Push). | `/notifications/*` | *Subscriber to all alerts* | System-wide | **LIVE** |
| **Intake & Assess** | New case pipelines, initial document routing. | `/intake/*` | `case.opened`, `assessment.done` | Intake, RN | **LIVE** |
| **Care Plans** | Discipline-logic, reassessment tracking. | `/care-plans/*` | `plan.updated`, `goal.met` | RN, RPN, RMT, PSW | **LIVE** |
| **Compliance** | License expiries, police checks. | `/compliance/*` | `cert.expiring`, `license.revoked`| Compliance Mgr | **LIVE** |
| **Training** | Onboarding modules, role-based quizzes. | `/training/*` | `course.completed` | Training Dir, HR | **LIVE** |
| **Support / Ticket** | Issue escalation, refunds, SLAs, complaints. | `/support/*` | `ticket.escalated`, `ticket.closed` | Support, Clients | **LIVE** |
| **Franchise & Territory**| Multi-location pricing, service radii tracking. | `/franchises/*` | `territory.updated` | CEO, GM, Owners | **LIVE** |
| **Reporting** | Financial forecasting, clinical outcome trends. | `/reports/*` | *Reader of Audit/Events* | Global Leadership | **LIVE** |

---

## 🏗️ Technical Strategy & Deployment Posture

1. **Logical Separation, Shared Relational Data**: The `.prisma` schema has been aggregated perfectly into explicit logical domains. The system currently executes inside a single deployment container running on Cloudflare Workers and a **single, unified PostgreSQL database**. Cross-domain logic happens *exclusively* through well-defined global internal event emitters (`eventBus.emit()`).
2. **The Layered API Gateway**: All frontend requests (`primecare_v4` Flutter application) hit the unified `/v1` gateway namespace. The gateway delegates this to the localized handlers which process transactions asynchronously.
3. **Flutter Matrix Hydration**: To accommodate 38 different institutional roles on the `/v1` backend, the Flutter routing ecosystem utilizes a centralized *Zero-Touch Dio Abstraction*. High-fidelity UI components inherently bypass hardcoding to dynamically pull generic domains.
