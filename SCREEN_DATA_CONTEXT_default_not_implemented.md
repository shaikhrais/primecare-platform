# SCREEN DATA CONTEXT: default_not_implemented

Below are the database records from `governance.db` used to configure and build the **Guest - DefaultNotImplementedScreen** screen.

---

## 1. Screen Record
* **ID**: `899`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `default_not_implemented`
* **Screen Name**: `DefaultNotImplementedScreen`
* **Route Path**: `/generated/default-not-implemented`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/default_not_implemented_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to default not implemented.`
* **User Story**: `As a Guest, I want to access the Default Not Implemented within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Default Not Implemented`
* **Acceptance Criteria**:
- The Default Not Implemented route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `default_not_implemented-screen` (Type: layout, Required: 1)
* **page_title** -> `default_not_implemented-title` (Type: header, Required: 1)
* **primary_content** -> `default_not_implemented-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7947` (Required: 1)
* Component ID: `7948` (Required: 1)
* Component ID: `7949` (Required: 1)
* Component ID: `7950` (Required: 1)
* Component ID: `7951` (Required: 1)
* Component ID: `7952` (Required: 1)
* Component ID: `7953` (Required: 1)

## 7. API / Data Mapping
* API ID: `5313` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `default_not_implemented_runtime`
* **Test Name**: `Default Not Implemented Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Default Not Implemented`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/default-not-implemented`)
3. **should_be_visible** (Selector: `default_not_implemented-screen`, Value: `None`)
4. **should_be_visible** (Selector: `default_not_implemented-title`, Value: `None`)
5. **should_be_visible** (Selector: `default_not_implemented-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
