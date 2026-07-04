# SCREEN DATA CONTEXT: audits

Below are the database records from `governance.db` used to configure and build the **Guest - AuditsScreen** screen.

---

## 1. Screen Record
* **ID**: `721`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `audits`
* **Screen Name**: `AuditsScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/audits`
* **Actual File Path**: `apps/primecare_corporate/lib/features/compliance/screens/audits_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to audits.`
* **User Story**: `As a Guest, I want to access the Audits within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Audits`
* **Acceptance Criteria**:
- The Audits route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `audits-screen` (Type: layout, Required: 1)
* **page_title** -> `audits-title` (Type: header, Required: 1)
* **primary_content** -> `audits-content` (Type: layout, Required: 1)
* **auditsscreen_screen** -> `auditsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6958` (Required: 1)
* Component ID: `6959` (Required: 1)
* Component ID: `6960` (Required: 1)
* Component ID: `6961` (Required: 1)
* Component ID: `6962` (Required: 1)
* Component ID: `6963` (Required: 1)

## 7. API / Data Mapping
* API ID: `5099` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `audits_runtime`
* **Test Name**: `Audits Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Audits`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/audits`)
3. **should_be_visible** (Selector: `audits-screen`, Value: `None`)
4. **should_be_visible** (Selector: `audits-title`, Value: `None`)
5. **should_be_visible** (Selector: `audits-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
