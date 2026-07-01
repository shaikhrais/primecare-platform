# SCREEN DATA CONTEXT: compliance_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - ComplianceManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `190`
* **App ID**: `1`
* **Role ID**: `33`
* **Screen Code**: `compliance_manager_compliance`
* **Screen Name**: `ComplianceManagerComplianceScreen`
* **Route Path**: `/management/compliance-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/compliance_manager_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to compliancemanagercompliancescreen.`
* **User Story**: `As a Compliance Manager, I want to access the ComplianceManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceManagerComplianceScreen`
* **Acceptance Criteria**:
- The ComplianceManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_compliance-content` (Type: layout, Required: 1)
* **compliancemanagercompliance_btn_2** -> `compliancemanagercompliance-btn-2` (Type: button, Required: 0)
* **compliancemanagercompliance_btn_1** -> `compliancemanagercompliance-btn-1` (Type: button, Required: 0)
* **compliancemanagercompliance_btn_3** -> `compliancemanagercompliance-btn-3` (Type: button, Required: 0)
* **compliancemanagercompliance_title** -> `compliancemanagercompliance-title` (Type: header, Required: 0)
* **compliancemanagercompliance_content** -> `compliancemanagercompliance-content` (Type: layout, Required: 0)
* **compliancemanagercompliance_screen** -> `compliancemanagercompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `198` (Required: 1)
* Component ID: `732` (Required: 1)
* Component ID: `1266` (Required: 1)
* Component ID: `3256` (Required: 1)
* Component ID: `3257` (Required: 1)
* Component ID: `3258` (Required: 1)
* Component ID: `3259` (Required: 1)
* Component ID: `3260` (Required: 1)
* Component ID: `3261` (Required: 1)
* Component ID: `3262` (Required: 1)

## 7. API / Data Mapping
* API ID: `4479` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_compliance_runtime`
* **Test Name**: `ComplianceManagerComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Manager Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Manager Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Manager Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/compliance-manager-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
