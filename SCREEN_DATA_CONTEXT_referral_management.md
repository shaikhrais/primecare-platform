# SCREEN DATA CONTEXT: referral_management

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - ReferralManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `549`
* **App ID**: `6`
* **Role ID**: `7`
* **Screen Code**: `referral_management`
* **Screen Name**: `ReferralManagementScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/referral-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/referral_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to referralmanagementscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the ReferralManagementScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ReferralManagementScreen`
* **Acceptance Criteria**:
- The ReferralManagementScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `referral_management-screen` (Type: layout, Required: 1)
* **page_title** -> `referral_management-title` (Type: header, Required: 1)
* **primary_content** -> `referral_management-content` (Type: layout, Required: 1)
* **referralmanagement_screen** -> `referralmanagement-screen` (Type: layout, Required: 0)
* **referralmanagement_title** -> `referralmanagement-title` (Type: header, Required: 0)
* **referralmanagement_btn_1** -> `referralmanagement-btn-1` (Type: button, Required: 0)
* **referralmanagement_btn_2** -> `referralmanagement-btn-2` (Type: button, Required: 0)
* **referralmanagement_btn_3** -> `referralmanagement-btn-3` (Type: button, Required: 0)
* **referralmanagement_content** -> `referralmanagement-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `473` (Required: 1)
* Component ID: `1007` (Required: 1)
* Component ID: `1541` (Required: 1)
* Component ID: `5800` (Required: 1)
* Component ID: `5801` (Required: 1)
* Component ID: `5802` (Required: 1)
* Component ID: `5803` (Required: 1)
* Component ID: `5804` (Required: 1)
* Component ID: `5805` (Required: 1)
* Component ID: `5806` (Required: 1)
* Component ID: `5807` (Required: 1)

## 7. API / Data Mapping
* API ID: `4886` (Required: 1)
* API ID: `4887` (Required: 1)
* API ID: `4888` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `referral_management_runtime`
* **Test Name**: `ReferralManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ReferralManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/referral-management`)
3. **should_be_visible** (Selector: `referral_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `referral_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `referral_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
