# SCREEN DATA CONTEXT: community_health_needs_assessment

Below are the database records from `governance.db` used to configure and build the **Guest - CommunityHealthNeedsAssessmentScreen** screen.

---

## 1. Screen Record
* **ID**: `998`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `community_health_needs_assessment`
* **Screen Name**: `CommunityHealthNeedsAssessmentScreen`
* **Route Path**: `/generated/community-health-needs-assessment`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/community_health_needs_assessment.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to community health needs assessment.`
* **User Story**: `As a Guest, I want to access the Community Health Needs Assessment within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Community Health Needs Assessment`
* **Acceptance Criteria**:
- The Community Health Needs Assessment route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `community_health_needs_assessment-screen` (Type: layout, Required: 1)
* **page_title** -> `community_health_needs_assessment-title` (Type: header, Required: 1)
* **primary_content** -> `community_health_needs_assessment-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8460` (Required: 1)
* Component ID: `8461` (Required: 1)
* Component ID: `8462` (Required: 1)
* Component ID: `8463` (Required: 1)
* Component ID: `8464` (Required: 1)
* Component ID: `8465` (Required: 1)
* Component ID: `8466` (Required: 1)

## 7. API / Data Mapping
* API ID: `5460` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `community_health_needs_assessment_runtime`
* **Test Name**: `Community Health Needs Assessment Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Community Health Needs Assessment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/community-health-needs-assessment`)
3. **should_be_visible** (Selector: `community_health_needs_assessment-screen`, Value: `None`)
4. **should_be_visible** (Selector: `community_health_needs_assessment-title`, Value: `None`)
5. **should_be_visible** (Selector: `community_health_needs_assessment-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
