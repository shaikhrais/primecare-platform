# SCREEN DATA CONTEXT: psw_my_shifts

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswMyShiftsScreen** screen.

---

## 1. Screen Record
* **ID**: `344`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_my_shifts`
* **Screen Name**: `PswMyShiftsScreen`
* **Route Path**: `/offices/clinical/roles/psw/psw-my-shifts`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_my_shifts_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswmyshiftsscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswMyShiftsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswMyShiftsScreen`
* **Acceptance Criteria**:
- The PswMyShiftsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_my_shifts-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_my_shifts-title` (Type: header, Required: 1)
* **primary_content** -> `psw_my_shifts-content` (Type: layout, Required: 1)
* **pswmyshifts_btn_2** -> `pswmyshifts-btn-2` (Type: button, Required: 0)
* **pswmyshifts_btn_3** -> `pswmyshifts-btn-3` (Type: button, Required: 0)
* **pswmyshifts_loading** -> `pswmyshifts-loading` (Type: loading, Required: 0)
* **pswmyshifts_screen** -> `pswmyshifts-screen` (Type: layout, Required: 0)
* **pswmyshifts_title** -> `pswmyshifts-title` (Type: header, Required: 0)
* **pswmyshifts_btn_1** -> `pswmyshifts-btn-1` (Type: button, Required: 0)
* **pswmyshifts_content** -> `pswmyshifts-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `352` (Required: 1)
* Component ID: `886` (Required: 1)
* Component ID: `1420` (Required: 1)
* Component ID: `4634` (Required: 1)
* Component ID: `4635` (Required: 1)
* Component ID: `4636` (Required: 1)
* Component ID: `4637` (Required: 1)
* Component ID: `4638` (Required: 1)
* Component ID: `4639` (Required: 1)
* Component ID: `4640` (Required: 1)
* Component ID: `4641` (Required: 1)
* Component ID: `4642` (Required: 1)
* Component ID: `4643` (Required: 1)

## 7. API / Data Mapping
* API ID: `4677` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_my_shifts_runtime`
* **Test Name**: `Psw My Shifts Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw My Shifts`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/psw-my-shifts`)
3. **should_be_visible** (Selector: `psw_my_shifts-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_my_shifts-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_my_shifts-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
