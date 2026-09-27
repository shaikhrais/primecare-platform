# PrimeCare Role-Wise Task & Flow Registry

This registry maps out the overarching workflows, tasks, and system interactions for all 38 roles within the PrimeCare platform. It dictates exactly *how* different user personas interact with the platform day-to-day.

---

## 1. Corporate Leadership & Governance (C-Suite)
**Roles:** CEO, COO, CFO, CTO, Compliance Manager, Training Director.
**Primary Flow:** Executive oversight, macroscopic reporting, and strategic decision-making.
**Tasks & User Actions:**
- **CEO**: Logs in to view the `CeoEnterpriseOverviewScreen`. Navigates to `CeoGrowthPipeline` to approve territory growth or views `CeoAlertsAndRisks` to manage high-level institutional blockers spanning all regions. (Strategic level reporting, read-heavy with approval mutations).
- **COO**: Uses the `CooBranchOperationsScreen` and `CooSchedulingHealthScreen` to identify service delivery bottlenecks. Evaluates staffing efficiencies across franchises and performs corrective scheduling interventions.
- **CFO**: Accesses the `CfoFinancialOverviewScreen`. Interacts with `CfoTaxAndRemittance` to ensure HST/GST/Tax thresholds are met and triggers broad-system ledger reconciliations across franchise payments & claims.
- **CTO**: Monitors the generic infrastructure and access logs via `CtoSystemHealthScreen` and `CtoApiMonitoringScreen`. Adjusts platform feature flags directly impacting downstream users.
- **Compliance Manager**: Reviews `ComplianceManagerComplianceCasesScreen` to audit internal incident reports. Follows up on expired licenses using `ComplianceManagerCredentialTrackingScreen`.
- **Training Director**: Creates global training configurations via `TrainingProgramsScreen` and issues certifications using the `TrainerAssignmentsScreen`.

## 2. Franchise Level Administration
**Roles:** Franchise Owner, Operations Manager, Scheduler, Billing Admin, HR.
**Primary Flow:** localized daily operations, staffing, scheduling, and billing for a specific franchise location.
**Tasks & User Actions:**
- **Franchise Owner**: Uses the `FranchiseOwnerDashboard` to monitor net financial snapshots for the branch, managing client intake conversions and viewing localized compliance standings.
- **Operations Manager**: Resolves on-the-ground issues generated during shifts natively on the `OperationsManagerIssuesScreen` and reviews `DailyOperationsScreen` to coordinate staff attendance discrepancies in real-time.
- **Scheduler Coordinator**: Resolves shift requests in the `BookingRequestsScreen`, assigns personnel via `AssignmentsScreen`, and resolves overlap collisions using the `ConflictsScreen`.
- **Billing Admin**: Manages direct invoice generation, refunds, and payroll processing in the `AdminInvoicesScreen` and `AdminReconciliationScreen`. Navigates to the platform settings to execute **SaaS Subscription Upgrades** using validated promo codes.
- **HR Manager**: Sources new caregivers, tracks the `InterviewsScreen`, issues formal letters over the `OffersScreen`, and transitions candidates through the `OnboardingScreen` into active staff members.

## 3. Business Development & Expansion
**Roles:** Regional BDM, Franchise Sales Manager, Partnership Manager, Territory Expansion Manager.
**Primary Flow:** Sourcing, acquiring, and onboarding new partners, franchises, and regional territories.
**Tasks & User Actions:**
- **Territory Expansion Manager**: Views the mapping data in `TerritoryMapScreen`, researches demographic heatmaps in `DemographicsScreen`, and drafts formal business expansions in `ForecastScreen`.
- **Franchise Sales Manager**: Tracks new franchise prospects via `FranchiseSalesManagerPipelineScreen`, triggers automated discovery calls, and finalizes electronic contracts using `ContractsScreen`.
- **Regional BDM (Business Development Manager)**: Synchronizes leads, establishes partner tasks in `TasksScreen`, and tracks high-value regional closures via the `DealTrackerScreen`.

## 4. Marketing & Outreach
**Roles:** Head of Marketing, Local Marketing Manager, Community Outreach, Territory Sales Manager.
**Primary Flow:** Brand propagation, lead generation, funnel tracking, and localized community event coordination.
**Tasks & User Actions:**
- **Head of Marketing**: Synthesizes enterprise-wide `FunnelAnalyticsScreen` metrics and approves multi-region media on the `ContentApprovalScreen`.
- **Local Marketing Manager**: Operates their `LocalContentCalendarScreen` to schedule local branch advertisements and optimizes branch advertisement allocations via `LocalBudgetScreen`.
- **Community Outreach**: Coordinates grass-roots `ProgramsScreen`, manages `VolunteersScreen`, and sets up external `EventsScreen` within local geographic municipalities.
- **Territory Sales Manager**: Follows up on B2B client conversions in `TerritoryConversionsScreen` and conducts on-the-ground territory performance reviews.

## 5. Customer Support & Quality Assurance
**Roles:** Customer Support, Intake Coordinator, QA, Training Coordinator.
**Primary Flow:** Resolving active client issues, verifying inbound care requests, and ensuring adherence to care standards.
**Tasks & User Actions:**
- **Customer Support**: Uses the `TicketsView` to respond dynamically to patient inquiries and flags severe anomalies to higher-up branches using the `EscalationsScreen`.
- **Intake Coordinator**: Checks incoming family requests on the `NewIntakesScreen`, validates financial and geographic `EligibilityScreen`, and structures formal intake documentation.
- **Quality Assurance**: Evaluates caregiver physical audits on `AuditsScreen`, reviews subjective client complaints on `ComplaintsScreen`, and manages ongoing `ScorecardsScreen`.
- **Training Coordinator (Branch)**: Manages localized caregiver accreditations via `CoursesScreen` and tracks progress logic using `ProgressScreen`.

## 6. Clinical & Direct Care Delivery
**Roles:** Clinics, Personal Support Workers (PSW), Nurses.
**Primary Flow:** Real-time patient interaction, shift tracking, care plan execution, and clinical logging.
**Tasks & User Actions:**
- **PSW / Caregiver**: Logs into their mobile-hybrid interface. Selects `ClinicMyShiftsScreen` to view daily rosters. Taps into a specific client utilizing `ClinicCheckInOutScreen` (leveraging GPS coordinates). Follows the procedural breakdown in `ClinicCarePlanScreen` and files end-of-shift `ClinicDailyNotesScreen`.
- **Incident Reporting**: Any active care anomalies are natively submitted by the PSW into the `ClinicIncidentReportScreen` which automatically maps back up to the QA and Operations dashboards.

## 7. Client & Family Portals
**Roles:** Client (Patient), Family Member.
**Primary Flow:** Empowering patients and their guardians to request care, view schedules, and handle direct payments.
**Tasks & User Actions:**
- **Client**: Uses the specific portal to asynchronously book appointments natively on `BookAppointmentView`, processes recurring ledger invoices via `ClientPaymentsScreen`, and reviews historical treatments in `TreatmentHistoryScreen`.
- **Family Member**: Logs into the proxy portal mapped to their dependent. Tracks caregiver arrival ETAs on `LovedOneScheduleScreen`, requests updates dynamically through `CareUpdatesView`, and handles primary financial proxy payments via `FamilyBillingScreen`.

---

*This registry enforces the UX boundary contexts ensuring the PrimeCare monolithic separation natively compiles directly into these 7 overarching sub-applications.*
