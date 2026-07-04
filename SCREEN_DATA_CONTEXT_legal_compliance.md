# SCREEN DATA CONTEXT: legal_compliance

Below are the database records from `governance.db` used to configure and build the **Legal Counsel - LegalComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `175`
* **App ID**: `1`
* **Role ID**: `28`
* **Screen Code**: `legal_compliance`
* **Screen Name**: `LegalComplianceScreen`
* **Route Path**: `/executive/legal-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/legal_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `28`
* **Role Code**: `legal`
* **Role Name**: `Legal Counsel`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Legal Counsel personnel to oversee, audit, and coordinate operations related to legalcompliancescreen.`
* **User Story**: `As a Legal Counsel, I want to access the LegalComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LegalComplianceScreen`
* **Acceptance Criteria**:
- The LegalComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Legal Counsel access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `legal_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `legal_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `legal_compliance-content` (Type: layout, Required: 1)
* **legalcompliance_btn_1** -> `legalcompliance-btn-1` (Type: button, Required: 0)
* **legalcompliance_loading** -> `legalcompliance-loading` (Type: loading, Required: 0)
* **legalcompliance_btn_2** -> `legalcompliance-btn-2` (Type: button, Required: 0)
* **legalcompliance_btn_3** -> `legalcompliance-btn-3` (Type: button, Required: 0)
* **legalcompliance_content** -> `legalcompliance-content` (Type: layout, Required: 0)
* **legalcompliance_title** -> `legalcompliance-title` (Type: header, Required: 0)
* **legalcompliance_screen** -> `legalcompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `183` (Required: 1)
* Component ID: `717` (Required: 1)
* Component ID: `1251` (Required: 1)
* Component ID: `3129` (Required: 1)
* Component ID: `3130` (Required: 1)
* Component ID: `3131` (Required: 1)
* Component ID: `3132` (Required: 1)
* Component ID: `3133` (Required: 1)
* Component ID: `3134` (Required: 1)
* Component ID: `3135` (Required: 1)
* Component ID: `3136` (Required: 1)
* Component ID: `3137` (Required: 1)
* Component ID: `3138` (Required: 1)

## 7. API / Data Mapping
* API ID: `4464` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `legal_compliance_runtime`
* **Test Name**: `LegalComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `LegalComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `legal`)
2. **visit** (Selector: `None`, Value: `/executive/legal-compliance`)
3. **should_be_visible** (Selector: `legal_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `legal_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `legal_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
