# SCREEN DATA CONTEXT: tenant_configuration

Below are the database records from `governance.db` used to configure and build the **Guest - TenantConfigurationScreen** screen.

---

## 1. Screen Record
* **ID**: `933`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `tenant_configuration`
* **Screen Name**: `TenantConfigurationScreen`
* **Route Path**: `/generated/tenant-configuration`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/tenant_configuration_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to tenant configuration.`
* **User Story**: `As a Guest, I want to access the Tenant Configuration within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Tenant Configuration`
* **Acceptance Criteria**:
- The Tenant Configuration route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `tenant_configuration-screen` (Type: layout, Required: 1)
* **page_title** -> `tenant_configuration-title` (Type: header, Required: 1)
* **primary_content** -> `tenant_configuration-content` (Type: layout, Required: 1)
* **tenant_configuration_screen_outlinedbutton_button_1** -> `tenant_configuration_screen_outlinedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8114` (Required: 1)
* Component ID: `8115` (Required: 1)
* Component ID: `8116` (Required: 1)
* Component ID: `8117` (Required: 1)
* Component ID: `8118` (Required: 1)

## 7. API / Data Mapping
* API ID: `5365` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `tenant_configuration_runtime`
* **Test Name**: `Tenant Configuration Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Tenant Configuration`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/tenant-configuration`)
3. **should_be_visible** (Selector: `tenant_configuration-screen`, Value: `None`)
4. **should_be_visible** (Selector: `tenant_configuration-title`, Value: `None`)
5. **should_be_visible** (Selector: `tenant_configuration-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
