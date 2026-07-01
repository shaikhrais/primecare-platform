# SCREEN DATA CONTEXT: emergency_contacts

Below are the database records from `governance.db` used to configure and build the **Family Member - EmergencyContactsScreen** screen.

---

## 1. Screen Record
* **ID**: `576`
* **App ID**: `5`
* **Role ID**: `64`
* **Screen Code**: `emergency_contacts`
* **Screen Name**: `EmergencyContactsScreen`
* **Route Path**: `/common/emergency-contacts`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/emergency_contacts_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `64`
* **Role Code**: `family`
* **Role Name**: `Family Member`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Family Member personnel to oversee, audit, and coordinate operations related to emergencycontactsscreen.`
* **User Story**: `As a Family Member, I want to access the EmergencyContactsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `EmergencyContactsScreen`
* **Acceptance Criteria**:
- The EmergencyContactsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Family Member access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `emergency_contacts-screen` (Type: layout, Required: 1)
* **page_title** -> `emergency_contacts-title` (Type: header, Required: 1)
* **primary_content** -> `emergency_contacts-content` (Type: layout, Required: 1)
* **emergencycontacts_btn_3** -> `emergencycontacts-btn-3` (Type: button, Required: 0)
* **emergencycontacts_screen** -> `emergencycontacts-screen` (Type: layout, Required: 0)
* **emergencycontacts_title** -> `emergencycontacts-title` (Type: header, Required: 0)
* **emergencycontacts_content** -> `emergencycontacts-content` (Type: layout, Required: 0)
* **emergencycontacts_btn_1** -> `emergencycontacts-btn-1` (Type: button, Required: 0)
* **emergencycontacts_btn_2** -> `emergencycontacts-btn-2` (Type: button, Required: 0)
* **emergencycontacts_loading** -> `emergencycontacts-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `500` (Required: 1)
* Component ID: `1034` (Required: 1)
* Component ID: `1568` (Required: 1)
* Component ID: `6016` (Required: 1)
* Component ID: `6017` (Required: 1)
* Component ID: `6018` (Required: 1)
* Component ID: `6019` (Required: 1)
* Component ID: `6020` (Required: 1)
* Component ID: `6021` (Required: 1)
* Component ID: `6022` (Required: 1)

## 7. API / Data Mapping
* API ID: `4923` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `emergency_contacts_runtime`
* **Test Name**: `EmergencyContactsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Emergency Contacts`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `family`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Emergency Contacts`)
4. **click_sidebar_link** (Selector: `None`, Value: `Emergency Contacts`)
5. **check_url** (Selector: `None`, Value: `/common/emergency-contacts`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
