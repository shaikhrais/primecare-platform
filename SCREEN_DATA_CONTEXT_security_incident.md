# SCREEN DATA CONTEXT: security_incident

Below are the database records from `governance.db` used to configure and build the **Guest - SecurityIncidentScreen** screen.

---

## 1. Screen Record
* **ID**: `984`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `security_incident`
* **Screen Name**: `SecurityIncidentScreen`
* **Route Path**: `/generated/security-incident`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/operations/security_incident_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to security incident.`
* **User Story**: `As a Guest, I want to access the Security Incident within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Security Incident`
* **Acceptance Criteria**:
- The Security Incident route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `security_incident-screen` (Type: layout, Required: 1)
* **page_title** -> `security_incident-title` (Type: header, Required: 1)
* **primary_content** -> `security_incident-content` (Type: layout, Required: 1)
* **security_incident_screen_textfield_input_1** -> `security_incident_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8360` (Required: 1)
* Component ID: `8361` (Required: 1)
* Component ID: `8362` (Required: 1)
* Component ID: `8363` (Required: 1)
* Component ID: `8364` (Required: 1)

## 7. API / Data Mapping
* API ID: `5428` (Required: 1)
* API ID: `5429` (Required: 1)
* API ID: `5430` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `security_incident_runtime`
* **Test Name**: `Security Incident Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Security Incident`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/security-incident`)
3. **should_be_visible** (Selector: `security_incident-screen`, Value: `None`)
4. **should_be_visible** (Selector: `security_incident-title`, Value: `None`)
5. **should_be_visible** (Selector: `security_incident-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
