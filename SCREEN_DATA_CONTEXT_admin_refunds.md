# SCREEN DATA CONTEXT: admin_refunds

Below are the database records from `governance.db` used to configure and build the **Guest - AdminRefundsScreen** screen.

---

## 1. Screen Record
* **ID**: `790`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `admin_refunds`
* **Screen Name**: `AdminRefundsScreen`
* **Route Path**: `/offices/franchise/roles/admin/refunds`
* **Actual File Path**: `apps/primecare_franchise/lib/features/generated_screens/admin_refunds_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to admin refunds.`
* **User Story**: `As a Guest, I want to access the Admin Refunds within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Admin Refunds`
* **Acceptance Criteria**:
- The Admin Refunds route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `admin_refunds-screen` (Type: layout, Required: 1)
* **page_title** -> `admin_refunds-title` (Type: header, Required: 1)
* **primary_content** -> `admin_refunds-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7326` (Required: 1)
* Component ID: `7327` (Required: 1)
* Component ID: `7328` (Required: 1)
* Component ID: `7329` (Required: 1)
* Component ID: `7330` (Required: 1)

## 7. API / Data Mapping
* API ID: `5178` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `admin_refunds_runtime`
* **Test Name**: `Admin Refunds Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Admin Refunds`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/admin/refunds`)
3. **should_be_visible** (Selector: `admin_refunds-screen`, Value: `None`)
4. **should_be_visible** (Selector: `admin_refunds-title`, Value: `None`)
5. **should_be_visible** (Selector: `admin_refunds-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
