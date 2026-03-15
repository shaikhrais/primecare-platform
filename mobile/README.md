# Mobile Applications

> **Status:** Planned — not yet implemented.

The PrimeCare mobile apps are planned as React Native (Expo) applications for two user roles:

- **PrimeCareClient** — Client-facing mobile app for booking, feedback, and care plan access.
- **PrimeCarePsw** — PSW-facing mobile app for schedule, check-in/out, mileage tracking.

## Architecture Notes

- Will share business logic via `packages/shared` (registries, types, schemas).
- The `mobile/instrumentation/` directory contains future telemetry scaffolding.
- Mobile builds are `.gitignore`'d under `apps/PrimeCareClient/` and `apps/PrimeCarePsw/`.

## Getting Started

Once development begins, initialize with:

```bash
npx create-expo-app@latest apps/PrimeCareClient
npx create-expo-app@latest apps/PrimeCarePsw
```
