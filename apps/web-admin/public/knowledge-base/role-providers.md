# Role Playbook: Healthcare Providers (RN, PSW, RMT, RPT)

## The Persona
The frontline labor force. This includes Registered Nurses (`rn`), Personal Support Workers (`psw`), Registered Massage Therapists (`rmt`), Physios (`rpt`), etc. They are the sovereign individuals executing the care.

## Core Responsibilities & Workflows
1.  **Credential Maintenance:** Keeping their W3C decentralized digital wallet and `PswDocument` records active and unexpired.
2.  **Availability Broadcasting:** Managing their `PswAvailability` blocks to tell the algorithms exactly when they are willing to work.
3.  **Algorithmic Matchmaking:** Receiving push notifications for Auto-Pilot shifts, reviewing the pay rate and distance, and accepting them.
4.  **Care Execution & Check-In:** Navigating to the client/hospital, triggering the GPS `VisitCheckEvent` to clock in, performing care, logging `DailyEntry` data, and checking out.

## Day-in-the-Life Execution
Nurse Jane finishes her day job at a hospital. She opens the PrimeCare app and sets her availability to "Active" for the next 4 hours. Within 10 minutes, the Clinical Auto-Pilot sends her an urgent, high-paying shift for a long-term care facility 5 miles away. She taps "Accept", drives there, hits "GPS Check-In", works for 3 hours, and hits "Check-Out". Thirty minutes later, $180 is Instantly Settled to her Stripe-connected debit card.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Native iOS/Android App:** The current platform is a highly responsive web application (PWA). Providers need a native mobile wrapper (React Native / Expo) to leverage background GPS tracking and proper native push notifications.
*   **Shift Bidding UI:** Currently, the Auto-Pilot offers a fixed rate. We are missing a "Shift Bidding" interface where providers can counter-offer (e.g., "I will take this emergency shift, but for $20 more").
*   **W3C DID Wallet Integration:** The concept of portable sovereign data exists in the business model, but the actual cryptographic W3C Decentralized Identifier wallet integration is missing from the Provider's profile UI.