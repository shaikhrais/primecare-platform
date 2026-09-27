# SCREEN DATA CONTEXT: psw_observation_vitals_log

Below are the database records from `governance.db` used to configure and build the **Guest - PswObservationVitalsLogScreen** screen.

---

## 1. Screen Record
* **ID**: `687`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_observation_vitals_log`
* **Screen Name**: `PswObservationVitalsLogScreen`
* **Route Path**: `/generated/psw-observation-vitals-log`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/psw_observation_vitals_log_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw observation vitals log.`
* **User Story**: `As a Guest, I want to access the Psw Observation Vitals Log within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Observation Vitals Log`
* **Acceptance Criteria**:
- The Psw Observation Vitals Log route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_observation_vitals_log-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_observation_vitals_log-title` (Type: header, Required: 1)
* **primary_content** -> `psw_observation_vitals_log-content` (Type: layout, Required: 1)
* **pswobservationvitalslogscreen_screen** -> `pswobservationvitalslogscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6773` (Required: 1)
* Component ID: `6774` (Required: 1)
* Component ID: `6775` (Required: 1)
* Component ID: `6776` (Required: 1)
* Component ID: `6777` (Required: 1)

## 7. API / Data Mapping
* API ID: `5053` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_observation_vitals_log_runtime`
* **Test Name**: `Psw Observation Vitals Log Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Observation Vitals Log`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-observation-vitals-log`)
3. **should_be_visible** (Selector: `psw_observation_vitals_log-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_observation_vitals_log-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_observation_vitals_log-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
