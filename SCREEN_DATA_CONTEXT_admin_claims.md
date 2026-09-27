# SCREEN DATA CONTEXT: admin_claims

Below are the database records from `governance.db` used to configure and build the **Guest - AdminClaimsScreen** screen.

---

## 1. Screen Record
* **ID**: `784`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `admin_claims`
* **Screen Name**: `AdminClaimsScreen`
* **Route Path**: `/offices/franchise/roles/admin/claims`
* **Actual File Path**: `apps/primecare_franchise/lib/features/generated_screens/admin_claims_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to admin claims.`
* **User Story**: `As a Guest, I want to access the Admin Claims within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Admin Claims`
* **Acceptance Criteria**:
- The Admin Claims route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `admin_claims-screen` (Type: layout, Required: 1)
* **page_title** -> `admin_claims-title` (Type: header, Required: 1)
* **primary_content** -> `admin_claims-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7292` (Required: 1)
* Component ID: `7293` (Required: 1)
* Component ID: `7294` (Required: 1)
* Component ID: `7295` (Required: 1)
* Component ID: `7296` (Required: 1)

## 7. API / Data Mapping
* API ID: `5172` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `admin_claims_runtime`
* **Test Name**: `Admin Claims Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Admin Claims`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/admin/claims`)
3. **should_be_visible** (Selector: `admin_claims-screen`, Value: `None`)
4. **should_be_visible** (Selector: `admin_claims-title`, Value: `None`)
5. **should_be_visible** (Selector: `admin_claims-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
