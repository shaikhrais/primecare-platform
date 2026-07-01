# SCREEN DATA CONTEXT: family_member_loved_one_schedule

Below are the database records from `governance.db` used to configure and build the **Guest - FamilyMemberLovedOneScheduleScreen** screen.

---

## 1. Screen Record
* **ID**: `670`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `family_member_loved_one_schedule`
* **Screen Name**: `FamilyMemberLovedOneScheduleScreen`
* **Route Path**: `/generated/family-member-loved-one-schedule`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/family_member_loved_one_schedule_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to family member loved one schedule.`
* **User Story**: `As a Guest, I want to access the Family Member Loved One Schedule within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Family Member Loved One Schedule`
* **Acceptance Criteria**:
- The Family Member Loved One Schedule route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_member_loved_one_schedule-screen` (Type: layout, Required: 1)
* **page_title** -> `family_member_loved_one_schedule-title` (Type: header, Required: 1)
* **primary_content** -> `family_member_loved_one_schedule-content` (Type: layout, Required: 1)
* **familymemberlovedoneschedulescreen_screen** -> `familymemberlovedoneschedulescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6678` (Required: 1)
* Component ID: `6679` (Required: 1)
* Component ID: `6680` (Required: 1)
* Component ID: `6681` (Required: 1)
* Component ID: `6682` (Required: 1)

## 7. API / Data Mapping
* API ID: `5032` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_member_loved_one_schedule_runtime`
* **Test Name**: `Family Member Loved One Schedule Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Member Loved One Schedule`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Family Member Loved One Schedule`)
4. **click_sidebar_link** (Selector: `None`, Value: `Family Member Loved One Schedule`)
5. **check_url** (Selector: `None`, Value: `/generated/family-member-loved-one-schedule`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
