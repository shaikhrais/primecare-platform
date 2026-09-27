# SCREEN DATA CONTEXT: interview_scheduling

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - InterviewSchedulingScreen** screen.

---

## 1. Screen Record
* **ID**: `521`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `interview_scheduling`
* **Screen Name**: `InterviewSchedulingScreen`
* **Route Path**: `/staff/interview-scheduling`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/interview_scheduling_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to interviewschedulingscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the InterviewSchedulingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `InterviewSchedulingScreen`
* **Acceptance Criteria**:
- The InterviewSchedulingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `interview_scheduling-screen` (Type: layout, Required: 1)
* **page_title** -> `interview_scheduling-title` (Type: header, Required: 1)
* **primary_content** -> `interview_scheduling-content` (Type: layout, Required: 1)
* **interviewscheduling_btn_1** -> `interviewscheduling-btn-1` (Type: button, Required: 0)
* **interviewscheduling_btn_2** -> `interviewscheduling-btn-2` (Type: button, Required: 0)
* **interviewscheduling_title** -> `interviewscheduling-title` (Type: header, Required: 0)
* **interviewscheduling_btn_5** -> `interviewscheduling-btn-5` (Type: button, Required: 0)
* **interviewscheduling_screen** -> `interviewscheduling-screen` (Type: layout, Required: 0)
* **interviewscheduling_btn_4** -> `interviewscheduling-btn-4` (Type: button, Required: 0)
* **interviewscheduling_btn_3** -> `interviewscheduling-btn-3` (Type: button, Required: 0)
* **interviewscheduling_content** -> `interviewscheduling-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `450` (Required: 1)
* Component ID: `984` (Required: 1)
* Component ID: `1518` (Required: 1)
* Component ID: `5585` (Required: 1)
* Component ID: `5586` (Required: 1)
* Component ID: `5587` (Required: 1)
* Component ID: `5588` (Required: 1)
* Component ID: `5589` (Required: 1)
* Component ID: `5590` (Required: 1)
* Component ID: `5591` (Required: 1)
* Component ID: `5592` (Required: 1)
* Component ID: `5593` (Required: 1)
* Component ID: `5594` (Required: 1)

## 7. API / Data Mapping
* API ID: `4837` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `interview_scheduling_runtime`
* **Test Name**: `InterviewSchedulingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `InterviewSchedulingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/staff/interview-scheduling`)
3. **should_be_visible** (Selector: `interview_scheduling-screen`, Value: `None`)
4. **should_be_visible** (Selector: `interview_scheduling-title`, Value: `None`)
5. **should_be_visible** (Selector: `interview_scheduling-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
