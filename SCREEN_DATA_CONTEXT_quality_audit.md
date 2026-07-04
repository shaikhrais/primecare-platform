# SCREEN DATA CONTEXT: quality_audit

Below are the database records from `governance.db` used to configure and build the **QA Specialist - QualityAuditScreen** screen.

---

## 1. Screen Record
* **ID**: `565`
* **App ID**: `5`
* **Role ID**: `63`
* **Screen Code**: `quality_audit`
* **Screen Name**: `QualityAuditScreen`
* **Route Path**: `/staff/quality-audit`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/quality_audit_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to qualityauditscreen.`
* **User Story**: `As a QA Specialist, I want to access the QualityAuditScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QualityAuditScreen`
* **Acceptance Criteria**:
- The QualityAuditScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_audit-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_audit-title` (Type: header, Required: 1)
* **primary_content** -> `quality_audit-content` (Type: layout, Required: 1)
* **qualityaudit_loading** -> `qualityaudit-loading` (Type: loading, Required: 0)
* **qualityaudit_title** -> `qualityaudit-title` (Type: header, Required: 0)
* **qualityaudit_btn_3** -> `qualityaudit-btn-3` (Type: button, Required: 0)
* **qualityaudit_btn_1** -> `qualityaudit-btn-1` (Type: button, Required: 0)
* **qualityaudit_btn_2** -> `qualityaudit-btn-2` (Type: button, Required: 0)
* **qualityaudit_screen** -> `qualityaudit-screen` (Type: layout, Required: 0)
* **qualityaudit_btn_5** -> `qualityaudit-btn-5` (Type: button, Required: 0)
* **qualityaudit_content** -> `qualityaudit-content` (Type: layout, Required: 0)
* **qualityaudit_btn_4** -> `qualityaudit-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `489` (Required: 1)
* Component ID: `1023` (Required: 1)
* Component ID: `1557` (Required: 1)
* Component ID: `5946` (Required: 1)
* Component ID: `5947` (Required: 1)
* Component ID: `5948` (Required: 1)
* Component ID: `5949` (Required: 1)
* Component ID: `5950` (Required: 1)

## 7. API / Data Mapping
* API ID: `4912` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_audit_runtime`
* **Test Name**: `QualityAuditScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `QualityAuditScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **visit** (Selector: `None`, Value: `/staff/quality-audit`)
3. **should_be_visible** (Selector: `quality_audit-screen`, Value: `None`)
4. **should_be_visible** (Selector: `quality_audit-title`, Value: `None`)
5. **should_be_visible** (Selector: `quality_audit-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
