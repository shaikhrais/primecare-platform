# SCREEN DATA CONTEXT: training_coordinator_progress

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingCoordinatorProgressScreen** screen.

---

## 1. Screen Record
* **ID**: `891`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_coordinator_progress`
* **Screen Name**: `TrainingCoordinatorProgressScreen`
* **Route Path**: `/generated/training-coordinator-progress`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/training_coordinator_progress_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training coordinator progress.`
* **User Story**: `As a Guest, I want to access the Training Coordinator Progress within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Coordinator Progress`
* **Acceptance Criteria**:
- The Training Coordinator Progress route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_coordinator_progress-screen` (Type: layout, Required: 1)
* **page_title** -> `training_coordinator_progress-title` (Type: header, Required: 1)
* **primary_content** -> `training_coordinator_progress-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7901` (Required: 1)
* Component ID: `7902` (Required: 1)
* Component ID: `7903` (Required: 1)
* Component ID: `7904` (Required: 1)
* Component ID: `7905` (Required: 1)
* Component ID: `7906` (Required: 1)

## 7. API / Data Mapping
* API ID: `5305` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_coordinator_progress_runtime`
* **Test Name**: `Training Coordinator Progress Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Coordinator Progress`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Training Coordinator Progress`)
4. **click_sidebar_link** (Selector: `None`, Value: `Training Coordinator Progress`)
5. **check_url** (Selector: `None`, Value: `/generated/training-coordinator-progress`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
