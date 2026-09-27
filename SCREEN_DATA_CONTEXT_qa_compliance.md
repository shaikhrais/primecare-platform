# SCREEN DATA CONTEXT: qa_compliance

Below are the database records from `governance.db` used to configure and build the **QA Specialist - QaComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `135`
* **App ID**: `1`
* **Role ID**: `63`
* **Screen Code**: `qa_compliance`
* **Screen Name**: `QaComplianceScreen`
* **Route Path**: `/common/qa-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/qa_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to qacompliancescreen.`
* **User Story**: `As a QA Specialist, I want to access the QaComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QaComplianceScreen`
* **Acceptance Criteria**:
- The QaComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `qa_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `qa_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `qa_compliance-content` (Type: layout, Required: 1)
* **qacompliance_loading** -> `qacompliance-loading` (Type: loading, Required: 0)
* **qacompliance_btn_2** -> `qacompliance-btn-2` (Type: button, Required: 0)
* **qacompliance_title** -> `qacompliance-title` (Type: header, Required: 0)
* **qacompliance_btn_1** -> `qacompliance-btn-1` (Type: button, Required: 0)
* **qacompliance_content** -> `qacompliance-content` (Type: layout, Required: 0)
* **qacompliance_btn_3** -> `qacompliance-btn-3` (Type: button, Required: 0)
* **qacompliance_screen** -> `qacompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `143` (Required: 1)
* Component ID: `677` (Required: 1)
* Component ID: `1211` (Required: 1)
* Component ID: `2755` (Required: 1)
* Component ID: `2756` (Required: 1)
* Component ID: `2757` (Required: 1)
* Component ID: `2758` (Required: 1)
* Component ID: `2759` (Required: 1)
* Component ID: `2760` (Required: 1)
* Component ID: `2761` (Required: 1)
* Component ID: `2762` (Required: 1)
* Component ID: `2763` (Required: 1)

## 7. API / Data Mapping
* API ID: `4418` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `qa_compliance_runtime`
* **Test Name**: `QaComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `QaComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **visit** (Selector: `None`, Value: `/common/qa-compliance`)
3. **should_be_visible** (Selector: `qa_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `qa_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `qa_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
