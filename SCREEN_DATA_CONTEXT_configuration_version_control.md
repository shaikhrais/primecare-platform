# SCREEN DATA CONTEXT: configuration_version_control

Below are the database records from `governance.db` used to configure and build the **Guest - ConfigurationVersionControlScreen** screen.

---

## 1. Screen Record
* **ID**: `906`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `configuration_version_control`
* **Screen Name**: `ConfigurationVersionControlScreen`
* **Route Path**: `/generated/configuration-version-control`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/configuration_version_control.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to configuration version control.`
* **User Story**: `As a Guest, I want to access the Configuration Version Control within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Configuration Version Control`
* **Acceptance Criteria**:
- The Configuration Version Control route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `configuration_version_control-screen` (Type: layout, Required: 1)
* **page_title** -> `configuration_version_control-title` (Type: header, Required: 1)
* **primary_content** -> `configuration_version_control-content` (Type: layout, Required: 1)
* **configuration_version_control_elevatedbutton_button_1** -> `configuration_version_control_elevatedbutton_button_1` (Type: button, Required: 0)
* **configuration_version_control_outlinedbutton_button_1** -> `configuration_version_control_outlinedbutton_button_1` (Type: button, Required: 0)
* **configuration_version_control_iconbutton_button_1** -> `configuration_version_control_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7984` (Required: 1)
* Component ID: `7985` (Required: 1)
* Component ID: `7986` (Required: 1)
* Component ID: `7987` (Required: 1)
* Component ID: `7988` (Required: 1)
* Component ID: `7989` (Required: 1)

## 7. API / Data Mapping
* API ID: `5324` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `configuration_version_control_runtime`
* **Test Name**: `Configuration Version Control Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Configuration Version Control`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/configuration-version-control`)
3. **should_be_visible** (Selector: `configuration_version_control-screen`, Value: `None`)
4. **should_be_visible** (Selector: `configuration_version_control-title`, Value: `None`)
5. **should_be_visible** (Selector: `configuration_version_control-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
