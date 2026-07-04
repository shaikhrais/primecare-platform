# SCREEN DATA CONTEXT: coo_staffing_efficiency

Below are the database records from `governance.db` used to configure and build the **Guest - CooStaffingEfficiencyScreen** screen.

---

## 1. Screen Record
* **ID**: `734`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `coo_staffing_efficiency`
* **Screen Name**: `CooStaffingEfficiencyScreen`
* **Route Path**: `/offices/corporate/roles/coo/staffing-efficiency`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/coo_staffing_efficiency_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to coo staffing efficiency.`
* **User Story**: `As a Guest, I want to access the Coo Staffing Efficiency within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Coo Staffing Efficiency`
* **Acceptance Criteria**:
- The Coo Staffing Efficiency route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_staffing_efficiency-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_staffing_efficiency-title` (Type: header, Required: 1)
* **primary_content** -> `coo_staffing_efficiency-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7028` (Required: 1)
* Component ID: `7029` (Required: 1)
* Component ID: `7030` (Required: 1)
* Component ID: `7031` (Required: 1)
* Component ID: `7032` (Required: 1)

## 7. API / Data Mapping
* API ID: `5116` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_staffing_efficiency_runtime`
* **Test Name**: `Coo Staffing Efficiency Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Coo Staffing Efficiency`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/staffing-efficiency`)
3. **should_be_visible** (Selector: `coo_staffing_efficiency-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_staffing_efficiency-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_staffing_efficiency-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
