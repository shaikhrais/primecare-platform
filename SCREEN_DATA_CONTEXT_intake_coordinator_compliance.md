# SCREEN DATA CONTEXT: intake_coordinator_compliance

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - IntakeCoordinatorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `261`
* **App ID**: `1`
* **Role ID**: `7`
* **Screen Code**: `intake_coordinator_compliance`
* **Screen Name**: `IntakeCoordinatorComplianceScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/coordinator-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatorcompliancescreen.`
* **User Story**: `As a Intake Coordinator, I want to access the IntakeCoordinatorComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorComplianceScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_compliance-content` (Type: layout, Required: 1)
* **intakecoordinatorcompliance_title** -> `intakecoordinatorcompliance-title` (Type: header, Required: 0)
* **intakecoordinatorcompliance_btn_1** -> `intakecoordinatorcompliance-btn-1` (Type: button, Required: 0)
* **intakecoordinatorcompliance_screen** -> `intakecoordinatorcompliance-screen` (Type: layout, Required: 0)
* **intakecoordinatorcompliance_content** -> `intakecoordinatorcompliance-content` (Type: layout, Required: 0)
* **intakecoordinatorcompliance_btn_3** -> `intakecoordinatorcompliance-btn-3` (Type: button, Required: 0)
* **intakecoordinatorcompliance_btn_2** -> `intakecoordinatorcompliance-btn-2` (Type: button, Required: 0)
* **intakecoordinatorcompliance_btn_4** -> `intakecoordinatorcompliance-btn-4` (Type: button, Required: 0)
* **intakecoordinatorcompliance_btn_5** -> `intakecoordinatorcompliance-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `269` (Required: 1)
* Component ID: `803` (Required: 1)
* Component ID: `1337` (Required: 1)
* Component ID: `3923` (Required: 1)
* Component ID: `3924` (Required: 1)
* Component ID: `3925` (Required: 1)
* Component ID: `3926` (Required: 1)
* Component ID: `3927` (Required: 1)
* Component ID: `3928` (Required: 1)
* Component ID: `3929` (Required: 1)
* Component ID: `3930` (Required: 1)
* Component ID: `3931` (Required: 1)
* Component ID: `3932` (Required: 1)

## 7. API / Data Mapping
* API ID: `4578` (Required: 1)
* API ID: `4579` (Required: 1)
* API ID: `4580` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_compliance_runtime`
* **Test Name**: `IntakeCoordinatorComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Intake Coordinator Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Intake Coordinator Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Intake Coordinator Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/coordinator-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
