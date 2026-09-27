# Telehealth Provider

## Role Summary

* **Role key**: `telehealth_provider`
* **Role category**: `telehealth`
* **Total screens**: 2
* **Business ready screens**: 1
* **Incomplete screens**: 2
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 0.0%
* **Average screen-body interactions**: 8.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Telehealth Consultation Room | `/generated/telehealth-consultation-room` | 8 | 6 | `MEANINGFUL` | 8 | 3 | virtual, appointment | **Yes** |
| Telehealth Quality Metrics | `/generated/telehealth-quality-metrics` | 8 | 6 | `MEANINGFUL` | 7 | 2 | virtual, appointment, consultation | **No** |

## Screen Details

### Telehealth Consultation Room

* **Route**: `/generated/telehealth-consultation-room`
* **Component file**: `packages/primecare_ui/lib/src/features/telehealth/telehealth_consultation_room.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 8
* **Role Expectation Score**: 3
* **Missing Business Features**: virtual, appointment
* **Purpose**: Management workspace screen for Telehealth Consultation Room module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Telehealth Quality Metrics

* **Route**: `/generated/telehealth-quality-metrics`
* **Component file**: `packages/primecare_ui/lib/src/features/telehealth/telehealth_quality_metrics.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 2
* **Missing Business Features**: virtual, appointment, consultation
* **Purpose**: Management workspace screen for Telehealth Quality Metrics module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: virtual, appointment, consultation
* **Next action**: Implement expected workflows for telehealth_provider role.

## Screens to Fix First

1. **Telehealth Quality Metrics** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: virtual, appointment, consultation

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Telehealth Quality Metrics (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Telehealth Consultation Room (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
