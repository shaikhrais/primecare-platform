# SCREEN DATA CONTEXT: branch_performance

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - BranchPerformanceScreen** screen.

---

## 1. Screen Record
* **ID**: `474`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `branch_performance`
* **Screen Name**: `BranchPerformanceScreen`
* **Route Path**: `/executive/branch-performance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/branch_performance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to branchperformancescreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the BranchPerformanceScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BranchPerformanceScreen`
* **Acceptance Criteria**:
- The BranchPerformanceScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `branch_performance-screen` (Type: layout, Required: 1)
* **page_title** -> `branch_performance-title` (Type: header, Required: 1)
* **primary_content** -> `branch_performance-content` (Type: layout, Required: 1)
* **branchperformance_content** -> `branchperformance-content` (Type: layout, Required: 0)
* **branchperformance_btn_3** -> `branchperformance-btn-3` (Type: button, Required: 0)
* **branchperformance_loading** -> `branchperformance-loading` (Type: loading, Required: 0)
* **branchperformance_btn_1** -> `branchperformance-btn-1` (Type: button, Required: 0)
* **branchperformance_screen** -> `branchperformance-screen` (Type: layout, Required: 0)
* **branchperformance_btn_2** -> `branchperformance-btn-2` (Type: button, Required: 0)
* **branchperformance_title** -> `branchperformance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `403` (Required: 1)
* Component ID: `937` (Required: 1)
* Component ID: `1471` (Required: 1)
* Component ID: `5123` (Required: 1)
* Component ID: `5124` (Required: 1)
* Component ID: `5125` (Required: 1)
* Component ID: `5126` (Required: 1)
* Component ID: `5127` (Required: 1)
* Component ID: `5128` (Required: 1)
* Component ID: `5129` (Required: 1)
* Component ID: `5130` (Required: 1)
* Component ID: `5131` (Required: 1)
* Component ID: `5132` (Required: 1)

## 7. API / Data Mapping
* API ID: `4789` (Required: 1)
* API ID: `4790` (Required: 1)
* API ID: `4791` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `branch_performance_runtime`
* **Test Name**: `BranchPerformanceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BranchPerformanceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/branch-performance`)
3. **should_be_visible** (Selector: `branch_performance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `branch_performance-title`, Value: `None`)
5. **should_be_visible** (Selector: `branch_performance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
