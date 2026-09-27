# SCREEN DATA CONTEXT: course_architect_compliance

Below are the database records from `governance.db` used to configure and build the **Training Director - CourseArchitectComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `99`
* **App ID**: `1`
* **Role ID**: `31`
* **Screen Code**: `course_architect_compliance`
* **Screen Name**: `CourseArchitectComplianceScreen`
* **Route Path**: `/common/course-architect-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/course_architect_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `31`
* **Role Code**: `training_director`
* **Role Name**: `Training Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Director personnel to oversee, audit, and coordinate operations related to coursearchitectcompliancescreen.`
* **User Story**: `As a Training Director, I want to access the CourseArchitectComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CourseArchitectComplianceScreen`
* **Acceptance Criteria**:
- The CourseArchitectComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `course_architect_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `course_architect_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `course_architect_compliance-content` (Type: layout, Required: 1)
* **coursearchitectcompliance_screen** -> `coursearchitectcompliance-screen` (Type: layout, Required: 0)
* **coursearchitectcompliance_title** -> `coursearchitectcompliance-title` (Type: header, Required: 0)
* **coursearchitectcompliance_btn_1** -> `coursearchitectcompliance-btn-1` (Type: button, Required: 0)
* **coursearchitectcompliance_btn_2** -> `coursearchitectcompliance-btn-2` (Type: button, Required: 0)
* **coursearchitectcompliance_content** -> `coursearchitectcompliance-content` (Type: layout, Required: 0)
* **coursearchitectcompliance_btn_3** -> `coursearchitectcompliance-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `107` (Required: 1)
* Component ID: `641` (Required: 1)
* Component ID: `1175` (Required: 1)
* Component ID: `2465` (Required: 1)
* Component ID: `2466` (Required: 1)
* Component ID: `2467` (Required: 1)
* Component ID: `2468` (Required: 1)
* Component ID: `2469` (Required: 1)
* Component ID: `2470` (Required: 1)
* Component ID: `2471` (Required: 1)
* Component ID: `2472` (Required: 1)

## 7. API / Data Mapping
* API ID: `4376` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `course_architect_compliance_runtime`
* **Test Name**: `CourseArchitectComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CourseArchitectComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_director`)
2. **visit** (Selector: `None`, Value: `/common/course-architect-compliance`)
3. **should_be_visible** (Selector: `course_architect_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `course_architect_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `course_architect_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
