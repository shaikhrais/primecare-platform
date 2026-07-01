# SCREEN DATA CONTEXT: hr_hiring_credentials

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringCredentialsScreen** screen.

---

## 1. Screen Record
* **ID**: `319`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_credentials`
* **Screen Name**: `HrHiringCredentialsScreen`
* **Route Path**: `/offices/franchise/roles/hr_hiring/credentials`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_hiring_credentials_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `45`
* **Role Code**: `hr_hiring`
* **Role Name**: `Talent Acquisition Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringcredentialsscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringCredentialsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringCredentialsScreen`
* **Acceptance Criteria**:
- The HrHiringCredentialsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_credentials-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_credentials-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_credentials-content` (Type: layout, Required: 1)
* **hrhiringcredentials_btn_2** -> `hrhiringcredentials-btn-2` (Type: button, Required: 0)
* **hrhiringcredentials_content** -> `hrhiringcredentials-content` (Type: layout, Required: 0)
* **hrhiringcredentials_btn_1** -> `hrhiringcredentials-btn-1` (Type: button, Required: 0)
* **hrhiringcredentials_btn_3** -> `hrhiringcredentials-btn-3` (Type: button, Required: 0)
* **hrhiringcredentials_screen** -> `hrhiringcredentials-screen` (Type: layout, Required: 0)
* **hrhiringcredentials_btn_4** -> `hrhiringcredentials-btn-4` (Type: button, Required: 0)
* **hrhiringcredentials_btn_5** -> `hrhiringcredentials-btn-5` (Type: button, Required: 0)
* **hrhiringcredentials_title** -> `hrhiringcredentials-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `327` (Required: 1)
* Component ID: `861` (Required: 1)
* Component ID: `1395` (Required: 1)
* Component ID: `4451` (Required: 1)
* Component ID: `4452` (Required: 1)
* Component ID: `4453` (Required: 1)
* Component ID: `4454` (Required: 1)
* Component ID: `4455` (Required: 1)
* Component ID: `4456` (Required: 1)
* Component ID: `4457` (Required: 1)

## 7. API / Data Mapping
* API ID: `4648` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_credentials_runtime`
* **Test Name**: `HrHiringCredentialsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Hiring Credentials`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Hiring Credentials`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Hiring Credentials`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/hr_hiring/credentials`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
