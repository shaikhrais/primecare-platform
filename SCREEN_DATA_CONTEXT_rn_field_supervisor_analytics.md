# SCREEN DATA CONTEXT: rn_field_supervisor_analytics

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) Field Supervisor - RegisteredNurseRNFieldSupervisorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `611`
* **App ID**: `1`
* **Role ID**: `53`
* **Screen Code**: `rn_field_supervisor_analytics`
* **Screen Name**: `RegisteredNurseRNFieldSupervisorAnalyticsScreen`
* **Route Path**: `/rn/rn-field-supervisor-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_field_supervisor_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `53`
* **Role Code**: `rn_field_supervisor`
* **Role Name**: `Registered Nurse (RN) Field Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) Field Supervisor personnel to oversee, audit, and coordinate operations related to registered nurse (rn) field supervisor analytics.`
* **User Story**: `As a Registered Nurse (RN) Field Supervisor, I want to access the Registered Nurse (RN) Field Supervisor Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Registered Nurse (RN) Field Supervisor Analytics`
* **Acceptance Criteria**:
- The Registered Nurse (RN) Field Supervisor Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) Field Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_field_supervisor_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_field_supervisor_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `rn_field_supervisor_analytics-content` (Type: layout, Required: 1)
* **registered nurse (rn) field supervisor analytics_screen** -> `registered nurse (rn) field supervisor analytics-screen` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `535` (Required: 1)
* Component ID: `1069` (Required: 1)
* Component ID: `1603` (Required: 1)
* Component ID: `6333` (Required: 1)
* Component ID: `6334` (Required: 1)
* Component ID: `6335` (Required: 1)
* Component ID: `6336` (Required: 1)
* Component ID: `6337` (Required: 1)
* Component ID: `6338` (Required: 1)
* Component ID: `6339` (Required: 1)

## 7. API / Data Mapping
* API ID: `4960` (Required: 1)
* API ID: `4961` (Required: 1)
* API ID: `4962` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_field_supervisor_analytics_runtime`
* **Test Name**: `Registered Nurse (RN) Field Supervisor Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Registered Nurse (RN) Field Supervisor Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn_field_supervisor`)
2. **visit** (Selector: `None`, Value: `/rn/rn-field-supervisor-analytics`)
3. **should_be_visible** (Selector: `rn_field_supervisor_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_field_supervisor_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_field_supervisor_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
