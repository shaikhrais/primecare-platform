# Stripe Connect Integration Overview

Stripe Connect underpins the entire financial routing of the Fractal SaaS. It allows complex N-party fund routing legally and compliantly.

## The Financial Hierarchy
*   **Platform HQ**: Operates the overarching Stripe Connect Platform instance. Bears ultimate KYC responsibility but touches no actual care funds directly.
*   **Master Franchises (Root Tenants)**: Connect custom or express Stripe Accounts to collect their Master revenue.
*   **Child Agencies**: Connect as sub-accounts under the Master.
*   **Providers**: Connect securely to receive direct transfer payouts to their bank accounts.

All splits are calculated natively through the Connect API at the moment of capture.