# Volunteer

## Role Summary

* **Role key**: `volunteer`
* **Role category**: `staff`
* **Total screens**: 1
* **Business ready screens**: 0
* **Incomplete screens**: 1
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 60.0%
* **Average screen-body interactions**: 4.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| VolunteerDashboardScreen | `/staff/volunteer-dashboard` | 4 | 1 | `MEANINGFUL` | 5 | 1 | profile, schedule, project, hours | **No** |

## Screen Details

### VolunteerDashboardScreen

* **Route**: `/staff/volunteer-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 4
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 5
* **Role Expectation Score**: 1
* **Missing Business Features**: profile, schedule, project, hours
* **Purpose**: Management workspace screen for VolunteerDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: profile, schedule, project, hours
* **Next action**: Implement expected workflows for volunteer role.

## Screens to Fix First

1. **VolunteerDashboardScreen** (Progress: 60%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: profile, schedule, project, hours

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- VolunteerDashboardScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
