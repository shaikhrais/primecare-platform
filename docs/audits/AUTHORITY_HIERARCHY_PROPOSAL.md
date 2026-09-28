# Proposed PrimeCare authority hierarchy

Status: administrative reporting approved by the user on 2026-09-28. The original proposal is preserved in `authority_hierarchy_proposals` under `AUTHORITY_REVIEW_20260928`; its approval is recorded separately in `authority_hierarchy_approvals`. All 64 existing active roles are covered. The 10 unresolved/top-level classifications remain unresolved as described below. Reporting is administrative and restricted to the same organization and tenant; it does not authorize clinical practice or data access. Application enforcement is not implemented.

No permission inheritance, account-creation authority, role-assignment authority, or existing permission changes were introduced. Franchise ownership, shareholder oversight, generic roles, and non-staff identities require separate decisions. Existing blanket create/edit/delete grants remain unresolved.

Before enabling user creation, approve explicit creator-role to target-role pairs, tenant boundaries, bootstrap authority and revocation rules. Reporting relationships alone must never be used as permission grants.

| Role | Proposed administrative supervisor |
|---|---|
| Chiropractor | Clinical Director |
| Physiotherapist | Clinical Director |
| Registered Massage Therapist (RMT) | Clinical Director |
| Social Worker | Clinical Director |
| Therapist | Clinical Director |
| Clinical Director | Chief Operating Officer (COO) |
| Intake Coordinator | Clinical Director |
| Registered Nurse (RN) | Registered Nurse (RN) Field Supervisor |
| Physician | Clinical Director |
| Clinical Nurse Specialist | Clinical Director |
| Pediatric Specialist | Clinical Director |
| Caregiver | Registered Nurse (RN) Field Supervisor |
| Guest | Unresolved / no employee reporting line proposed |
| Portal User | Unresolved / no employee reporting line proposed |
| Patient | Unresolved / no employee reporting line proposed |
| Dynamic Screen Viewer | Unresolved / no employee reporting line proposed |
| Infrastructure Auditor | Chief Information Security Officer (CISO) |
| System Verification Officer | Chief Technology Officer (CTO) |
| Training Candidate | Unresolved / no employee reporting line proposed |
| Chief Executive Officer (CEO) | Unresolved / no employee reporting line proposed |
| Chief Financial Officer (CFO) | Chief Executive Officer (CEO) |
| Chief Information Security Officer (CISO) | Chief Executive Officer (CEO) |
| Chief Operating Officer (COO) | Chief Executive Officer (CEO) |
| Chief Technology Officer (CTO) | Chief Executive Officer (CEO) |
| CX Director | Chief Operating Officer (COO) |
| Finance Director | Chief Financial Officer (CFO) |
| HR Director | Chief Executive Officer (CEO) |
| Legal Counsel | Chief Executive Officer (CEO) |
| Franchise Owner | Unresolved / no employee reporting line proposed |
| Shareholder | Unresolved / no employee reporting line proposed |
| Training Director | Chief Operating Officer (COO) |
| Community Outreach Lead | Head of Marketing |
| Compliance Manager | Governance Officer |
| Franchise Sales Manager | Chief Operating Officer (COO) |
| General Manager | Chief Operating Officer (COO) |
| Governance Officer | Chief Executive Officer (CEO) |
| Head of Business Development | Chief Executive Officer (CEO) |
| Head of Marketing | Chief Executive Officer (CEO) |
| Local Marketing Manager | Head of Marketing |
| Operations Manager | General Manager |
| Partnership Manager | Head of Business Development |
| Regional BDM | Head of Business Development |
| Regional Manager USA | Chief Operating Officer (COO) |
| Scrum Master | Chief Technology Officer (CTO) |
| Talent Acquisition Manager | HR Director |
| Territory Expansion Manager | Head of Business Development |
| Territory Sales Manager | Regional BDM |
| Volunteer Coordinator | Operations Manager |
| Premium Concierge Care Coordinator | CX Director |
| VIP Client Manager | CX Director |
| Personal Support Worker (PSW) | Registered Nurse (RN) Field Supervisor |
| Home Support Worker | Registered Nurse (RN) Field Supervisor |
| Registered Nurse (RN) Field Supervisor | Clinical Director |
| Nurse Practitioner (NP) | Clinical Director |
| Registered Practical Nurse (RPN) | Registered Nurse (RN) Field Supervisor |
| Licensed Practical Nurse (LPN) | Registered Nurse (RN) Field Supervisor |
| Employee | Unresolved / no employee reporting line proposed |
| Volunteer | Volunteer Coordinator |
| Administrative Assistant | General Manager |
| Shift Supervisor | Operations Manager |
| Customer Support | CX Director |
| Training Coordinator | Training Director |
| QA Specialist | Compliance Manager |
| Family Member | Unresolved / no employee reporting line proposed |

Migration: `python3 scripts/propose-authority-governance.py --apply`. Default execution validates without writing. Apply is idempotent and preserves an existing proposal for review. A local SQLite backup is created before the first application; it must not be committed because it duplicates sensitive governance contents.
