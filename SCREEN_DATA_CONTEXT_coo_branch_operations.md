# SCREEN DATA CONTEXT: coo_branch_operations

Below are the database records from `governance.db` used to configure and build the **Guest - CooBranchOperationsScreen** screen.

---

## 1. Screen Record
* **ID**: `730`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `coo_branch_operations`
* **Screen Name**: `CooBranchOperationsScreen`
* **Route Path**: `/offices/corporate/roles/coo/branch-operations`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/coo_branch_operations_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to coo branch operations.`
* **User Story**: `As a Guest, I want to access the Coo Branch Operations within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Coo Branch Operations`
* **Acceptance Criteria**:
- The Coo Branch Operations route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_branch_operations-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_branch_operations-title` (Type: header, Required: 1)
* **primary_content** -> `coo_branch_operations-content` (Type: layout, Required: 1)
* **coobranchoperationsscreen_screen** -> `coobranchoperationsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `7006` (Required: 1)
* Component ID: `7007` (Required: 1)
* Component ID: `7008` (Required: 1)
* Component ID: `7009` (Required: 1)
* Component ID: `7010` (Required: 1)

## 7. API / Data Mapping
* API ID: `5112` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_branch_operations_runtime`
* **Test Name**: `Coo Branch Operations Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Coo Branch Operations`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/branch-operations`)
3. **should_be_visible** (Selector: `coo_branch_operations-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_branch_operations-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_branch_operations-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
