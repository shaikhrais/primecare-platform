# SCREEN DATA CONTEXT: pending_task_queue

Below are the database records from `governance.db` used to configure and build the **Governance Officer - PendingTaskQueueScreen** screen.

---

## 1. Screen Record
* **ID**: `582`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `pending_task_queue`
* **Screen Name**: `PendingTaskQueueScreen`
* **Route Path**: `/common/pending-task-queue`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/pending_task_queue_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to pendingtaskqueuescreen.`
* **User Story**: `As a Governance Officer, I want to access the PendingTaskQueueScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PendingTaskQueueScreen`
* **Acceptance Criteria**:
- The PendingTaskQueueScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `pending_task_queue-screen` (Type: layout, Required: 1)
* **page_title** -> `pending_task_queue-title` (Type: header, Required: 1)
* **primary_content** -> `pending_task_queue-content` (Type: layout, Required: 1)
* **pendingtaskqueue_btn_2** -> `pendingtaskqueue-btn-2` (Type: button, Required: 0)
* **pendingtaskqueue_btn_1** -> `pendingtaskqueue-btn-1` (Type: button, Required: 0)
* **pendingtaskqueue_title** -> `pendingtaskqueue-title` (Type: header, Required: 0)
* **pendingtaskqueue_loading** -> `pendingtaskqueue-loading` (Type: loading, Required: 0)
* **pendingtaskqueue_btn_3** -> `pendingtaskqueue-btn-3` (Type: button, Required: 0)
* **pendingtaskqueue_content** -> `pendingtaskqueue-content` (Type: layout, Required: 0)
* **pendingtaskqueue_screen** -> `pendingtaskqueue-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `506` (Required: 1)
* Component ID: `1040` (Required: 1)
* Component ID: `1574` (Required: 1)
* Component ID: `6073` (Required: 1)
* Component ID: `6074` (Required: 1)
* Component ID: `6075` (Required: 1)
* Component ID: `6076` (Required: 1)
* Component ID: `6077` (Required: 1)
* Component ID: `6078` (Required: 1)
* Component ID: `6079` (Required: 1)
* Component ID: `6080` (Required: 1)
* Component ID: `6081` (Required: 1)

## 7. API / Data Mapping
* API ID: `4929` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `pending_task_queue_runtime`
* **Test Name**: `PendingTaskQueueScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PendingTaskQueueScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/common/pending-task-queue`)
3. **should_be_visible** (Selector: `pending_task_queue-screen`, Value: `None`)
4. **should_be_visible** (Selector: `pending_task_queue-title`, Value: `None`)
5. **should_be_visible** (Selector: `pending_task_queue-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
