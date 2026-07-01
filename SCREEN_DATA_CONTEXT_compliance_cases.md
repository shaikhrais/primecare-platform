# SCREEN DATA CONTEXT: compliance_cases

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceCasesScreen** screen.

---

## 1. Screen Record
* **ID**: `722`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_cases`
* **Screen Name**: `ComplianceCasesScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/compliance-cases`
* **Actual File Path**: `apps/primecare_corporate/lib/features/compliance/screens/compliance_cases_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance cases.`
* **User Story**: `As a Guest, I want to access the Compliance Cases within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Cases`
* **Acceptance Criteria**:
- The Compliance Cases route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_cases-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_cases-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_cases-content` (Type: layout, Required: 1)
* **compliancecasesscreen_screen** -> `compliancecasesscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6964` (Required: 1)
* Component ID: `6965` (Required: 1)
* Component ID: `6966` (Required: 1)
* Component ID: `6967` (Required: 1)
* Component ID: `6968` (Required: 1)

## 7. API / Data Mapping
* API ID: `5100` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_cases_runtime`
* **Test Name**: `Compliance Cases Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Cases`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Cases`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Cases`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/compliance-cases`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
