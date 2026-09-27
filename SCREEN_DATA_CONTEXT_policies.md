# SCREEN DATA CONTEXT: policies

Below are the database records from `governance.db` used to configure and build the **Guest - PoliciesScreen** screen.

---

## 1. Screen Record
* **ID**: `727`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `policies`
* **Screen Name**: `PoliciesScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/policies`
* **Actual File Path**: `apps/primecare_corporate/lib/features/compliance/screens/policies_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to policies.`
* **User Story**: `As a Guest, I want to access the Policies within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Policies`
* **Acceptance Criteria**:
- The Policies route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `policies-screen` (Type: layout, Required: 1)
* **page_title** -> `policies-title` (Type: header, Required: 1)
* **primary_content** -> `policies-content` (Type: layout, Required: 1)
* **policiesscreen_screen** -> `policiesscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6990` (Required: 1)
* Component ID: `6991` (Required: 1)
* Component ID: `6992` (Required: 1)
* Component ID: `6993` (Required: 1)

## 7. API / Data Mapping
* API ID: `5105` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `policies_runtime`
* **Test Name**: `Policies Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Policies`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/policies`)
3. **should_be_visible** (Selector: `policies-screen`, Value: `None`)
4. **should_be_visible** (Selector: `policies-title`, Value: `None`)
5. **should_be_visible** (Selector: `policies-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
