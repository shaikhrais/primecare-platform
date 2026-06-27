# Governance Officer

## Role Summary

* **Role key**: `governance`
* **Role category**: `management`
* **Total screens**: 8
* **Business ready screens**: 3
* **Incomplete screens**: 8
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 1
* **Average progress**: 53.8%
* **Average screen-body interactions**: 2.1

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ArchitecturePlanningDashboardScreen | `/common/architecture-planning-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 3 | verification, database-drift | **Yes** |
| ArchitecturePlanningWorkflowScreen | `/common/architecture-planning-workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 3 | verification, database-drift | **Yes** |
| SharedScreenStubs | `/common/shared-stubs` | 2 | 0 | `LOW_INTERACTION` | 3 | 2 | verification, database-drift, sweep | **No** |
| FileVerificationDashboardScreen | `/common/file-verification-dashboard` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | database-drift, sweep | **Yes** |
| RoleCoverageDashboardScreen | `/common/role-coverage-dashboard` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | verification, database-drift, sweep | **No** |
| Screen Audit | `/generated/screen-audit` | 5 | 0 | `MEANINGFUL` | 3 | 2 | verification, database-drift, sweep | **No** |
| Screen Not Implemented | `/generated/screen-not-implemented` | 2 | 0 | `LOW_INTERACTION` | 3 | 2 | verification, database-drift, sweep | **No** |
| ScreenProgressDashboardScreen | `/management/screen-progress-dashboard` | 0 | 1 | `READ_ONLY_VALID` | 3 | 0 | audit, verification, compliance, database-drift, sweep | **No** |

## Screen Details

### ArchitecturePlanningDashboardScreen

* **Route**: `/common/architecture-planning-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 5
* **Role Expectation Score**: 3
* **Missing Business Features**: verification, database-drift
* **Purpose**: Management workspace screen for ArchitecturePlanningDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ArchitecturePlanningWorkflowScreen

* **Route**: `/common/architecture-planning-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/architecture_planning_workflow_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 2
* **Role Expectation Score**: 3
* **Missing Business Features**: verification, database-drift
* **Purpose**: Operational workflow configuration and tracking screen for ArchitecturePlanningWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### SharedScreenStubs

* **Route**: `/common/shared-stubs`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/shared_screen_stubs.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: verification, database-drift, sweep
* **Purpose**: Management workspace screen for SharedScreenStubs module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FileVerificationDashboardScreen

* **Route**: `/common/file-verification-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/file_verification_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 4
* **Role Expectation Score**: 3
* **Missing Business Features**: database-drift, sweep
* **Purpose**: Platform governance dashboard to view audit trails, runtime checks, database drift, and telemetry logs.
* **Primary user goal**: Verify system integrity, inspect security audit logs, and remediate registry configuration drift.
* **Expected user actions**: Run security sweep, download compliance audit files, approve database schema alterations.
* **Business reason**: Maintains platform regulatory security standards and code governance control rooms.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RoleCoverageDashboardScreen

* **Route**: `/common/role-coverage-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/role_coverage_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: verification, database-drift, sweep
* **Purpose**: Management workspace screen for RoleCoverageDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Screen Audit

* **Route**: `/generated/screen-audit`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/audit_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 5
  * **Buttons**: 5
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: verification, database-drift, sweep
* **Purpose**: Platform governance dashboard to view audit trails, runtime checks, database drift, and telemetry logs.
* **Primary user goal**: Verify system integrity, inspect security audit logs, and remediate registry configuration drift.
* **Expected user actions**: Run security sweep, download compliance audit files, approve database schema alterations.
* **Business reason**: Maintains platform regulatory security standards and code governance control rooms.
* **Missing items**: Missing core role features: verification, database-drift, sweep
* **Next action**: Implement expected workflows for governance role.

### Screen Not Implemented

* **Route**: `/generated/screen-not-implemented`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/shared_screen_stubs.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: verification, database-drift, sweep
* **Purpose**: Management workspace screen for Screen Not Implemented module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ScreenProgressDashboardScreen

* **Route**: `/management/screen-progress-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/screen_progress_dashboard.dart`
* **Current stage**: Stage 7
* **Progress %**: 70%
* **Visual status**: `NON_INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `READ_ONLY_VALID`
* **Screen Body Interactions**: 0
  * **Buttons**: 0
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 0
* **Missing Business Features**: audit, verification, compliance, database-drift, sweep
* **Purpose**: Non-interactive visual placeholder. Screen has no actionable widgets or controls.
* **Primary user goal**: None - no user goals can be accomplished on this screen.
* **Expected user actions**: None
* **Business reason**: Empty stub or placeholder showing no read-only or transactional value.
* **Missing items**: Missing core role features: audit, verification, compliance, database-drift, sweep
* **Next action**: Implement expected workflows for governance role.

## Screens to Fix First

1. **SharedScreenStubs** (Progress: 50%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: verification, database-drift, sweep
2. **Screen Audit** (Progress: 50%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: verification, database-drift, sweep
3. **Screen Not Implemented** (Progress: 50%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: verification, database-drift, sweep
4. **RoleCoverageDashboardScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: verification, database-drift, sweep
5. **ScreenProgressDashboardScreen** (Progress: 70%, Business Score: 3, Role Score: 0)  
   *Reason*: Missing core workflows/features: audit, verification, compliance, database-drift, sweep

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- SharedScreenStubs (Implement role-specific workflows and transactional features)
- Screen Audit (Implement role-specific workflows and transactional features)
- Screen Not Implemented (Implement role-specific workflows and transactional features)
- RoleCoverageDashboardScreen (Implement role-specific workflows and transactional features)
- ScreenProgressDashboardScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- ArchitecturePlanningWorkflowScreen (Micro-interactions and design alignment polish)
- ArchitecturePlanningDashboardScreen (Micro-interactions and design alignment polish)
- FileVerificationDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
