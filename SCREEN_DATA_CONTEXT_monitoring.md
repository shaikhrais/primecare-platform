# SCREEN DATA CONTEXT: monitoring

Below are the database records from `governance.db` used to configure and build the **Guest - MonitoringScreen** screen.

---

## 1. Screen Record
* **ID**: `824`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `monitoring`
* **Screen Name**: `MonitoringScreen`
* **Route Path**: `/governance/monitoring`
* **Actual File Path**: `apps/primecare_governance/lib/features/audit/screens/monitoring_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to monitoring.`
* **User Story**: `As a Guest, I want to access the Monitoring within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Monitoring`
* **Acceptance Criteria**:
- The Monitoring route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `monitoring-screen` (Type: layout, Required: 1)
* **page_title** -> `monitoring-title` (Type: header, Required: 1)
* **primary_content** -> `monitoring-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7521` (Required: 1)
* Component ID: `7522` (Required: 1)
* Component ID: `7523` (Required: 1)
* Component ID: `7524` (Required: 1)
* Component ID: `7525` (Required: 1)

## 7. API / Data Mapping
* API ID: `5217` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `monitoring_runtime`
* **Test Name**: `Monitoring Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Monitoring`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/governance/monitoring`)
3. **should_be_visible** (Selector: `monitoring-screen`, Value: `None`)
4. **should_be_visible** (Selector: `monitoring-title`, Value: `None`)
5. **should_be_visible** (Selector: `monitoring-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
