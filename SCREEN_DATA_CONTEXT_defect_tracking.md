# SCREEN DATA CONTEXT: defect_tracking

Below are the database records from `governance.db` used to configure and build the **QA Specialist - DefectTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `568`
* **App ID**: `5`
* **Role ID**: `63`
* **Screen Code**: `defect_tracking`
* **Screen Name**: `DefectTrackingScreen`
* **Route Path**: `/staff/defect-tracking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/defect_tracking_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to defecttrackingscreen.`
* **User Story**: `As a QA Specialist, I want to access the DefectTrackingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DefectTrackingScreen`
* **Acceptance Criteria**:
- The DefectTrackingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `defect_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `defect_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `defect_tracking-content` (Type: layout, Required: 1)
* **defecttracking_btn_1** -> `defecttracking-btn-1` (Type: button, Required: 0)
* **defecttracking_btn_2** -> `defecttracking-btn-2` (Type: button, Required: 0)
* **defecttracking_title** -> `defecttracking-title` (Type: header, Required: 0)
* **defecttracking_btn_5** -> `defecttracking-btn-5` (Type: button, Required: 0)
* **defecttracking_loading** -> `defecttracking-loading` (Type: loading, Required: 0)
* **defecttracking_btn_3** -> `defecttracking-btn-3` (Type: button, Required: 0)
* **defecttracking_content** -> `defecttracking-content` (Type: layout, Required: 0)
* **defecttracking_btn_4** -> `defecttracking-btn-4` (Type: button, Required: 0)
* **defecttracking_screen** -> `defecttracking-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `492` (Required: 1)
* Component ID: `1026` (Required: 1)
* Component ID: `1560` (Required: 1)
* Component ID: `5969` (Required: 1)
* Component ID: `5970` (Required: 1)
* Component ID: `5971` (Required: 1)
* Component ID: `5972` (Required: 1)
* Component ID: `5973` (Required: 1)
* Component ID: `5974` (Required: 1)
* Component ID: `5975` (Required: 1)
* Component ID: `5976` (Required: 1)
* Component ID: `5977` (Required: 1)
* Component ID: `5978` (Required: 1)

## 7. API / Data Mapping
* API ID: `4915` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `defect_tracking_runtime`
* **Test Name**: `DefectTrackingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Defect Tracking`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Defect Tracking`)
4. **click_sidebar_link** (Selector: `None`, Value: `Defect Tracking`)
5. **check_url** (Selector: `None`, Value: `/staff/defect-tracking`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
