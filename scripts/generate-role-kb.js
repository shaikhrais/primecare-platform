const fs = require('fs');
const path = require('path');

const publicDir = path.join(__dirname, '..', 'apps', 'web-admin', 'public', 'knowledge-base');
const docsDir = path.join(__dirname, '..', 'docs', 'knowledge-base');

const roleArticles = {
    'role-super-admin': `# Role Playbook: Super Admin (Platform HQ)

## The Persona
The \`super_admin\` role is restricted to PrimeCare's internal headquarters team. This role represents the architects and governors of the Fractal SaaS network. They are entirely removed from clinical care and local staffing operations.

## Core Responsibilities & Workflows
1.  **Network Governance:** Utilizing the Risk Surveillance Engine to monitor global compliance incidents across all Master Franchises.
2.  **Infrastructure Provisioning:** Onboarding new Master Franchises (Root Tenants) and setting their subscription tiers.
3.  **Financial Rail Oversight:** Managing the global Stripe Connect platform settings and tracking the fractional tech-toll revenue streams.

## Day-in-the-Life Execution
A Super Admin logs into the system not to assign shifts, but to monitor algorithmic health. If a Master Franchise in Texas experiences a catastrophic failure in compliance (e.g., attempting to dispatch 50 unverified nurses), the Super Admin dashboard flashes red. The Super Admin executes a "Global Quarantine" command, temporarily severing the Master Franchise's Stripe connection and disabling their Auto-Pilot.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Global Financial Dashboard:** We currently lack a Super Admin-only dashboard that aggregates the fractional revenue (the 1.5% tech toll) flowing to HQ.
*   **Tenant Sandboxing Mechanism:** While Risk Surveillance exists, the physical button to "Quarantine a Tenant" and isolate them from the Auto-Pilot requires database intervention rather than a UI toggle.
*   **System-Wide Audit Logs:** A unified UI to track *every* action taken by a Master Franchise admin across the system for legal compliance.`,

    'role-master-admin': `# Role Playbook: Master Franchise Admin (Regional/Admin)

## The Persona
The \`admin\` and \`regional_manager\` roles represent the ultimate authorities of a franchised territory. They are the "Empty Builders". They buy access to PrimeCare to operate their own vast networks of sub-agencies.

## Core Responsibilities & Workflows
1.  **Territory Expansion:** Spawning new Child Tenants through the Reseller Hub.
2.  **White-Labeling:** Configuring the \`brandingConfig\` (logos, hex colors, custom domains) for their territory.
3.  **Hospital Contract Operations:** Securing massive B2B hospital contracts and feeding the demand into the top of the automated routing funnel.
4.  **Private Resource Distribution:** Creating Marketplace Listings (proprietary training, emergency pools) to sell to their sub-agencies.

## Day-in-the-Life Execution
The Master Admin spends their day in the Reseller Hub. They just signed a local RN who wants to run an agency. The Admin clicks "Spawn Child Tenant", provisions a new database partition, sets a 5% margin toll, and hands the keys to the RN. Later, they review the Master Financial Dashboard to see the aggregated passive revenue flowing up from all 50 of their Child Agencies.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Automated Contract Ingestion:** Currently, hospital demand must be manually entered as "Bookings" or "Visits". We need an EDI/HL7 standard ingestion pipeline to absorb a hospital's Excel/CSV shift dumps automatically.
*   **Cross-Tenant Analytics:** Master Admins need a dedicated "heat map" UI to see exactly which Child Agencies are performing well and which are failing to fill shifts, mapped geographically.`,

    'role-agency-managers': `# Role Playbook: Child Agency Managers (Ops, HR, Clinical, Finance)

## The Persona
This is the operational leadership of the local Child Tenant. The schema breaks this down into granular functions: \`operations_manager\`, \`hr_manager\`, \`clinical_manager\`, \`finance_manager\`, and \`recruiting_manager\`. They run the day-to-day business.

## Core Responsibilities & Workflows
*   **Recruiting Manager:** Sources new nurses locally, guiding them to sign up on the portal.
*   **HR / Compliance Manager:** Reviews uploaded \`PswDocument\` files (licenses, TB tests). They execute the "Verify" command, which unlocks the nurse for algorithm matchmaking.
*   **Clinical Manager:** Reviews \`DailyEntry\` forms and ADL (Activities of Daily Living) data to ensure care quality.
*   **Finance Manager:** Reviews submitted \`Timesheet\` data and approves them for final Stripe Instant Settlement, managing the agency's margin spread.

## Day-in-the-Life Execution
The HR Manager logs in on a Monday morning. They have a queue of 15 pending document uploads from new nurses. They review the PDFs, checking expiration dates, and click "Approve" on 12 of them. These 12 nurses instantly become eligible for Auto-Pilot shifts. The Finance manager logs in on Friday to review disputed timesheets where a nurse's GPS check-out didn't match the hospital's reported hours.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Automated OCR Verification:** HR Managers currently have to manually read the PDF uploads. We need to integrate an OCR tool (like Amazon Textract) to automatically read license dates and auto-verify documents.
*   **Granular RBAC UI Check:** While the backend has RBAC (Role-Based Access Control) defined, the frontend UI doesn't visually hide all irrelevant tabs perfectly for sub-manager roles yet. For instance, an HR Manager shouldn't see the Financial margin splits.
*   **Dispute Resolution Hub:** A dedicated UI interface for the Finance Manager to communicate with a hospital when a shift duration is disputed.`,

    'role-coordinators': `# Role Playbook: Coordinators & Staff (The Edge Case Handlers)

## The Persona
The \`coordinator\` and \`staff\` roles are the manual schedulers and dispatchers of the traditional world. In the PrimeCare Fractal SaaS, their job is fundamentally altered. They no longer schedule shifts; instead, they manage exceptions and edge cases.

## Core Responsibilities & Workflows
1.  **Incident Management:** Responding to \`Incident\` reports (e.g., A nurse reports a safety risk at a client's home, or a hospital reports a No-Show).
2.  **Manual Overrides:** Intervening when the Clinical Auto-Pilot fails. If a shift is remaining unstaffed for 48 hours, the Coordinator manually overrides the algorithm and forces an assignment to a specific emergency pool nurse.
3.  **Communication:** Monitoring the \`MessageThread\` objects, responding to urgent SMS/In-App chats from Providers in the field.

## Day-in-the-Life Execution
The Clinical Auto-Pilot handles 95% of the volume. The Coordinator watches a dashboard of the remaining 5%—the "At-Risk" shifts. An alert pops up: *Shift in 2 hours has no accepted offers.* The Coordinator manually surges the pay rate by $10/hr and re-blasts the offer to the network, watching eagerly as a nurse accepts it at the higher rate.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Surge Pricing UI:** The backend supports robust provider rates, but we lack a UI slider for the Coordinator to dynamically "Surge" a specific shift's pay rate in real-time to entice nurses.
*   **Twilio SMS Fallback:** Currently, messaging relies heavily on the web app. Coordinators need a seamless Twilio integration where typing in the web portal sends a physical SMS text to the nurse's phone if they are offline.`,

    'role-providers': `# Role Playbook: Healthcare Providers (RN, PSW, RMT, RPT)

## The Persona
The frontline labor force. This includes Registered Nurses (\`rn\`), Personal Support Workers (\`psw\`), Registered Massage Therapists (\`rmt\`), Physios (\`rpt\`), etc. They are the sovereign individuals executing the care.

## Core Responsibilities & Workflows
1.  **Credential Maintenance:** Keeping their W3C decentralized digital wallet and \`PswDocument\` records active and unexpired.
2.  **Availability Broadcasting:** Managing their \`PswAvailability\` blocks to tell the algorithms exactly when they are willing to work.
3.  **Algorithmic Matchmaking:** Receiving push notifications for Auto-Pilot shifts, reviewing the pay rate and distance, and accepting them.
4.  **Care Execution & Check-In:** Navigating to the client/hospital, triggering the GPS \`VisitCheckEvent\` to clock in, performing care, logging \`DailyEntry\` data, and checking out.

## Day-in-the-Life Execution
Nurse Jane finishes her day job at a hospital. She opens the PrimeCare app and sets her availability to "Active" for the next 4 hours. Within 10 minutes, the Clinical Auto-Pilot sends her an urgent, high-paying shift for a long-term care facility 5 miles away. She taps "Accept", drives there, hits "GPS Check-In", works for 3 hours, and hits "Check-Out". Thirty minutes later, $180 is Instantly Settled to her Stripe-connected debit card.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Native iOS/Android App:** The current platform is a highly responsive web application (PWA). Providers need a native mobile wrapper (React Native / Expo) to leverage background GPS tracking and proper native push notifications.
*   **Shift Bidding UI:** Currently, the Auto-Pilot offers a fixed rate. We are missing a "Shift Bidding" interface where providers can counter-offer (e.g., "I will take this emergency shift, but for $20 more").
*   **W3C DID Wallet Integration:** The concept of portable sovereign data exists in the business model, but the actual cryptographic W3C Decentralized Identifier wallet integration is missing from the Provider's profile UI.`,

    'role-clients': `# Role Playbook: Clients (Patients & Facilities)

## The Persona
The \`client\` role can represent two distinct entities depending on the Master Franchise's B2B model: 
1. An individual patient receiving home-care.
2. An institutional facility (like a Hospital Ward Manager) acting as a client requesting bulk labor.

## Core Responsibilities & Workflows
1.  **Demand Generation:** Creating \`Booking\` records to request care visits for specific dates and service types.
2.  **Care Monitoring:** Viewing the status of \`Visit\` objects, seeing when a provider is assigned, en route, and completed.
3.  **Financial Settlement:** Having their credit card or ACH account automatically charged by Stripe when an \`Invoice\` is pushed to "Paid" via the instant settlement loop.

## Day-in-the-Life Execution
A Ward Manager at an institutional client realizes they are short two nurses for the night shift. They log into their white-labeled portal, create a new "Booking" for two RNs from 7 PM to 7 AM, and set the priority to "Urgent". They watch the portal in real-time as the Master Franchise's Auto-Pilot finds and assigns two nurses. At 7 PM, the manager sees the GPS status flip to "Arrived".

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Institutional Client Portal UI:** We have a general client profile, but we lack a specialized, heavy-duty B2B "Facility Portal" geared specifically toward hospital ward managers who need to bulk-order 50 shifts at a time rather than 1.
*   **FHIR/HL7 Care Plan Viewer:** The \`client\` portal needs a standardized FHIR viewer so institutional clients can integrate the clinical notes generated by the visiting nurses directly back into their Epic/Cerner mainframes.
*   **Family Oversight Hub:** For individual home-care clients, there is a missing "Family Hub" feature where a client can securely grant read-only access to their adult children to monitor care events and timesheets.`
};

for (const [filename, content] of Object.entries(roleArticles)) {
    fs.writeFileSync(path.join(publicDir, filename + '.md'), content);
    fs.writeFileSync(path.join(docsDir, filename.replace(/-/g, '_') + '.md'), content);
    console.log(`Wrote ${filename}.md`);
}
