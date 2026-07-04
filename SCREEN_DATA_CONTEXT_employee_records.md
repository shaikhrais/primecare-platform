# SCREEN DATA CONTEXT: employee_records

Below are the database records from `governance.db` used to configure and build the **HR Director - EmployeeRecordsScreen** screen.

---

## 1. Screen Record
* **ID**: `491`
* **App ID**: `5`
* **Role ID**: `27`
* **Screen Code**: `employee_records`
* **Screen Name**: `EmployeeRecordsScreen`
* **Route Path**: `/management/employee-records`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/employee_records_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to employeerecordsscreen.`
* **User Story**: `As a HR Director, I want to access the EmployeeRecordsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `EmployeeRecordsScreen`
* **Acceptance Criteria**:
- The EmployeeRecordsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `employee_records-screen` (Type: layout, Required: 1)
* **page_title** -> `employee_records-title` (Type: header, Required: 1)
* **primary_content** -> `employee_records-content` (Type: layout, Required: 1)
* **employeerecords_screen** -> `employeerecords-screen` (Type: layout, Required: 0)
* **employeerecords_btn_3** -> `employeerecords-btn-3` (Type: button, Required: 0)
* **employeerecords_btn_1** -> `employeerecords-btn-1` (Type: button, Required: 0)
* **employeerecords_title** -> `employeerecords-title` (Type: header, Required: 0)
* **employeerecords_loading** -> `employeerecords-loading` (Type: loading, Required: 0)
* **employeerecords_content** -> `employeerecords-content` (Type: layout, Required: 0)
* **employeerecords_btn_2** -> `employeerecords-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `420` (Required: 1)
* Component ID: `954` (Required: 1)
* Component ID: `1488` (Required: 1)
* Component ID: `5293` (Required: 1)
* Component ID: `5294` (Required: 1)
* Component ID: `5295` (Required: 1)
* Component ID: `5296` (Required: 1)
* Component ID: `5297` (Required: 1)
* Component ID: `5298` (Required: 1)
* Component ID: `5299` (Required: 1)
* Component ID: `5300` (Required: 1)
* Component ID: `5301` (Required: 1)
* Component ID: `5302` (Required: 1)

## 7. API / Data Mapping
* API ID: `4808` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `employee_records_runtime`
* **Test Name**: `EmployeeRecordsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `EmployeeRecordsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/management/employee-records`)
3. **should_be_visible** (Selector: `employee_records-screen`, Value: `None`)
4. **should_be_visible** (Selector: `employee_records-title`, Value: `None`)
5. **should_be_visible** (Selector: `employee_records-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
