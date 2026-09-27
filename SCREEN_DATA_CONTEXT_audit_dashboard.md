# SCREEN DATA CONTEXT: audit_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - AuditDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `833`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `audit_dashboard`
* **Screen Name**: `AuditDashboardScreen`
* **Route Path**: `/generated/audit-dashboard`
* **Actual File Path**: `apps/primecare_governance/lib/features/qa/screens/audit_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to audit dashboard.`
* **User Story**: `As a Guest, I want to access the Audit Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Audit Dashboard`
* **Acceptance Criteria**:
- The Audit Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `audit_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `audit_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `audit_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7574` (Required: 1)
* Component ID: `7575` (Required: 1)
* Component ID: `7576` (Required: 1)
* Component ID: `7577` (Required: 1)
* Component ID: `7578` (Required: 1)
* Component ID: `7579` (Required: 1)

## 7. API / Data Mapping
* API ID: `4931` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `audit_dashboard_runtime`
* **Test Name**: `Audit Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Audit Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/audit-dashboard`)
3. **should_be_visible** (Selector: `audit_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `audit_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `audit_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
