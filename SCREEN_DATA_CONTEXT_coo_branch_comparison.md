# SCREEN DATA CONTEXT: coo_branch_comparison

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooBranchComparisonScreen** screen.

---

## 1. Screen Record
* **ID**: `309`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `coo_branch_comparison`
* **Screen Name**: `CooBranchComparisonScreen`
* **Route Path**: `/offices/corporate/roles/coo/branch-comparison`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_branch_comparison_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to coobranchcomparisonscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooBranchComparisonScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooBranchComparisonScreen`
* **Acceptance Criteria**:
- The CooBranchComparisonScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_branch_comparison-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_branch_comparison-title` (Type: header, Required: 1)
* **primary_content** -> `coo_branch_comparison-content` (Type: layout, Required: 1)
* **coobranchcomparison_screen** -> `coobranchcomparison-screen` (Type: layout, Required: 0)
* **coobranchcomparison_btn_3** -> `coobranchcomparison-btn-3` (Type: button, Required: 0)
* **coobranchcomparison_content** -> `coobranchcomparison-content` (Type: layout, Required: 0)
* **coobranchcomparison_btn_2** -> `coobranchcomparison-btn-2` (Type: button, Required: 0)
* **coobranchcomparison_title** -> `coobranchcomparison-title` (Type: header, Required: 0)
* **coobranchcomparison_btn_1** -> `coobranchcomparison-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `317` (Required: 1)
* Component ID: `851` (Required: 1)
* Component ID: `1385` (Required: 1)
* Component ID: `4355` (Required: 1)
* Component ID: `4356` (Required: 1)
* Component ID: `4357` (Required: 1)
* Component ID: `4358` (Required: 1)
* Component ID: `4359` (Required: 1)
* Component ID: `4360` (Required: 1)
* Component ID: `4361` (Required: 1)
* Component ID: `4362` (Required: 1)
* Component ID: `4363` (Required: 1)
* Component ID: `4364` (Required: 1)

## 7. API / Data Mapping
* API ID: `4638` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_branch_comparison_runtime`
* **Test Name**: `CooBranchComparisonScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `COO Branch Comparison`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `COO Branch Comparison`)
4. **click_sidebar_link** (Selector: `None`, Value: `COO Branch Comparison`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/coo/branch-comparison`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
