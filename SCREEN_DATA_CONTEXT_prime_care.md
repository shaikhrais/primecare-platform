# SCREEN DATA CONTEXT: prime_care

Below are the database records from `governance.db` used to configure and build the **Guest - PrimeCareScreen** screen.

---

## 1. Screen Record
* **ID**: `898`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `prime_care`
* **Screen Name**: `PrimeCareScreen`
* **Route Path**: `/generated/prime-care`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/prime_care_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to prime care.`
* **User Story**: `As a Guest, I want to access the Prime Care within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Prime Care`
* **Acceptance Criteria**:
- The Prime Care route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `prime_care-screen` (Type: layout, Required: 1)
* **page_title** -> `prime_care-title` (Type: header, Required: 1)
* **primary_content** -> `prime_care-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7942` (Required: 1)
* Component ID: `7943` (Required: 1)
* Component ID: `7944` (Required: 1)
* Component ID: `7945` (Required: 1)
* Component ID: `7946` (Required: 1)

## 7. API / Data Mapping
* API ID: `5312` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `prime_care_runtime`
* **Test Name**: `Prime Care Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Prime Care`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/prime-care`)
3. **should_be_visible** (Selector: `prime_care-screen`, Value: `None`)
4. **should_be_visible** (Selector: `prime_care-title`, Value: `None`)
5. **should_be_visible** (Selector: `prime_care-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
