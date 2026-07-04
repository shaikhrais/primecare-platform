# SCREEN DATA CONTEXT: cto_issue_tracking

Below are the database records from `governance.db` used to configure and build the **Guest - CtoIssueTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `752`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_issue_tracking`
* **Screen Name**: `CtoIssueTrackingScreen`
* **Route Path**: `/offices/corporate/roles/cto/issue-tracking`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_issue_tracking_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto issue tracking.`
* **User Story**: `As a Guest, I want to access the Cto Issue Tracking within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto Issue Tracking`
* **Acceptance Criteria**:
- The Cto Issue Tracking route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_issue_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_issue_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `cto_issue_tracking-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7129` (Required: 1)
* Component ID: `7130` (Required: 1)
* Component ID: `7131` (Required: 1)
* Component ID: `7132` (Required: 1)
* Component ID: `7133` (Required: 1)

## 7. API / Data Mapping
* API ID: `5140` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_issue_tracking_runtime`
* **Test Name**: `Cto Issue Tracking Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto Issue Tracking`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/issue-tracking`)
3. **should_be_visible** (Selector: `cto_issue_tracking-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_issue_tracking-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_issue_tracking-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
