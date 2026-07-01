# SCREEN DATA CONTEXT: treatment_plan

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - TreatmentPlanScreen** screen.

---

## 1. Screen Record
* **ID**: `538`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `treatment_plan`
* **Screen Name**: `TreatmentPlanScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/treatment-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/treatment_plan_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to treatmentplanscreen.`
* **User Story**: `As a Physiotherapist, I want to access the TreatmentPlanScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TreatmentPlanScreen`
* **Acceptance Criteria**:
- The TreatmentPlanScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `treatment_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `treatment_plan-title` (Type: header, Required: 1)
* **primary_content** -> `treatment_plan-content` (Type: layout, Required: 1)
* **treatmentplan_btn_3** -> `treatmentplan-btn-3` (Type: button, Required: 0)
* **treatmentplan_btn_1** -> `treatmentplan-btn-1` (Type: button, Required: 0)
* **treatmentplan_content** -> `treatmentplan-content` (Type: layout, Required: 0)
* **treatmentplan_screen** -> `treatmentplan-screen` (Type: layout, Required: 0)
* **treatmentplan_title** -> `treatmentplan-title` (Type: header, Required: 0)
* **treatmentplan_btn_2** -> `treatmentplan-btn-2` (Type: button, Required: 0)
* **treatmentplan_loading** -> `treatmentplan-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `463` (Required: 1)
* Component ID: `997` (Required: 1)
* Component ID: `1531` (Required: 1)
* Component ID: `5710` (Required: 1)
* Component ID: `5711` (Required: 1)
* Component ID: `5712` (Required: 1)
* Component ID: `5713` (Required: 1)
* Component ID: `5714` (Required: 1)
* Component ID: `5715` (Required: 1)
* Component ID: `5716` (Required: 1)

## 7. API / Data Mapping
* API ID: `4868` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `treatment_plan_runtime`
* **Test Name**: `TreatmentPlanScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Treatment Plan`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Treatment Plan`)
4. **click_sidebar_link** (Selector: `None`, Value: `Treatment Plan`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/treatment-plan`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
