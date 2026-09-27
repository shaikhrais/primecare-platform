# SCREEN DATA CONTEXT: receptionist_compliance

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - ReceptionistComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `267`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `receptionist_compliance`
* **Screen Name**: `ReceptionistComplianceScreen`
* **Route Path**: `/staff/receptionist-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/receptionist_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to receptionistcompliancescreen.`
* **User Story**: `As a Administrative Assistant, I want to access the ReceptionistComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ReceptionistComplianceScreen`
* **Acceptance Criteria**:
- The ReceptionistComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `receptionist_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `receptionist_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `receptionist_compliance-content` (Type: layout, Required: 1)
* **receptionistcompliance_title** -> `receptionistcompliance-title` (Type: header, Required: 0)
* **receptionistcompliance_btn_1** -> `receptionistcompliance-btn-1` (Type: button, Required: 0)
* **receptionistcompliance_btn_5** -> `receptionistcompliance-btn-5` (Type: button, Required: 0)
* **receptionistcompliance_content** -> `receptionistcompliance-content` (Type: layout, Required: 0)
* **receptionistcompliance_btn_3** -> `receptionistcompliance-btn-3` (Type: button, Required: 0)
* **receptionistcompliance_screen** -> `receptionistcompliance-screen` (Type: layout, Required: 0)
* **receptionistcompliance_btn_4** -> `receptionistcompliance-btn-4` (Type: button, Required: 0)
* **receptionistcompliance_btn_2** -> `receptionistcompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `275` (Required: 1)
* Component ID: `809` (Required: 1)
* Component ID: `1343` (Required: 1)
* Component ID: `3980` (Required: 1)
* Component ID: `3981` (Required: 1)
* Component ID: `3982` (Required: 1)
* Component ID: `3983` (Required: 1)
* Component ID: `3984` (Required: 1)
* Component ID: `3985` (Required: 1)
* Component ID: `3986` (Required: 1)
* Component ID: `3987` (Required: 1)
* Component ID: `3988` (Required: 1)
* Component ID: `3989` (Required: 1)

## 7. API / Data Mapping
* API ID: `4588` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `receptionist_compliance_runtime`
* **Test Name**: `ReceptionistComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ReceptionistComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/staff/receptionist-compliance`)
3. **should_be_visible** (Selector: `receptionist_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `receptionist_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `receptionist_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
