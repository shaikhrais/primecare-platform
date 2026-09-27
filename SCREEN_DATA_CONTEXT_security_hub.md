# SCREEN DATA CONTEXT: security_hub

Below are the database records from `governance.db` used to configure and build the **Guest - SecurityHubScreen** screen.

---

## 1. Screen Record
* **ID**: `838`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `security_hub`
* **Screen Name**: `SecurityHubScreen`
* **Route Path**: `/governance/device-security`
* **Actual File Path**: `apps/primecare_governance/lib/features/security/screens/security_hub_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to security hub.`
* **User Story**: `As a Guest, I want to access the Security Hub within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Security Hub`
* **Acceptance Criteria**:
- The Security Hub route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `security_hub-screen` (Type: layout, Required: 1)
* **page_title** -> `security_hub-title` (Type: header, Required: 1)
* **primary_content** -> `security_hub-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7603` (Required: 1)
* Component ID: `7604` (Required: 1)
* Component ID: `7605` (Required: 1)
* Component ID: `7606` (Required: 1)
* Component ID: `7607` (Required: 1)
* Component ID: `7608` (Required: 1)
* Component ID: `7609` (Required: 1)

## 7. API / Data Mapping
* API ID: `5236` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `security_hub_runtime`
* **Test Name**: `Security Hub Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Security Hub`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/governance/device-security`)
3. **should_be_visible** (Selector: `security_hub-screen`, Value: `None`)
4. **should_be_visible** (Selector: `security_hub-title`, Value: `None`)
5. **should_be_visible** (Selector: `security_hub-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
