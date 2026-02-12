# Unified Project Structure: PrimeCare Ecosystem

This blueprint defines the folder structure for a unified codebase supporting Web (Admin/Manager/RN) and Mobile (PSW/Client) platforms using a monorepo approach.

```text
primecare-platform/
├── apps/
│   ├── worker-api/           # Hono + Prisma Backend
│   ├── web-portal/           # Unified React Web App (Admin, Manager, Staff, RN)
│   │   ├── src/
│   │   │   ├── components/   # Shared UI (PC-Card, DataTable, etc.)
│   │   │   ├── layouts/      # Role-based layouts (AdminLayout, RNLayout)
│   │   │   ├── pages/        # Role-scoped page directories
│   │   │   └── hooks/        # Auth and Data fetching hooks
│   ├── mobile-app/           # React Native App (PSW, Client)
│   │   ├── src/
│   │   │   ├── screens/      # ShiftLog, VisitDetails, IncidentReport
│   │   │   └── navigation/   # Role-based navigation stacks
│   └── cypress-test/         # E2E RBAC & Workflow Tests
├── packages/
│   ├── shared/               # Registry, Types, Validations (Zod schemas)
│   ├── design-system/        # CSS Variables, Premium Components
│   └── hooks/                # Cross-platform logic (e.g., useGeolocation)
├── docs/                     # Governance, Master Matrix, API Docs
└── cloudflare/               # Workers-specific config (Durable Objects)
```

## Key Technical Design
1. **Shared Validations**: Data entry forms in both Web and Mobile use the same Zod schemas from `packages/shared`.
2. **Unified Design System**: CSS variables and atomic components are published as a local package to ensure "Premium Aesthetics" across all portals.
3. **Role-Based Navigation**: Mobile app uses dynamic navigation stacks based on the authenticated user's `Role`.
4. **Offline Sync**: Mobile-specific logic for `Daily Entries` to allow draft saving during low-connectivity home visits.
