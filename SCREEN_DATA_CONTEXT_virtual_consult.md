# SCREEN DATA CONTEXT: virtual_consult

Below are the database records from `governance.db` used to configure and build the **Guest - VirtualConsultScreen** screen.

---

## 1. Screen Record
* **ID**: `987`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `virtual_consult`
* **Screen Name**: `VirtualConsultScreen`
* **Route Path**: `/generated/virtual-consult`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/operations/virtual_consult_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to virtual consult.`
* **User Story**: `As a Guest, I want to access the Virtual Consult within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Virtual Consult`
* **Acceptance Criteria**:
- The Virtual Consult route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `virtual_consult-screen` (Type: layout, Required: 1)
* **page_title** -> `virtual_consult-title` (Type: header, Required: 1)
* **primary_content** -> `virtual_consult-content` (Type: layout, Required: 1)
* **virtual_consult_screen_textfield_input_1** -> `virtual_consult_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8377` (Required: 1)
* Component ID: `8378` (Required: 1)
* Component ID: `8379` (Required: 1)
* Component ID: `8380` (Required: 1)
* Component ID: `8381` (Required: 1)

## 7. API / Data Mapping
* API ID: `5437` (Required: 1)
* API ID: `5438` (Required: 1)
* API ID: `5439` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `virtual_consult_runtime`
* **Test Name**: `Virtual Consult Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Virtual Consult`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/virtual-consult`)
3. **should_be_visible** (Selector: `virtual_consult-screen`, Value: `None`)
4. **should_be_visible** (Selector: `virtual_consult-title`, Value: `None`)
5. **should_be_visible** (Selector: `virtual_consult-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
