# SCREEN DATA CONTEXT: staff_performance

Below are the database records from `governance.db` used to configure and build the **Clinical Director - StaffPerformanceScreen** screen.

---

## 1. Screen Record
* **ID**: `554`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `staff_performance`
* **Screen Name**: `StaffPerformanceScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/staff-performance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/staff_performance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to staffperformancescreen.`
* **User Story**: `As a Clinical Director, I want to access the StaffPerformanceScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `StaffPerformanceScreen`
* **Acceptance Criteria**:
- The StaffPerformanceScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `staff_performance-screen` (Type: layout, Required: 1)
* **page_title** -> `staff_performance-title` (Type: header, Required: 1)
* **primary_content** -> `staff_performance-content` (Type: layout, Required: 1)
* **staffperformance_title** -> `staffperformance-title` (Type: header, Required: 0)
* **staffperformance_loading** -> `staffperformance-loading` (Type: loading, Required: 0)
* **staffperformance_btn_3** -> `staffperformance-btn-3` (Type: button, Required: 0)
* **staffperformance_screen** -> `staffperformance-screen` (Type: layout, Required: 0)
* **staffperformance_content** -> `staffperformance-content` (Type: layout, Required: 0)
* **staffperformance_btn_1** -> `staffperformance-btn-1` (Type: button, Required: 0)
* **staffperformance_btn_2** -> `staffperformance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `478` (Required: 1)
* Component ID: `1012` (Required: 1)
* Component ID: `1546` (Required: 1)
* Component ID: `5843` (Required: 1)
* Component ID: `5844` (Required: 1)
* Component ID: `5845` (Required: 1)
* Component ID: `5846` (Required: 1)
* Component ID: `5847` (Required: 1)
* Component ID: `5848` (Required: 1)
* Component ID: `5849` (Required: 1)
* Component ID: `5850` (Required: 1)
* Component ID: `5851` (Required: 1)
* Component ID: `5852` (Required: 1)

## 7. API / Data Mapping
* API ID: `4899` (Required: 1)
* API ID: `4900` (Required: 1)
* API ID: `4901` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `staff_performance_runtime`
* **Test Name**: `StaffPerformanceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `StaffPerformanceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/staff-performance`)
3. **should_be_visible** (Selector: `staff_performance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `staff_performance-title`, Value: `None`)
5. **should_be_visible** (Selector: `staff_performance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
