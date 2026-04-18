# PrimeCare Governance: Reconciliation Log

This document records the output of the 5th layer of the Feature Governance system. When intent, UI, and database code do not cleanly match sequentially, a mismatch is logged here detailing the root cause and the recovery decision.

## Active Discrepancies

*None at this time.*

## Resolved Discrepancies

### LOG-001: Create User Form Data Drift

* **Date:** 2026-04-16
* **Feature:** `user_management.create_user`
* **Mismatch:**
  * **Intent:** The system needs the user's name during invitation.
  * **Code (UI):** `CreateUserForm` captures `firstName` and `lastName`.
  * **Code (DB):** The Prisma `User` schema (`01_platform.prisma`) **does not contain any name columns**. Name fields rest exclusively on `ClientProfile` and `ProviderProfile`.
* **Root Cause:** The UI form was built anticipating a generic platform User model with innate names, whereas the backend architecture utilizes a highly normalized, polymorphic identity structure where the generic `User` table serves strictly as an auth/tenant pivot.
* **Decision:** We must either:
  1. Add a generic `name` string to the `User` model, *or*
  2. Modify the API/Database mutation via `UserService` to instantiate an implicit `ProviderProfile` mapped to the generic `Admin` or `Manager` being invited.
* **Owner:** Engineering Lead
* **Status:** ✅ RESOLVED (Added `firstName` and `lastName` to `User` model in `01_platform.prisma`)

### LOG-002: System Dashboards Physical Drift

* **Date:** 2026-04-16
* **Feature:** Core Routing Dashboards (`view_dashboard`, `navigate_system_dashboard`, etc.)
* **Mismatch:**
  * **Intent:** The system orchestrates 7 multi-role persona dashboards (`system_dashboard`, `cfo_dashboard`, etc.) in the `page_inventory.yaml`.
  * **Code (UI):** None of the 7 highest-level page wrappers existed natively in the Flutter tree.
  * **Code (DB):** N/A (UI mapping issue only).
* **Root Cause:** Phase 1 focused heavily on building data components (atoms) and layouts, but the specific root dashboard aggregators that use the `PageTemplate` were never actually written.
* **Decision:** We used the standard `PageTemplate` enterprise wrapper to scaffold physical generic pages for all 7 intents inside `lib/src/screens/dashboards/` to complete the routing layer and establish feature parity.
* **Owner:** Engineering Lead
* **Status:** ✅ RESOLVED (Dashboards generated and registered into `screens.dart`)

### LOG-003: Verification Hub Telemetry Pipeline

* **Date:** 2026-04-18
* **Feature:** Verification Service Hydration (`ctoVerificationHub`)
* **Mismatch:**
  * **Intent:** The `SystemVerificationViewModel` and `VerificationHub` UI must render real-time database rows and cross-validation status from the independent Edge Worker microservice, bypassing the overloaded core gateway.
  * **Code (UI):** The adapter originally dialed the base API endpoint and expected the old proxy format.
  * **Code (DB):** The standalone `verification-service` worker implements raw PostgreSQL catalog reporting natively.
* **Root Cause:** The architecture pivoted to decouple database observability from the main worker. The Cloudflare Edge worker threw BigInt serialization errors when exporting `pg_stat_user_tables.n_live_tup` natively via Prisma `queryRawUnsafe`.
* **Decision:** Injected a global BigInt serialization normalization directly into the Cloudflare Worker and successfully re-deployed to edge. 
* **Owner:** Engineering Lead
* **Status:** ✅ RESOLVED (Worker deployed. Final Edge API sweep returned `success: true` with 932 aggregated rows across 192 tables. UI validation complete.)
