# SCREEN DATA CONTEXT: physiotherapist_client_intake

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistClientIntakeScreen** screen.

---

## 1. Screen Record
* **ID**: `337`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_client_intake`
* **Screen Name**: `PhysiotherapistClientIntakeScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/client-intake`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_client_intake_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistclientintakescreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistClientIntakeScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistClientIntakeScreen`
* **Acceptance Criteria**:
- The PhysiotherapistClientIntakeScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_client_intake-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_client_intake-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_client_intake-content` (Type: layout, Required: 1)
* **physiotherapistclientintake_btn_1** -> `physiotherapistclientintake-btn-1` (Type: button, Required: 0)
* **physiotherapistclientintake_btn_2** -> `physiotherapistclientintake-btn-2` (Type: button, Required: 0)
* **physiotherapistclientintake_content** -> `physiotherapistclientintake-content` (Type: layout, Required: 0)
* **physiotherapistclientintake_title** -> `physiotherapistclientintake-title` (Type: header, Required: 0)
* **physiotherapistclientintake_screen** -> `physiotherapistclientintake-screen` (Type: layout, Required: 0)
* **physiotherapistclientintake_btn_3** -> `physiotherapistclientintake-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `345` (Required: 1)
* Component ID: `879` (Required: 1)
* Component ID: `1413` (Required: 1)
* Component ID: `4579` (Required: 1)
* Component ID: `4580` (Required: 1)
* Component ID: `4581` (Required: 1)
* Component ID: `4582` (Required: 1)
* Component ID: `4583` (Required: 1)
* Component ID: `4584` (Required: 1)
* Component ID: `4585` (Required: 1)

## 7. API / Data Mapping
* API ID: `4666` (Required: 1)
* API ID: `4667` (Required: 1)
* API ID: `4668` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_client_intake_runtime`
* **Test Name**: `PhysiotherapistClientIntakeScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PhysiotherapistClientIntakeScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/client-intake`)
3. **should_be_visible** (Selector: `physiotherapist_client_intake-screen`, Value: `None`)
4. **should_be_visible** (Selector: `physiotherapist_client_intake-title`, Value: `None`)
5. **should_be_visible** (Selector: `physiotherapist_client_intake-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
