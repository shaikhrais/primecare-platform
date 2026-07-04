# SCREEN DATA CONTEXT: telehealth_consultation_room

Below are the database records from `governance.db` used to configure and build the **Guest - TelehealthConsultationRoomScreen** screen.

---

## 1. Screen Record
* **ID**: `1024`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `telehealth_consultation_room`
* **Screen Name**: `TelehealthConsultationRoomScreen`
* **Route Path**: `/generated/telehealth-consultation-room`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/telehealth_consultation_room.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to telehealth consultation room.`
* **User Story**: `As a Guest, I want to access the Telehealth Consultation Room within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Telehealth Consultation Room`
* **Acceptance Criteria**:
- The Telehealth Consultation Room route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `telehealth_consultation_room-screen` (Type: layout, Required: 1)
* **page_title** -> `telehealth_consultation_room-title` (Type: header, Required: 1)
* **primary_content** -> `telehealth_consultation_room-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8626` (Required: 1)
* Component ID: `8627` (Required: 1)
* Component ID: `8628` (Required: 1)
* Component ID: `8629` (Required: 1)
* Component ID: `8630` (Required: 1)
* Component ID: `8631` (Required: 1)
* Component ID: `8632` (Required: 1)

## 7. API / Data Mapping
* API ID: `5490` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `telehealth_consultation_room_runtime`
* **Test Name**: `Telehealth Consultation Room Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Telehealth Consultation Room`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/telehealth-consultation-room`)
3. **should_be_visible** (Selector: `telehealth_consultation_room-screen`, Value: `None`)
4. **should_be_visible** (Selector: `telehealth_consultation_room-title`, Value: `None`)
5. **should_be_visible** (Selector: `telehealth_consultation_room-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
