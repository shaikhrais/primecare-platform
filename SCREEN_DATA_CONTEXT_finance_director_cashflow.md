# SCREEN DATA CONTEXT: finance_director_cashflow

Below are the database records from `governance.db` used to configure and build the **Guest - FinanceDirectorCashflowScreen** screen.

---

## 1. Screen Record
* **ID**: `759`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `finance_director_cashflow`
* **Screen Name**: `FinanceDirectorCashflowScreen`
* **Route Path**: `/offices/corporate/roles/finance_director/cashflow`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/finance_director_cashflow_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to finance director cashflow.`
* **User Story**: `As a Guest, I want to access the Finance Director Cashflow within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Finance Director Cashflow`
* **Acceptance Criteria**:
- The Finance Director Cashflow route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `finance_director_cashflow-screen` (Type: layout, Required: 1)
* **page_title** -> `finance_director_cashflow-title` (Type: header, Required: 1)
* **primary_content** -> `finance_director_cashflow-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7168` (Required: 1)
* Component ID: `7169` (Required: 1)
* Component ID: `7170` (Required: 1)
* Component ID: `7171` (Required: 1)
* Component ID: `7172` (Required: 1)
* Component ID: `7173` (Required: 1)
* Component ID: `7174` (Required: 1)
* Component ID: `7175` (Required: 1)

## 7. API / Data Mapping
* API ID: `5149` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `finance_director_cashflow_runtime`
* **Test Name**: `Finance Director Cashflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Finance Director Cashflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/finance_director/cashflow`)
3. **should_be_visible** (Selector: `finance_director_cashflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `finance_director_cashflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `finance_director_cashflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
