# SCREEN DATA CONTEXT: office_compliance

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - OfficeComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `123`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `office_compliance`
* **Screen Name**: `OfficeComplianceScreen`
* **Route Path**: `/common/office-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/office_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to officecompliancescreen.`
* **User Story**: `As a Administrative Assistant, I want to access the OfficeComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OfficeComplianceScreen`
* **Acceptance Criteria**:
- The OfficeComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `office_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `office_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `office_compliance-content` (Type: layout, Required: 1)
* **officecompliance_content** -> `officecompliance-content` (Type: layout, Required: 0)
* **officecompliance_title** -> `officecompliance-title` (Type: header, Required: 0)
* **officecompliance_screen** -> `officecompliance-screen` (Type: layout, Required: 0)
* **officecompliance_loading** -> `officecompliance-loading` (Type: loading, Required: 0)
* **officecompliance_btn_1** -> `officecompliance-btn-1` (Type: button, Required: 0)
* **officecompliance_btn_2** -> `officecompliance-btn-2` (Type: button, Required: 0)
* **officecompliance_btn_3** -> `officecompliance-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `131` (Required: 1)
* Component ID: `665` (Required: 1)
* Component ID: `1199` (Required: 1)
* Component ID: `2653` (Required: 1)
* Component ID: `2654` (Required: 1)
* Component ID: `2655` (Required: 1)
* Component ID: `2656` (Required: 1)
* Component ID: `2657` (Required: 1)
* Component ID: `2658` (Required: 1)
* Component ID: `2659` (Required: 1)
* Component ID: `2660` (Required: 1)
* Component ID: `2661` (Required: 1)
* Component ID: `2662` (Required: 1)

## 7. API / Data Mapping
* API ID: `4406` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `office_compliance_runtime`
* **Test Name**: `OfficeComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OfficeComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/common/office-compliance`)
3. **should_be_visible** (Selector: `office_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `office_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `office_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
