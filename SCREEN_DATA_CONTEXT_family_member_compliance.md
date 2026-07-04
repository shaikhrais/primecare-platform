# SCREEN DATA CONTEXT: family_member_compliance

Below are the database records from `governance.db` used to configure and build the **Family Member - FamilyMemberComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `108`
* **App ID**: `1`
* **Role ID**: `64`
* **Screen Code**: `family_member_compliance`
* **Screen Name**: `FamilyMemberComplianceScreen`
* **Route Path**: `/common/family-member-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/family_member_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `64`
* **Role Code**: `family`
* **Role Name**: `Family Member`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Family Member personnel to oversee, audit, and coordinate operations related to familymembercompliancescreen.`
* **User Story**: `As a Family Member, I want to access the FamilyMemberComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FamilyMemberComplianceScreen`
* **Acceptance Criteria**:
- The FamilyMemberComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Family Member access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_member_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `family_member_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `family_member_compliance-content` (Type: layout, Required: 1)
* **familymembercompliance_btn_1** -> `familymembercompliance-btn-1` (Type: button, Required: 0)
* **familymembercompliance_btn_3** -> `familymembercompliance-btn-3` (Type: button, Required: 0)
* **familymembercompliance_screen** -> `familymembercompliance-screen` (Type: layout, Required: 0)
* **familymembercompliance_title** -> `familymembercompliance-title` (Type: header, Required: 0)
* **familymembercompliance_content** -> `familymembercompliance-content` (Type: layout, Required: 0)
* **familymembercompliance_btn_2** -> `familymembercompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `116` (Required: 1)
* Component ID: `650` (Required: 1)
* Component ID: `1184` (Required: 1)
* Component ID: `2536` (Required: 1)
* Component ID: `2537` (Required: 1)
* Component ID: `2538` (Required: 1)
* Component ID: `2539` (Required: 1)
* Component ID: `2540` (Required: 1)

## 7. API / Data Mapping
* API ID: `4385` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_member_compliance_runtime`
* **Test Name**: `FamilyMemberComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FamilyMemberComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `family`)
2. **visit** (Selector: `None`, Value: `/common/family-member-compliance`)
3. **should_be_visible** (Selector: `family_member_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `family_member_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `family_member_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
