# Clinical Researcher

## Role Summary

* **Role key**: `researcher`
* **Role category**: `research`
* **Total screens**: 2
* **Business ready screens**: 0
* **Incomplete screens**: 2
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 0.0%
* **Average screen-body interactions**: 8.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Research Protocol Manager | `/generated/research-protocol-manager` | 8 | 6 | `MEANINGFUL` | 9 | 2 | study, data-analysis, publication | **No** |
| Research Publication Drafting | `/generated/research-publication-drafting` | 8 | 6 | `MEANINGFUL` | 8 | 2 | protocol, consent, data-analysis | **No** |

## Screen Details

### Research Protocol Manager

* **Route**: `/generated/research-protocol-manager`
* **Component file**: `packages/primecare_ui/lib/src/features/research/research_protocol_manager.dart`
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
* **Business Workflow Score**: 9
* **Role Expectation Score**: 2
* **Missing Business Features**: study, data-analysis, publication
* **Purpose**: Management workspace screen for Research Protocol Manager module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: study, data-analysis, publication
* **Next action**: Implement expected workflows for researcher role.

### Research Publication Drafting

* **Route**: `/generated/research-publication-drafting`
* **Component file**: `packages/primecare_ui/lib/src/features/research/research_publication_drafting.dart`
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
* **Business Workflow Score**: 8
* **Role Expectation Score**: 2
* **Missing Business Features**: protocol, consent, data-analysis
* **Purpose**: Management workspace screen for Research Publication Drafting module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: protocol, consent, data-analysis
* **Next action**: Implement expected workflows for researcher role.

## Screens to Fix First

1. **Research Protocol Manager** (Progress: 0%, Business Score: 9, Role Score: 2)  
   *Reason*: Missing core workflows/features: study, data-analysis, publication
2. **Research Publication Drafting** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: protocol, consent, data-analysis

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Research Protocol Manager (Implement role-specific workflows and transactional features)
- Research Publication Drafting (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
