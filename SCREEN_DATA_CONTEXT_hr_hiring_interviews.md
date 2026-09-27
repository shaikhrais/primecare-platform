# SCREEN DATA CONTEXT: hr_hiring_interviews

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringInterviewsScreen** screen.

---

## 1. Screen Record
* **ID**: `316`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_interviews`
* **Screen Name**: `HrHiringInterviewsScreen`
* **Route Path**: `/offices/franchise/roles/hr_hiring/interviews`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_hiring_interviews_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringinterviewsscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringInterviewsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringInterviewsScreen`
* **Acceptance Criteria**:
- The HrHiringInterviewsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_interviews-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_interviews-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_interviews-content` (Type: layout, Required: 1)
* **hrhiringinterviews_btn_1** -> `hrhiringinterviews-btn-1` (Type: button, Required: 0)
* **hrhiringinterviews_btn_3** -> `hrhiringinterviews-btn-3` (Type: button, Required: 0)
* **hrhiringinterviews_btn_5** -> `hrhiringinterviews-btn-5` (Type: button, Required: 0)
* **hrhiringinterviews_btn_2** -> `hrhiringinterviews-btn-2` (Type: button, Required: 0)
* **hrhiringinterviews_title** -> `hrhiringinterviews-title` (Type: header, Required: 0)
* **hrhiringinterviews_content** -> `hrhiringinterviews-content` (Type: layout, Required: 0)
* **hrhiringinterviews_screen** -> `hrhiringinterviews-screen` (Type: layout, Required: 0)
* **hrhiringinterviews_btn_4** -> `hrhiringinterviews-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `324` (Required: 1)
* Component ID: `858` (Required: 1)
* Component ID: `1392` (Required: 1)
* Component ID: `4425` (Required: 1)
* Component ID: `4426` (Required: 1)
* Component ID: `4427` (Required: 1)
* Component ID: `4428` (Required: 1)
* Component ID: `4429` (Required: 1)
* Component ID: `4430` (Required: 1)
* Component ID: `4431` (Required: 1)
* Component ID: `4432` (Required: 1)
* Component ID: `4433` (Required: 1)
* Component ID: `4434` (Required: 1)

## 7. API / Data Mapping
* API ID: `4645` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_interviews_runtime`
* **Test Name**: `HrHiringInterviewsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrHiringInterviewsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/hr_hiring/interviews`)
3. **should_be_visible** (Selector: `hr_hiring_interviews-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_hiring_interviews-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_hiring_interviews-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
