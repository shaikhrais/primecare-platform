# Role Playbook: Coordinators & Staff (The Edge Case Handlers)

## The Persona
The `coordinator` and `staff` roles are the manual schedulers and dispatchers of the traditional world. In the PrimeCare Fractal SaaS, their job is fundamentally altered. They no longer schedule shifts; instead, they manage exceptions and edge cases.

## Core Responsibilities & Workflows
1.  **Incident Management:** Responding to `Incident` reports (e.g., A nurse reports a safety risk at a client's home, or a hospital reports a No-Show).
2.  **Manual Overrides:** Intervening when the Clinical Auto-Pilot fails. If a shift is remaining unstaffed for 48 hours, the Coordinator manually overrides the algorithm and forces an assignment to a specific emergency pool nurse.
3.  **Communication:** Monitoring the `MessageThread` objects, responding to urgent SMS/In-App chats from Providers in the field.

## Day-in-the-Life Execution
The Clinical Auto-Pilot handles 95% of the volume. The Coordinator watches a dashboard of the remaining 5%—the "At-Risk" shifts. An alert pops up: *Shift in 2 hours has no accepted offers.* The Coordinator manually surges the pay rate by $10/hr and re-blasts the offer to the network, watching eagerly as a nurse accepts it at the higher rate.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Surge Pricing UI:** The backend supports robust provider rates, but we lack a UI slider for the Coordinator to dynamically "Surge" a specific shift's pay rate in real-time to entice nurses.
*   **Twilio SMS Fallback:** Currently, messaging relies heavily on the web app. Coordinators need a seamless Twilio integration where typing in the web portal sends a physical SMS text to the nurse's phone if they are offline.