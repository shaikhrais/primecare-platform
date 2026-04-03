# PrimeCare Domain-Driven Architecture Blueprint

Splitting by **Domain** instead of **Role** is the absolute correct path for a healthcare/logistics platform like PrimeCare. RNs, RMTs, and PSWs are transient actors performing functions across intersecting domains—they track credentials in the Provider service, accept bookings in Scheduling, and document charts in Clinical Docs. If we built an "RN Service," we'd end up duplicating 90% of the platform's logic!

Furthermore, we are launching as a **Modular Monolith** with these exact boundaries, deferring the extraction of high-load services (Scheduling, Billing) until traffic demands it. This avoids premature optimization while guaranteeing future scale.

Here is the fully fleshed-out Microservice Matrix and System Architecture Diagram based on the actual system state as of Phase 8.

## 🏗️ System Architecture Diagram

```mermaid
graph TD
    %% Define Styles
    classDef clientApp fill:#006948,stroke:#fff,stroke-width:2px,color:#fff;
    classDef gateway fill:#002366,stroke:#fff,stroke-width:4px,color:#fff;
    classDef service fill:#eef2f3,stroke:#002366,stroke-width:2px,color:#333;
    classDef infra fill:#f59e0b,stroke:#fff,stroke-width:2px,color:#fff;

    %% Client Layers
    subgraph Clients ["Frontend Portals (Flutter Web/Mobile)"]
        direction LR
        PA[Provider App\nPSW / RN / RMT]:::clientApp
        CA[Client / Family App]:::clientApp
        Admin[Office Admin Portal]:::clientApp
        HQ[Head Office / Franchise Panel]:::clientApp
    end

    %% Gateway Layer
    GW[("🛡️ API Gateway / Reverse Proxy\n(Rate Limiting, Auth Validation)")]:::gateway

    %% Event Bus Layer
    EB{{Pub/Sub EventBus\n(Asynchronous Decoupling)}}:::infra

    %% Core Services (Phase 1)
    subgraph Phase1 ["Phase 1 & 2: Modular Monolith API (/v1/*)"]
        direction TB
        S1[Identity & Access]:::service
        S2[Provider Service]:::service
        S3[Client & Family]:::service
        S6[Scheduling & Dispatch]:::service
        S7[Visit Execution]:::service
        S8[Clinical Documentation]:::service
        S9[Billing & Payroll]:::service
        S12[Communication & Notification]:::service
        
        S4[Intake & Assessment]:::service
        S5[Care Plan]:::service
        S10[Compliance & Credentials]:::service
        S11[Training & Learning]:::service
        S13[Support & Ticketing]:::service
        S14[Franchise & Territory]:::service
        S15[Reporting & Analytics]:::service
    end

    %% Distributed Telemetry
    subgraph Telemetry ["Phase 6: Distributed Analytics Daemon"]
        direction TB
        D1([System Analytics Listener]):::infra
    end

    %% Databases
    DB1[(Global PostgreSQL Database\nShared by all Domains)]:::infra
    RDB[(Redis\nCaching & Sessions)]:::infra
    S3[(R2 Object Storage\nAttachments, Certs)]:::infra

    %% Wiring
    Clients --> |Zero-Touch Dio Abstraction| GW
    
    GW --> S1
    GW --> S2
    GW --> S3
    GW --> S6
    GW --> S7
    GW --> S8
    GW --> S9
    GW --> S12

    GW -.-> S4
    GW -.-> S5
    GW -.-> S10
    GW -.-> S11
    GW -.-> S13
    GW -.-> S14
    GW -.-> S15

    %% Service to Infra connections
    Phase1 --> DB1
    
    S1 --> RDB
    S8 --> S3
    S2 --> S3
    
    %% Event Bus connections
    Phase1 <-->|Zod Validated Payloads| EB
    EB --> D1
```

---

## 📊 Complete Microservice Matrix (Deployed)

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

## Technical Strategy & Deployment Posture (Phase 1-8 Completed)

1. **Logical Separation, Shared Relational Data**: The system is constructed using distinct domain boundary folders (`/src/domains/auth`, `/src/domains/scheduling`, etc.). They share a single deployment container running on Cloudflare Workers and a **single, unified PostgreSQL database**. This avoids premature optimization overhead. Cross-domain logic happens *exclusively* through well-defined global internal event emitters (EventBus), enforcing good habits for when the database is split in the future.

2. **The Layered API Gateway**: All frontend requests (`primecare_v4` Flutter application) hit the unified `/v1` gateway namespace. For example, if an RN checks into a visit, the app hits `/v1/visits/:id/checkin`. The gateway delegates this to the **Visit Execution Module**, which drops a strictly typed `visit.started` Zod payload onto the Event Bus. The **Billing Module** silently listens to this event to begin capturing payable time, completely decoupled from the execution handler.

3. **Flutter Matrix Hydration**: To accommodate 38 different institutional roles on the `/v1` backend, the Flutter routing ecosystem utilizes a centralized *Zero-Touch Dio Abstraction*. High-fidelity glassmorphism UI components inherently listen to generic profile events and hydrate their specific metrics dynamically based on their authentication role index. (Flutter Compiler Status: hardened and explicitly compliant with API specifications).

This fully decentralized internal structure guarantees that when the system scales and routing inevitably becomes the main bottleneck, we can perfectly extract the `Scheduling` or `Reporting` modules into their own clustered containers without modifying a single line of Dart client code.
