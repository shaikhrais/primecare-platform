# SCREEN DATA CONTEXT: head_of_bus_dev_compliance

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - HeadOfBusDevComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `202`
* **App ID**: `1`
* **Role ID**: `37`
* **Screen Code**: `head_of_bus_dev_compliance`
* **Screen Name**: `HeadOfBusDevComplianceScreen`
* **Route Path**: `/management/head-of-bus-dev-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/head_of_bus_dev_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to headofbusdevcompliancescreen.`
* **User Story**: `As a Head of Business Development, I want to access the HeadOfBusDevComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfBusDevComplianceScreen`
* **Acceptance Criteria**:
- The HeadOfBusDevComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_bus_dev_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_bus_dev_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_bus_dev_compliance-content` (Type: layout, Required: 1)
* **headofbusdevcompliance_btn_2** -> `headofbusdevcompliance-btn-2` (Type: button, Required: 0)
* **headofbusdevcompliance_content** -> `headofbusdevcompliance-content` (Type: layout, Required: 0)
* **headofbusdevcompliance_btn_1** -> `headofbusdevcompliance-btn-1` (Type: button, Required: 0)
* **headofbusdevcompliance_btn_3** -> `headofbusdevcompliance-btn-3` (Type: button, Required: 0)
* **headofbusdevcompliance_title** -> `headofbusdevcompliance-title` (Type: header, Required: 0)
* **headofbusdevcompliance_screen** -> `headofbusdevcompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `210` (Required: 1)
* Component ID: `744` (Required: 1)
* Component ID: `1278` (Required: 1)
* Component ID: `3373` (Required: 1)
* Component ID: `3374` (Required: 1)
* Component ID: `3375` (Required: 1)
* Component ID: `3376` (Required: 1)
* Component ID: `3377` (Required: 1)
* Component ID: `3378` (Required: 1)
* Component ID: `3379` (Required: 1)
* Component ID: `3380` (Required: 1)
* Component ID: `3381` (Required: 1)
* Component ID: `3382` (Required: 1)

## 7. API / Data Mapping
* API ID: `4491` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_bus_dev_compliance_runtime`
* **Test Name**: `HeadOfBusDevComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Head Of Bus Dev Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Head Of Bus Dev Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Head Of Bus Dev Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/head-of-bus-dev-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
