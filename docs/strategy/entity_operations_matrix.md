# PrimeCare Operations, Screens & Crisis Protocols Matrix

This document defines the PrimeCare Ecosystem. For every entity, it lists their **Core Responsibilities**, the exact **App Screens** they require to execute those duties, and the **Crisis Protocols (Situational Measures)** defining what happens when systems or operations fail.

---

## 1. Coordinator (Dispatch & Logistics)
### Responsibilities
The heartbeat of the platform. Coordinators ensure that every Client request is physically matched with an available Provider.
### Required App Screens
- **The Jane Matrix (`coordinator_jane_matrix_screen.dart`)**: A 2D Drag-and-Drop scheduler handling thousands of shift blocks simultaneously.
- **Geospatial Dispatch (`coordinator_live_map_screen.dart`)**: Live map visualizing unstaffed regions and active caregiver GPS blips.
- **Surge Engine (`coordinator_home_screen.dart`)**: A toggle interface for attaching emergency `+1.5x` Payroll multipliers to failing shifts.

### Crisis Protocols (When Things Break)
- **Scenario:** *A critical shift is starting in 30 minutes, but 0 workers have accepted it.*
  - **Measure:** The Coordinator opens the **Surge Engine** and triggers an emergency +1.5x override. A massive red push notification alerts all idle Field Workers locally. 
- **Scenario:** *A provider cancels a shift exactly as it is supposed to begin.*
  - **Measure:** The Jane Matrix flashes the shift RED. The Coordinator uses the **Geospatial Map** to locate the closest idle worker and issues a "Direct Commandeer" assignment, bypassing the normal algorithm.

---

## 2. Personal Support Worker (PSW / Field Operations)
### Responsibilities
The primary field workers performing physical care, verifying attendance (EVV), and charting daily activities.
### Required App Screens
- **Matchmaking Hub (`psw_home_screen.dart`)**: Infinite scrolling feed of localized, available shifts displaying distance and payout.
- **Live Vector Tracking (`psw_live_visit_screen.dart`)**: The execution terminal embedding the GPS Check-In, Shift Timers, and ADL (Activities of Daily Living) checklists.
- **Crisis Trigger (`psw_incident_wizard_screen.dart`)**: The massive Red Native SOS button.

### Crisis Protocols (When Things Break)
- **Scenario:** *PSW arrives at a remote rural house and has Zero Cellular/Wi-Fi to clock in.*
  - **Measure:** The App immediately evaluates the hardware state and renders an Orange **Offline Indicator (`offline_banner.dart`)**. The `SQLite Local Buffer` intercepts the checkout payload physically onto the device's SSD. The PSW completes the shift normally. When the PSW hits 4G on the drive home, the Cloudflare Sync loop flushes the backlog natively.
- **Scenario:** *PSW arrives and the patient has suffered a severe physical injury.*
  - **Measure:** PSW opens the **Crisis Trigger**. The EVV shift clock halts automatically, and the system opens a high-priority camera interface for evidence. The telemetry is bypassed directly to the RN Hub, ignoring the Coordinator.

---

## 3. Registered Nurse (RN / Medical Oversight)
### Responsibilities
Clinical governance. RNs never drive to physical shifts, but digitally oversee hundreds of patients automatically to absorb medical liability.
### Required App Screens
- **Clinical Hub (`rn_home_screen.dart`)**: A kanban-style queue consuming the SOS/Incident alerts sent by PSWs in real-time.
- **Telehealth Video Array (`psw_live_video_triage_screen.dart`)**: Picture-in-picture WebRTC node establishing peer-to-peer visual feeds with the field worker.
- **Patient 360 Records (`rn_patients_screen.dart`)**: PDF Care Plans, Vitals histories, and S.O.A.P Audit logs.

### Crisis Protocols (When Things Break)
- **Scenario:** *A PSW SOS Incident drops onto the Clinical Hub stating a patient refuses medication.*
  - **Measure:** The RN clicks the Incident and instantly launches the **Telehealth WebRTC array**. The RN physically evaluates the patient over the smartphone camera. The RN edits the **Patient 360 Record** and digitally alters the Care Plan to mandate alternative treatments for tomorrow's shift natively.

---

## 4. Manager (Local Operations & HR)
### Responsibilities
Overseeing regional Node health. They ensure everyone is legally compliant and Payroll stays under predefined EBITDA safety margins.
### Required App Screens
- **Executive Console (`manager_home_screen.dart`)**: Dense arrays outputting active pending invoices and total active payroll liabilities.
- **Compliance Directory (`manager_directory_screen.dart`)**: Visual matrix rendering Expired First-Aid certificates or lapsed Licenses in Red.

### Crisis Protocols (When Things Break)
- **Scenario:** *15 Caregiver CMTO Licenses expire at midnight simultaneously.*
  - **Measure:** The **Compliance Directory** algorithmically suspends their field access. When the Caregivers wake up to claim shifts on the `psw_home_screen.dart`, their apps are locked on an Upload Modal. The Manager monitors the Directory waiting for the digital PDF uploads to click "Approve" and unfreeze the fleet natively.

---

## 5. Scrum Master (System Diagnostics)
### Responsibilities
The technical guardian. They watch the bare-metal servers and ensure the App doesn't disintegrate under extreme load.
### Required App Screens
- **Diagnostic Terminal (`scrum_master_diagnostic_screen.dart`)**: Pure telemetry displaying raw Cloudflare Worker API latencies and SQL connection pools.
- **WAF Security Hub (`scrum_master_security_screen.dart`)**: Real-time traffic visualization tracking potential DDoS attacks natively natively.

### Crisis Protocols (When Things Break)
- **Scenario:** *Coordinator requests a multi-day Jane Matrix calculation, throwing the PostgreSQL Database into a Deadlock. No one can hit the API.*
  - **Measure:** The Scrum Master accesses the **Diagnostic Terminal**, visually isolates the hanging database fragment, and hits the "Hot Recover / Flush Cache" override natively, destroying the deadlocked queries and allowing the 250 Field Workers to instantly resume Shift Checkouts.

---

## 6. General Manager (GM / Executive Growth)
### Responsibilities
Macro-scale business development. 
### Required App Screens
- **Financial Growth Analytics (`gm_cost_reduction_screen.dart`)**: Visualizes CAC (Customer Acquisition Cost) vs. Net Margin.
- **Franchise Spawner (`gm_expansion_wizard.dart`)**: The 5-step logic tree defining zip-code boundaries for net-new Regional Hubs.

### Crisis Protocols (When Things Break)
- **Scenario:** *Profit margin in the Toronto Node crashes below 20% due to Coordinators continuously abusing the Surge Multiplier.*
  - **Measure:** The GM identifies the leakage actively on the **Financial Growth Analytics** home. The GM enforces a hard digital limit on the Coordinator Hub natively, restricting Surge Multipliers to a maximum of 4 usages per week, mathematically forcing the region back into profitability.
