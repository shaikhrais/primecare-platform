# Role Playbook: Super Admin (Platform HQ)

## The Persona
The `super_admin` role is restricted to PrimeCare's internal headquarters team. This role represents the architects and governors of the Fractal SaaS network. They are entirely removed from clinical care and local staffing operations.

## Core Responsibilities & Workflows
1.  **Network Governance:** Utilizing the Risk Surveillance Engine to monitor global compliance incidents across all Master Franchises.
2.  **Infrastructure Provisioning:** Onboarding new Master Franchises (Root Tenants) and setting their subscription tiers.
3.  **Financial Rail Oversight:** Managing the global Stripe Connect platform settings and tracking the fractional tech-toll revenue streams.

## Day-in-the-Life Execution
A Super Admin logs into the system not to assign shifts, but to monitor algorithmic health. If a Master Franchise in Texas experiences a catastrophic failure in compliance (e.g., attempting to dispatch 50 unverified nurses), the Super Admin dashboard flashes red. The Super Admin executes a "Global Quarantine" command, temporarily severing the Master Franchise's Stripe connection and disabling their Auto-Pilot.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Global Financial Dashboard:** We currently lack a Super Admin-only dashboard that aggregates the fractional revenue (the 1.5% tech toll) flowing to HQ.
*   **Tenant Sandboxing Mechanism:** While Risk Surveillance exists, the physical button to "Quarantine a Tenant" and isolate them from the Auto-Pilot requires database intervention rather than a UI toggle.
*   **System-Wide Audit Logs:** A unified UI to track *every* action taken by a Master Franchise admin across the system for legal compliance.