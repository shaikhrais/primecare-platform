# SCREEN DATA CONTEXT: family_loved_one_schedule

Below are the database records from `governance.db` used to configure and build the **Guest - FamilyLovedOneScheduleScreen** screen.

---

## 1. Screen Record
* **ID**: `658`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `family_loved_one_schedule`
* **Screen Name**: `FamilyLovedOneScheduleScreen`
* **Route Path**: `/offices/client/roles/family_member/loved-one-schedule`
* **Actual File Path**: `apps/primecare_client/lib/features/family/screens/family_loved_one_schedule_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to family loved one schedule.`
* **User Story**: `As a Guest, I want to access the Family Loved One Schedule within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Family Loved One Schedule`
* **Acceptance Criteria**:
- The Family Loved One Schedule route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_loved_one_schedule-screen` (Type: layout, Required: 1)
* **page_title** -> `family_loved_one_schedule-title` (Type: header, Required: 1)
* **primary_content** -> `family_loved_one_schedule-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6619` (Required: 1)
* Component ID: `6620` (Required: 1)
* Component ID: `6621` (Required: 1)
* Component ID: `6622` (Required: 1)

## 7. API / Data Mapping
* API ID: `5018` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_loved_one_schedule_runtime`
* **Test Name**: `Family Loved One Schedule Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Loved One Schedule`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/client/roles/family_member/loved-one-schedule`)
3. **should_be_visible** (Selector: `family_loved_one_schedule-screen`, Value: `None`)
4. **should_be_visible** (Selector: `family_loved_one_schedule-title`, Value: `None`)
5. **should_be_visible** (Selector: `family_loved_one_schedule-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
