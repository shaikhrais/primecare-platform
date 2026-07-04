# SCREEN DATA CONTEXT: virtual_waiting_room

Below are the database records from `governance.db` used to configure and build the **Guest - VirtualWaitingRoomScreen** screen.

---

## 1. Screen Record
* **ID**: `1027`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `virtual_waiting_room`
* **Screen Name**: `VirtualWaitingRoomScreen`
* **Route Path**: `/generated/virtual-waiting-room`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/virtual_waiting_room.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to virtual waiting room.`
* **User Story**: `As a Guest, I want to access the Virtual Waiting Room within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Virtual Waiting Room`
* **Acceptance Criteria**:
- The Virtual Waiting Room route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `virtual_waiting_room-screen` (Type: layout, Required: 1)
* **page_title** -> `virtual_waiting_room-title` (Type: header, Required: 1)
* **primary_content** -> `virtual_waiting_room-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8647` (Required: 1)
* Component ID: `8648` (Required: 1)
* Component ID: `8649` (Required: 1)
* Component ID: `8650` (Required: 1)
* Component ID: `8651` (Required: 1)

## 7. API / Data Mapping
* API ID: `5493` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `virtual_waiting_room_runtime`
* **Test Name**: `Virtual Waiting Room Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Virtual Waiting Room`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/virtual-waiting-room`)
3. **should_be_visible** (Selector: `virtual_waiting_room-screen`, Value: `None`)
4. **should_be_visible** (Selector: `virtual_waiting_room-title`, Value: `None`)
5. **should_be_visible** (Selector: `virtual_waiting_room-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
