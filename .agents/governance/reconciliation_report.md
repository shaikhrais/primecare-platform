# PrimeCare Feature Reconciliation Report

## Global Statistics
- **Total Registered Intents:** 38 (Roles)
- **Total Registered Pages:** 266
- **Total Tracked Fields:** 1330

## 🚨 Anomalies & Orphaned Components
✅ All components are fully synchronized. Zero orphans or mismatched intents detected.

## Planned VS Actual Implementation
| Field ID | Page | API Endpoint | DB Table | Status |
|----------|------|--------------|----------|--------|
| `general-manager_dashboard_feed` | `General Manager Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `general-manager_management_feed` | `General Manager Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `general-manager_analytics_feed` | `General Manager Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `general-manager_settings_feed` | `General Manager Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `general-manager_tasks_feed` | `General Manager Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `general-manager_audit-logs_feed` | `General Manager Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `general-manager_intake-form_feed` | `General Manager Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `ceo_dashboard_feed` | `CEO Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `ceo_management_feed` | `CEO Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `ceo_analytics_feed` | `CEO Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `ceo_settings_feed` | `CEO Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `ceo_tasks_feed` | `CEO Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `ceo_audit-logs_feed` | `CEO Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `ceo_intake-form_feed` | `CEO Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `cto_dashboard_feed` | `CTO Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `cto_management_feed` | `CTO Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `cto_analytics_feed` | `CTO Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `cto_settings_feed` | `CTO Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `cto_tasks_feed` | `CTO Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `cto_audit-logs_feed` | `CTO Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `cto_intake-form_feed` | `CTO Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `cfo_dashboard_feed` | `CFO Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `cfo_management_feed` | `CFO Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `cfo_analytics_feed` | `CFO Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `cfo_settings_feed` | `CFO Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `cfo_tasks_feed` | `CFO Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `cfo_audit-logs_feed` | `CFO Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `cfo_intake-form_feed` | `CFO Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `cmo_dashboard_feed` | `CMO Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `cmo_management_feed` | `CMO Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `cmo_analytics_feed` | `CMO Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `cmo_settings_feed` | `CMO Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `cmo_tasks_feed` | `CMO Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `cmo_audit-logs_feed` | `CMO Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `cmo_intake-form_feed` | `CMO Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `coo_dashboard_feed` | `COO Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `coo_management_feed` | `COO Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `coo_analytics_feed` | `COO Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `coo_settings_feed` | `COO Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `coo_tasks_feed` | `COO Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `coo_audit-logs_feed` | `COO Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `coo_intake-form_feed` | `COO Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `vp-of-operations_dashboard_feed` | `VP of Operations Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `vp-of-operations_management_feed` | `VP of Operations Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `vp-of-operations_analytics_feed` | `VP of Operations Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `vp-of-operations_settings_feed` | `VP of Operations Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `vp-of-operations_tasks_feed` | `VP of Operations Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `vp-of-operations_audit-logs_feed` | `VP of Operations Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `vp-of-operations_intake-form_feed` | `VP of Operations Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `vp-of-hr_dashboard_feed` | `VP of HR Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `vp-of-hr_management_feed` | `VP of HR Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `vp-of-hr_analytics_feed` | `VP of HR Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `vp-of-hr_settings_feed` | `VP of HR Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `vp-of-hr_tasks_feed` | `VP of HR Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `vp-of-hr_audit-logs_feed` | `VP of HR Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `vp-of-hr_intake-form_feed` | `VP of HR Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `vp-of-clinical-services_dashboard_feed` | `VP of Clinical Services Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `vp-of-clinical-services_management_feed` | `VP of Clinical Services Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `vp-of-clinical-services_analytics_feed` | `VP of Clinical Services Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `vp-of-clinical-services_settings_feed` | `VP of Clinical Services Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `vp-of-clinical-services_tasks_feed` | `VP of Clinical Services Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `vp-of-clinical-services_audit-logs_feed` | `VP of Clinical Services Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `vp-of-clinical-services_intake-form_feed` | `VP of Clinical Services Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `compliance-director_dashboard_feed` | `Compliance Director Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `compliance-director_management_feed` | `Compliance Director Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `compliance-director_analytics_feed` | `Compliance Director Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `compliance-director_settings_feed` | `Compliance Director Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `compliance-director_tasks_feed` | `Compliance Director Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `compliance-director_audit-logs_feed` | `Compliance Director Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `compliance-director_intake-form_feed` | `Compliance Director Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `privacy-officer_dashboard_feed` | `Privacy Officer Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `privacy-officer_management_feed` | `Privacy Officer Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `privacy-officer_analytics_feed` | `Privacy Officer Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `privacy-officer_settings_feed` | `Privacy Officer Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `privacy-officer_tasks_feed` | `Privacy Officer Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `privacy-officer_audit-logs_feed` | `Privacy Officer Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `privacy-officer_intake-form_feed` | `Privacy Officer Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `regional-manager_dashboard_feed` | `Regional Manager Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `regional-manager_management_feed` | `Regional Manager Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `regional-manager_analytics_feed` | `Regional Manager Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `regional-manager_settings_feed` | `Regional Manager Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `regional-manager_tasks_feed` | `Regional Manager Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `regional-manager_audit-logs_feed` | `Regional Manager Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `regional-manager_intake-form_feed` | `Regional Manager Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `franchise-owner_dashboard_feed` | `Franchise Owner Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `franchise-owner_management_feed` | `Franchise Owner Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `franchise-owner_analytics_feed` | `Franchise Owner Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `franchise-owner_settings_feed` | `Franchise Owner Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `franchise-owner_tasks_feed` | `Franchise Owner Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `franchise-owner_audit-logs_feed` | `Franchise Owner Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `franchise-owner_intake-form_feed` | `Franchise Owner Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `billing-admin_dashboard_feed` | `Billing Admin Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `billing-admin_management_feed` | `Billing Admin Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `billing-admin_analytics_feed` | `Billing Admin Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `billing-admin_settings_feed` | `Billing Admin Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `billing-admin_tasks_feed` | `Billing Admin Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `billing-admin_audit-logs_feed` | `Billing Admin Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `billing-admin_intake-form_feed` | `Billing Admin Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `marketing-manager_dashboard_feed` | `Marketing Manager Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `marketing-manager_management_feed` | `Marketing Manager Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `marketing-manager_analytics_feed` | `Marketing Manager Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `marketing-manager_settings_feed` | `Marketing Manager Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `marketing-manager_tasks_feed` | `Marketing Manager Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `marketing-manager_audit-logs_feed` | `Marketing Manager Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `marketing-manager_intake-form_feed` | `Marketing Manager Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `customer-support_dashboard_feed` | `Customer Support Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `customer-support_management_feed` | `Customer Support Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `customer-support_analytics_feed` | `Customer Support Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `customer-support_settings_feed` | `Customer Support Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `customer-support_tasks_feed` | `Customer Support Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `customer-support_audit-logs_feed` | `Customer Support Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `customer-support_intake-form_feed` | `Customer Support Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `it-support_dashboard_feed` | `IT Support Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `it-support_management_feed` | `IT Support Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `it-support_analytics_feed` | `IT Support Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `it-support_settings_feed` | `IT Support Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `it-support_tasks_feed` | `IT Support Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `it-support_audit-logs_feed` | `IT Support Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `it-support_intake-form_feed` | `IT Support Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `finance-director_dashboard_feed` | `Finance Director Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `finance-director_management_feed` | `Finance Director Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `finance-director_analytics_feed` | `Finance Director Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `finance-director_settings_feed` | `Finance Director Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `finance-director_tasks_feed` | `Finance Director Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `finance-director_audit-logs_feed` | `Finance Director Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `finance-director_intake-form_feed` | `Finance Director Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `payroll-manager_dashboard_feed` | `Payroll Manager Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `payroll-manager_management_feed` | `Payroll Manager Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `payroll-manager_analytics_feed` | `Payroll Manager Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `payroll-manager_settings_feed` | `Payroll Manager Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `payroll-manager_tasks_feed` | `Payroll Manager Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `payroll-manager_audit-logs_feed` | `Payroll Manager Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `payroll-manager_intake-form_feed` | `Payroll Manager Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `hr-director_dashboard_feed` | `HR Director Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `hr-director_management_feed` | `HR Director Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `hr-director_analytics_feed` | `HR Director Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `hr-director_settings_feed` | `HR Director Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `hr-director_tasks_feed` | `HR Director Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `hr-director_audit-logs_feed` | `HR Director Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `hr-director_intake-form_feed` | `HR Director Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `recruiter_dashboard_feed` | `Recruiter Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `recruiter_management_feed` | `Recruiter Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `recruiter_analytics_feed` | `Recruiter Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `recruiter_settings_feed` | `Recruiter Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `recruiter_tasks_feed` | `Recruiter Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `recruiter_audit-logs_feed` | `Recruiter Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `recruiter_intake-form_feed` | `Recruiter Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `clinic-director_dashboard_feed` | `Clinic Director Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `clinic-director_management_feed` | `Clinic Director Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `clinic-director_analytics_feed` | `Clinic Director Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `clinic-director_settings_feed` | `Clinic Director Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `clinic-director_tasks_feed` | `Clinic Director Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `clinic-director_audit-logs_feed` | `Clinic Director Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `clinic-director_intake-form_feed` | `Clinic Director Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `nursing-director_dashboard_feed` | `Nursing Director Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `nursing-director_management_feed` | `Nursing Director Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `nursing-director_analytics_feed` | `Nursing Director Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `nursing-director_settings_feed` | `Nursing Director Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `nursing-director_tasks_feed` | `Nursing Director Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `nursing-director_audit-logs_feed` | `Nursing Director Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `nursing-director_intake-form_feed` | `Nursing Director Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `clinical-supervisor_dashboard_feed` | `Clinical Supervisor Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `clinical-supervisor_management_feed` | `Clinical Supervisor Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `clinical-supervisor_analytics_feed` | `Clinical Supervisor Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `clinical-supervisor_settings_feed` | `Clinical Supervisor Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `clinical-supervisor_tasks_feed` | `Clinical Supervisor Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `clinical-supervisor_audit-logs_feed` | `Clinical Supervisor Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `clinical-supervisor_intake-form_feed` | `Clinical Supervisor Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `quality-assurance_dashboard_feed` | `Quality Assurance Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `quality-assurance_management_feed` | `Quality Assurance Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `quality-assurance_analytics_feed` | `Quality Assurance Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `quality-assurance_settings_feed` | `Quality Assurance Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `quality-assurance_tasks_feed` | `Quality Assurance Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `quality-assurance_audit-logs_feed` | `Quality Assurance Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `quality-assurance_intake-form_feed` | `Quality Assurance Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `intake-coordinator_dashboard_feed` | `Intake Coordinator Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `intake-coordinator_management_feed` | `Intake Coordinator Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `intake-coordinator_analytics_feed` | `Intake Coordinator Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `intake-coordinator_settings_feed` | `Intake Coordinator Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `intake-coordinator_tasks_feed` | `Intake Coordinator Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `intake-coordinator_audit-logs_feed` | `Intake Coordinator Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `intake-coordinator_intake-form_feed` | `Intake Coordinator Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `case-manager_dashboard_feed` | `Case Manager Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `case-manager_management_feed` | `Case Manager Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `case-manager_analytics_feed` | `Case Manager Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `case-manager_settings_feed` | `Case Manager Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `case-manager_tasks_feed` | `Case Manager Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `case-manager_audit-logs_feed` | `Case Manager Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `case-manager_intake-form_feed` | `Case Manager Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `schedulers_dashboard_feed` | `Schedulers Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `schedulers_management_feed` | `Schedulers Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `schedulers_analytics_feed` | `Schedulers Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `schedulers_settings_feed` | `Schedulers Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `schedulers_tasks_feed` | `Schedulers Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `schedulers_audit-logs_feed` | `Schedulers Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `schedulers_intake-form_feed` | `Schedulers Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `care-coordinator_dashboard_feed` | `Care Coordinator Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `care-coordinator_management_feed` | `Care Coordinator Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `care-coordinator_analytics_feed` | `Care Coordinator Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `care-coordinator_settings_feed` | `Care Coordinator Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `care-coordinator_tasks_feed` | `Care Coordinator Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `care-coordinator_audit-logs_feed` | `Care Coordinator Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `care-coordinator_intake-form_feed` | `Care Coordinator Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `super-admin_dashboard_feed` | `Super Admin Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `super-admin_management_feed` | `Super Admin Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `super-admin_analytics_feed` | `Super Admin Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `super-admin_settings_feed` | `Super Admin Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `super-admin_tasks_feed` | `Super Admin Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `super-admin_audit-logs_feed` | `Super Admin Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `super-admin_intake-form_feed` | `Super Admin Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `auditor_dashboard_feed` | `Auditor Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `auditor_management_feed` | `Auditor Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `auditor_analytics_feed` | `Auditor Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `auditor_settings_feed` | `Auditor Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `auditor_tasks_feed` | `Auditor Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `auditor_audit-logs_feed` | `Auditor Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `auditor_intake-form_feed` | `Auditor Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `system-mod_dashboard_feed` | `System Mod Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `system-mod_management_feed` | `System Mod Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `system-mod_analytics_feed` | `System Mod Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `system-mod_settings_feed` | `System Mod Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `system-mod_tasks_feed` | `System Mod Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `system-mod_audit-logs_feed` | `System Mod Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `system-mod_intake-form_feed` | `System Mod Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `client_dashboard_feed` | `Client Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `client_management_feed` | `Client Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `client_analytics_feed` | `Client Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `client_settings_feed` | `Client Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `client_tasks_feed` | `Client Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `client_audit-logs_feed` | `Client Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `client_intake-form_feed` | `Client Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `family-member_dashboard_feed` | `Family Member Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `family-member_management_feed` | `Family Member Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `family-member_analytics_feed` | `Family Member Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `family-member_settings_feed` | `Family Member Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `family-member_tasks_feed` | `Family Member Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `family-member_audit-logs_feed` | `Family Member Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `family-member_intake-form_feed` | `Family Member Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `guardian_dashboard_feed` | `Guardian Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `guardian_management_feed` | `Guardian Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `guardian_analytics_feed` | `Guardian Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `guardian_settings_feed` | `Guardian Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `guardian_tasks_feed` | `Guardian Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `guardian_audit-logs_feed` | `Guardian Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `guardian_intake-form_feed` | `Guardian Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `psw_dashboard_feed` | `PSW Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `psw_management_feed` | `PSW Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `psw_analytics_feed` | `PSW Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `psw_settings_feed` | `PSW Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `psw_tasks_feed` | `PSW Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `psw_audit-logs_feed` | `PSW Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `psw_intake-form_feed` | `PSW Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `rn_dashboard_feed` | `RN Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `rn_management_feed` | `RN Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `rn_analytics_feed` | `RN Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `rn_settings_feed` | `RN Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `rn_tasks_feed` | `RN Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `rn_audit-logs_feed` | `RN Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `rn_intake-form_feed` | `RN Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
| `bha_dashboard_feed` | `BHA Dashboard` | `GET /api/v1/telemetry/dashboard` | `PlatformScreen` | `verified` |
| `bha_management_feed` | `BHA Management` | `GET /api/v1/management/data` | `PlatformScreen` | `verified` |
| `bha_analytics_feed` | `BHA Analytics` | `GET /api/v1/analytics/feed` | `PlatformScreen` | `verified` |
| `bha_settings_feed` | `BHA Settings` | `GET /api/v1/settings/profile` | `PlatformScreen` | `verified` |
| `bha_tasks_feed` | `BHA Tasks` | `GET /api/v1/tasks/queue` | `PlatformScreen` | `verified` |
| `bha_audit-logs_feed` | `BHA Audit-logs` | `GET /api/v1/audit/logs` | `PlatformScreen` | `verified` |
| `bha_intake-form_feed` | `BHA Intake-form` | `POST /api/v1/orchestration/actions` | `ScreenFunctionality` | `verified` |
