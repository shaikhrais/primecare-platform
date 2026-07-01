# SCREEN DATA CONTEXT: physiotherapist_compliance

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `129`
* **App ID**: `1`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_compliance`
* **Screen Name**: `PhysiotherapistComplianceScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistcompliancescreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistComplianceScreen`
* **Acceptance Criteria**:
- The PhysiotherapistComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_compliance-content` (Type: layout, Required: 1)
* **physiotherapistcompliance_title** -> `physiotherapistcompliance-title` (Type: header, Required: 0)
* **physiotherapistcompliance_content** -> `physiotherapistcompliance-content` (Type: layout, Required: 0)
* **physiotherapistcompliance_btn_1** -> `physiotherapistcompliance-btn-1` (Type: button, Required: 0)
* **physiotherapistcompliance_btn_3** -> `physiotherapistcompliance-btn-3` (Type: button, Required: 0)
* **physiotherapistcompliance_btn_2** -> `physiotherapistcompliance-btn-2` (Type: button, Required: 0)
* **physiotherapistcompliance_screen** -> `physiotherapistcompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `137` (Required: 1)
* Component ID: `671` (Required: 1)
* Component ID: `1205` (Required: 1)
* Component ID: `2698` (Required: 1)
* Component ID: `2699` (Required: 1)
* Component ID: `2700` (Required: 1)
* Component ID: `2701` (Required: 1)
* Component ID: `2702` (Required: 1)
* Component ID: `2703` (Required: 1)
* Component ID: `2704` (Required: 1)

## 7. API / Data Mapping
* API ID: `4412` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_compliance_runtime`
* **Test Name**: `PhysiotherapistComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physiotherapist Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physiotherapist Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physiotherapist Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
