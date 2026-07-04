# SCREEN DATA CONTEXT: f_a_q_manager

Below are the database records from `governance.db` used to configure and build the **Guest - FAQManagerScreen** screen.

---

## 1. Screen Record
* **ID**: `911`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `f_a_q_manager`
* **Screen Name**: `FAQManagerScreen`
* **Route Path**: `/generated/f-a-q-manager`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/faq_manager_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to f a q manager.`
* **User Story**: `As a Guest, I want to access the F A Q Manager within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `F A Q Manager`
* **Acceptance Criteria**:
- The F A Q Manager route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `f_a_q_manager-screen` (Type: layout, Required: 1)
* **page_title** -> `f_a_q_manager-title` (Type: header, Required: 1)
* **primary_content** -> `f_a_q_manager-content` (Type: layout, Required: 1)
* **faq_manager_screen_textbutton_button_2** -> `faq_manager_screen_textbutton_button_2` (Type: button, Required: 0)
* **faq_manager_screen_iconbutton_button_1** -> `faq_manager_screen_iconbutton_button_1` (Type: button, Required: 0)
* **faq_manager_screen_textbutton_button_1** -> `faq_manager_screen_textbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8007` (Required: 1)
* Component ID: `8008` (Required: 1)
* Component ID: `8009` (Required: 1)
* Component ID: `8010` (Required: 1)

## 7. API / Data Mapping
* API ID: `5331` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `f_a_q_manager_runtime`
* **Test Name**: `F A Q Manager Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `F A Q Manager`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/f-a-q-manager`)
3. **should_be_visible** (Selector: `f_a_q_manager-screen`, Value: `None`)
4. **should_be_visible** (Selector: `f_a_q_manager-title`, Value: `None`)
5. **should_be_visible** (Selector: `f_a_q_manager-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
