# SCREEN DATA CONTEXT: quality_assurance_compliance

Below are the database records from `governance.db` used to configure and build the **QA Specialist - QualityAssuranceComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `264`
* **App ID**: `1`
* **Role ID**: `63`
* **Screen Code**: `quality_assurance_compliance`
* **Screen Name**: `QualityAssuranceComplianceScreen`
* **Route Path**: `/staff/quality-assurance-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_compliance_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to qualityassurancecompliancescreen.`
* **User Story**: `As a QA Specialist, I want to access the QualityAssuranceComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QualityAssuranceComplianceScreen`
* **Acceptance Criteria**:
- The QualityAssuranceComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_compliance-content` (Type: layout, Required: 1)
* **qualityassurancecompliance_btn_4** -> `qualityassurancecompliance-btn-4` (Type: button, Required: 0)
* **qualityassurancecompliance_btn_1** -> `qualityassurancecompliance-btn-1` (Type: button, Required: 0)
* **qualityassurancecompliance_btn_2** -> `qualityassurancecompliance-btn-2` (Type: button, Required: 0)
* **qualityassurancecompliance_content** -> `qualityassurancecompliance-content` (Type: layout, Required: 0)
* **qualityassurancecompliance_screen** -> `qualityassurancecompliance-screen` (Type: layout, Required: 0)
* **qualityassurancecompliance_btn_3** -> `qualityassurancecompliance-btn-3` (Type: button, Required: 0)
* **qualityassurancecompliance_title** -> `qualityassurancecompliance-title` (Type: header, Required: 0)
* **qualityassurancecompliance_btn_5** -> `qualityassurancecompliance-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `272` (Required: 1)
* Component ID: `806` (Required: 1)
* Component ID: `1340` (Required: 1)
* Component ID: `3951` (Required: 1)
* Component ID: `3952` (Required: 1)
* Component ID: `3953` (Required: 1)
* Component ID: `3954` (Required: 1)
* Component ID: `3955` (Required: 1)
* Component ID: `3956` (Required: 1)
* Component ID: `3957` (Required: 1)
* Component ID: `3958` (Required: 1)
* Component ID: `3959` (Required: 1)

## 7. API / Data Mapping
* API ID: `4585` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_compliance_runtime`
* **Test Name**: `QualityAssuranceComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Quality Assurance Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Quality Assurance Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Quality Assurance Compliance`)
5. **check_url** (Selector: `None`, Value: `/staff/quality-assurance-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
