# SCREEN DATA CONTEXT: scrum_master_compliance

Below are the database records from `governance.db` used to configure and build the **Scrum Master - ScrumMasterComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `223`
* **App ID**: `1`
* **Role ID**: `44`
* **Screen Code**: `scrum_master_compliance`
* **Screen Name**: `ScrumMasterComplianceScreen`
* **Route Path**: `/management/scrum-master-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/scrum_master_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `44`
* **Role Code**: `scrum_master`
* **Role Name**: `Scrum Master`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Scrum Master personnel to oversee, audit, and coordinate operations related to scrummastercompliancescreen.`
* **User Story**: `As a Scrum Master, I want to access the ScrumMasterComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ScrumMasterComplianceScreen`
* **Acceptance Criteria**:
- The ScrumMasterComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Scrum Master access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scrum_master_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `scrum_master_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `scrum_master_compliance-content` (Type: layout, Required: 1)
* **scrummastercompliance_btn_3** -> `scrummastercompliance-btn-3` (Type: button, Required: 0)
* **scrummastercompliance_screen** -> `scrummastercompliance-screen` (Type: layout, Required: 0)
* **scrummastercompliance_content** -> `scrummastercompliance-content` (Type: layout, Required: 0)
* **scrummastercompliance_btn_2** -> `scrummastercompliance-btn-2` (Type: button, Required: 0)
* **scrummastercompliance_title** -> `scrummastercompliance-title` (Type: header, Required: 0)
* **scrummastercompliance_btn_1** -> `scrummastercompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `231` (Required: 1)
* Component ID: `765` (Required: 1)
* Component ID: `1299` (Required: 1)
* Component ID: `3572` (Required: 1)
* Component ID: `3573` (Required: 1)
* Component ID: `3574` (Required: 1)
* Component ID: `3575` (Required: 1)
* Component ID: `3576` (Required: 1)
* Component ID: `3577` (Required: 1)
* Component ID: `3578` (Required: 1)
* Component ID: `3579` (Required: 1)
* Component ID: `3580` (Required: 1)
* Component ID: `3581` (Required: 1)

## 7. API / Data Mapping
* API ID: `4512` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scrum_master_compliance_runtime`
* **Test Name**: `ScrumMasterComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scrum Master Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scrum_master`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scrum Master Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scrum Master Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/scrum-master-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
