# SCREEN DATA CONTEXT: pediatric_analytics

Below are the database records from `governance.db` used to configure and build the **Pediatric Specialist - PediatricSpecialistAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `603`
* **App ID**: `1`
* **Role ID**: `11`
* **Screen Code**: `pediatric_analytics`
* **Screen Name**: `PediatricSpecialistAnalyticsScreen`
* **Route Path**: `/clinical/pediatric-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/pediatric_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `11`
* **Role Code**: `pediatric`
* **Role Name**: `Pediatric Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Pediatric Specialist personnel to oversee, audit, and coordinate operations related to pediatric specialist analytics.`
* **User Story**: `As a Pediatric Specialist, I want to access the Pediatric Specialist Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Pediatric Specialist Analytics`
* **Acceptance Criteria**:
- The Pediatric Specialist Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Pediatric Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `pediatric_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `pediatric_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `pediatric_analytics-content` (Type: layout, Required: 1)
* **pediatric specialist analytics_title** -> `pediatric specialist analytics-title` (Type: header, Required: 0)
* **pediatric specialist analytics_btn_3** -> `pediatric specialist analytics-btn-3` (Type: button, Required: 0)
* **pediatric specialist analytics_content** -> `pediatric specialist analytics-content` (Type: layout, Required: 0)
* **pediatric specialist analytics_btn_1** -> `pediatric specialist analytics-btn-1` (Type: button, Required: 0)
* **pediatric specialist analytics_screen** -> `pediatric specialist analytics-screen` (Type: layout, Required: 0)
* **pediatric specialist analytics_btn_2** -> `pediatric specialist analytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `527` (Required: 1)
* Component ID: `1061` (Required: 1)
* Component ID: `1595` (Required: 1)
* Component ID: `6275` (Required: 1)
* Component ID: `6276` (Required: 1)
* Component ID: `6277` (Required: 1)
* Component ID: `6278` (Required: 1)
* Component ID: `6279` (Required: 1)
* Component ID: `6280` (Required: 1)
* Component ID: `6281` (Required: 1)

## 7. API / Data Mapping
* API ID: `4952` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `pediatric_analytics_runtime`
* **Test Name**: `Pediatric Specialist Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Pediatric Specialist Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `pediatric`)
2. **visit** (Selector: `None`, Value: `/clinical/pediatric-analytics`)
3. **should_be_visible** (Selector: `pediatric_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `pediatric_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `pediatric_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
