# SCREEN DATA CONTEXT: intake_compliance

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - IntakeComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `120`
* **App ID**: `1`
* **Role ID**: `7`
* **Screen Code**: `intake_compliance`
* **Screen Name**: `IntakeComplianceScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/intake_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to intakecompliancescreen.`
* **User Story**: `As a Intake Coordinator, I want to access the IntakeComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeComplianceScreen`
* **Acceptance Criteria**:
- The IntakeComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `intake_compliance-content` (Type: layout, Required: 1)
* **intakecompliance_btn_1** -> `intakecompliance-btn-1` (Type: button, Required: 0)
* **intakecompliance_loading** -> `intakecompliance-loading` (Type: loading, Required: 0)
* **intakecompliance_title** -> `intakecompliance-title` (Type: header, Required: 0)
* **intakecompliance_screen** -> `intakecompliance-screen` (Type: layout, Required: 0)
* **intakecompliance_btn_3** -> `intakecompliance-btn-3` (Type: button, Required: 0)
* **intakecompliance_content** -> `intakecompliance-content` (Type: layout, Required: 0)
* **intakecompliance_btn_2** -> `intakecompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `128` (Required: 1)
* Component ID: `662` (Required: 1)
* Component ID: `1196` (Required: 1)
* Component ID: `2625` (Required: 1)
* Component ID: `2626` (Required: 1)
* Component ID: `2627` (Required: 1)
* Component ID: `2628` (Required: 1)
* Component ID: `2629` (Required: 1)
* Component ID: `2630` (Required: 1)
* Component ID: `2631` (Required: 1)
* Component ID: `2632` (Required: 1)

## 7. API / Data Mapping
* API ID: `4399` (Required: 1)
* API ID: `4400` (Required: 1)
* API ID: `4401` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_compliance_runtime`
* **Test Name**: `IntakeComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Intake Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Intake Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Intake Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
