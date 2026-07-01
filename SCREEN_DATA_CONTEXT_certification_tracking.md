# SCREEN DATA CONTEXT: certification_tracking

Below are the database records from `governance.db` used to configure and build the **Training Coordinator - CertificationTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `563`
* **App ID**: `5`
* **Role ID**: `62`
* **Screen Code**: `certification_tracking`
* **Screen Name**: `CertificationTrackingScreen`
* **Route Path**: `/staff/certification-tracking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/certification_tracking_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `62`
* **Role Code**: `training_coordinator`
* **Role Name**: `Training Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Training Coordinator personnel to oversee, audit, and coordinate operations related to certificationtrackingscreen.`
* **User Story**: `As a Training Coordinator, I want to access the CertificationTrackingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CertificationTrackingScreen`
* **Acceptance Criteria**:
- The CertificationTrackingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `certification_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `certification_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `certification_tracking-content` (Type: layout, Required: 1)
* **certificationtracking_btn_4** -> `certificationtracking-btn-4` (Type: button, Required: 0)
* **certificationtracking_btn_5** -> `certificationtracking-btn-5` (Type: button, Required: 0)
* **certificationtracking_screen** -> `certificationtracking-screen` (Type: layout, Required: 0)
* **certificationtracking_btn_3** -> `certificationtracking-btn-3` (Type: button, Required: 0)
* **certificationtracking_btn_1** -> `certificationtracking-btn-1` (Type: button, Required: 0)
* **certificationtracking_content** -> `certificationtracking-content` (Type: layout, Required: 0)
* **certificationtracking_title** -> `certificationtracking-title` (Type: header, Required: 0)
* **certificationtracking_btn_2** -> `certificationtracking-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `487` (Required: 1)
* Component ID: `1021` (Required: 1)
* Component ID: `1555` (Required: 1)
* Component ID: `5926` (Required: 1)
* Component ID: `5927` (Required: 1)
* Component ID: `5928` (Required: 1)
* Component ID: `5929` (Required: 1)
* Component ID: `5930` (Required: 1)
* Component ID: `5931` (Required: 1)
* Component ID: `5932` (Required: 1)
* Component ID: `5933` (Required: 1)
* Component ID: `5934` (Required: 1)
* Component ID: `5935` (Required: 1)

## 7. API / Data Mapping
* API ID: `4910` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `certification_tracking_runtime`
* **Test Name**: `CertificationTrackingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Certification Tracking`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_coordinator`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Certification Tracking`)
4. **click_sidebar_link** (Selector: `None`, Value: `Certification Tracking`)
5. **check_url** (Selector: `None`, Value: `/staff/certification-tracking`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
