import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';
import '../components/generic_feature_screen.dart';

import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';

import '../offices/shared_screens/global_settings.dart';
import '../offices/shared_screens/global_profile.dart';
import '../offices/shared_screens/notification_center.dart';
import '../offices/shared_screens/messaging_hub.dart';
import '../offices/shared_screens/document_vault.dart';

import '../components/layouts/master_layout.dart';

import '../offices/corporate/roles/ceo/analytics_dashboard.dart' as ceo_dash;
import '../offices/corporate/roles/coo/coo_dashboard.dart' as coo_dash;
import '../offices/corporate/roles/cfo/cfo_dashboard.dart' as cfo_dash;
import '../offices/corporate/roles/cto/cto_dashboard.dart' as cto_dash;
import '../offices/corporate/roles/compliance_manager/compliance_dashboard.dart'
    as compliance_manager_dash;
import '../offices/corporate/roles/head_of_bus_dev/bus_dev_dashboard.dart'
    as head_of_bus_dev_dash;
import '../offices/marketing/roles/head_of_marketing/marketing_director_dashboard.dart'
    as head_of_marketing_dash;
import '../offices/corporate/roles/training_director/training_admin_dashboard.dart'
    as training_director_dash;
import '../offices/business_development/roles/regional_manager_ontario/region_dashboard.dart'
    as regional_manager_ontario_dash;
import '../offices/business_development/roles/regional_manager_usa/region_dashboard.dart'
    as regional_manager_usa_dash;
import '../offices/business_development/roles/franchise_sales_manager/pipeline_dashboard.dart'
    as franchise_sales_manager_dash;
import '../offices/business_development/roles/general_manager/ops_dashboard.dart'
    as general_manager_dash;
import '../offices/business_development/roles/partnership_manager/partner_dashboard.dart'
    as partnership_manager_dash;
import '../offices/business_development/roles/territory_expansion_manager/expansion_analytics_dashboard.dart'
    as territory_expansion_manager_dash;
import '../offices/franchise/roles/franchise_owner/owner_dashboard.dart'
    as franchise_owner_dash;
import '../offices/franchise/roles/operations_manager/ops_manager_dashboard.dart'
    as operations_manager_dash;
import '../offices/franchise/roles/scheduler/scheduling_dashboard.dart'
    as scheduler_dash;
import '../offices/franchise/roles/billing_admin/billing_dashboard.dart'
    as billing_admin_dash;
import '../offices/franchise/roles/hr_hiring/hr_dashboard.dart'
    as hr_hiring_dash;
import '../offices/clinic/roles/rn/rn_dashboard.dart' as rn_dash;
import '../offices/clinic/roles/rpn/rpn_dashboard.dart' as rpn_dash;
import '../offices/clinic/roles/rmt/rmt_dashboard.dart' as rmt_dash;
import '../offices/clinic/roles/psw/psw_dashboard.dart' as psw_dash;
import '../offices/clinic/roles/psw/todays_shifts.dart' as psw_todays_shifts;
import '../offices/clinic/roles/psw/assigned_clients.dart'
    as psw_assigned_clients;
import '../offices/clinic/roles/psw/care_tasks.dart' as psw_care_tasks;
import '../offices/clinic/roles/psw/adl_tracking.dart' as psw_adl_tracking;
import '../offices/clinic/roles/psw/daily_logs.dart' as psw_daily_logs;
import '../offices/clinic/roles/psw/check_in_out.dart' as psw_check_in_out;
import '../offices/clinic/roles/psw/client_updates.dart' as psw_client_updates;
import '../offices/clinic/roles/psw/incident_reports.dart'
    as psw_incident_reports;
import '../offices/clinic/roles/psw/completed_visits.dart'
    as psw_completed_visits;
import '../offices/clinic/roles/psw/documents.dart' as psw_documents;
import '../offices/clinic/roles/psw/settings.dart' as psw_settings;
import '../offices/support/roles/customer_support/support_dashboard.dart'
    as customer_support_dash;
import '../offices/support/roles/intake_coordinator/intake_dashboard.dart'
    as intake_coordinator_dash;
import '../offices/support/roles/quality_assurance/qa_dashboard.dart'
    as quality_assurance_dash;
import '../offices/support/roles/training_coordinator/training_modules.dart'
    as training_coordinator_dash;
import '../offices/marketing/roles/local_marketing_manager/local_marketing_dashboard.dart'
    as local_marketing_manager_dash;
import '../offices/marketing/roles/community_outreach/community_dashboard.dart'
    as community_outreach_dash;
import '../offices/marketing/roles/territory_sales_manager/sales_dashboard.dart'
    as territory_sales_manager_dash;
import '../offices/client/roles/client/client_dashboard.dart' as patient_dash;
import '../offices/corporate/roles/ceo/enterprise_overview.dart'
    as ceo_enterprise_overview;
import '../offices/corporate/roles/ceo/franchise_overview.dart'
    as ceo_franchise_overview;
import '../offices/corporate/roles/ceo/region_performance.dart'
    as ceo_region_performance;
import '../offices/corporate/roles/ceo/revenue_summary.dart'
    as ceo_revenue_summary;
import '../offices/corporate/roles/ceo/strategic_kpis.dart'
    as ceo_strategic_kpis;
import '../offices/corporate/roles/ceo/growth_pipeline.dart'
    as ceo_growth_pipeline;
import '../offices/corporate/roles/ceo/leadership_reports.dart'
    as ceo_leadership_reports;
import '../offices/corporate/roles/ceo/alerts_and_risks.dart'
    as ceo_alerts_and_risks;
import '../offices/corporate/roles/ceo/organization_map.dart'
    as ceo_organization_map;
import '../offices/corporate/roles/ceo/approvals.dart' as ceo_approvals;
import '../offices/corporate/roles/ceo/reports.dart' as ceo_reports;
import '../offices/corporate/roles/coo/operations_overview.dart'
    as coo_operations_overview;
import '../offices/corporate/roles/coo/branch_operations.dart'
    as coo_branch_operations;
import '../offices/corporate/roles/coo/staffing_efficiency.dart'
    as coo_staffing_efficiency;
import '../offices/corporate/roles/coo/scheduling_health.dart'
    as coo_scheduling_health;
import '../offices/corporate/roles/coo/service_delivery.dart'
    as coo_service_delivery;
import '../offices/corporate/roles/coo/issue_escalations.dart'
    as coo_issue_escalations;
import '../offices/corporate/roles/coo/compliance_view.dart'
    as coo_compliance_view;
import '../offices/corporate/roles/coo/workflow_performance.dart'
    as coo_workflow_performance;
import '../offices/corporate/roles/coo/branch_comparison.dart'
    as coo_branch_comparison;
import '../offices/corporate/roles/coo/reports.dart' as coo_reports;
import '../offices/corporate/roles/cfo/financial_overview.dart'
    as cfo_financial_overview;
import '../offices/corporate/roles/cfo/revenue.dart' as cfo_revenue;
import '../offices/corporate/roles/cfo/expenses.dart' as cfo_expenses;
import '../offices/corporate/roles/cfo/franchise_financials.dart'
    as cfo_franchise_financials;
import '../offices/corporate/roles/cfo/payroll.dart' as cfo_payroll;
import '../offices/corporate/roles/cfo/accounts_receivable.dart'
    as cfo_accounts_receivable;
import '../offices/corporate/roles/cfo/accounts_payable.dart'
    as cfo_accounts_payable;
import '../offices/corporate/roles/cfo/invoices.dart' as cfo_invoices;
import '../offices/corporate/roles/cfo/profitability.dart' as cfo_profitability;
import '../offices/corporate/roles/cfo/tax_and_remittance.dart'
    as cfo_tax_and_remittance;
import '../offices/corporate/roles/cfo/reports.dart' as cfo_reports;
import '../offices/corporate/roles/cto/system_health.dart' as cto_system_health;
import '../offices/corporate/roles/cto/platform_usage.dart'
    as cto_platform_usage;
import '../offices/corporate/roles/cto/feature_adoption.dart'
    as cto_feature_adoption;
import '../offices/corporate/roles/cto/api_monitoring.dart'
    as cto_api_monitoring;
import '../offices/corporate/roles/cto/integrations.dart' as cto_integrations;
import '../offices/corporate/roles/cto/audit_logs.dart' as cto_audit_logs;
import '../offices/corporate/roles/cto/access_control.dart'
    as cto_access_control;
import '../offices/corporate/roles/cto/release_management.dart'
    as cto_release_management;
import '../offices/corporate/roles/cto/issue_tracking.dart'
    as cto_issue_tracking;
import '../offices/corporate/roles/cto/infrastructure.dart'
    as cto_infrastructure;
import '../offices/corporate/roles/cto/reports.dart' as cto_reports;
import '../offices/corporate/roles/compliance_manager/compliance_cases.dart'
    as compliance_manager_compliance_cases;
import '../offices/corporate/roles/compliance_manager/policies.dart'
    as compliance_manager_policies;
import '../offices/corporate/roles/compliance_manager/audits.dart'
    as compliance_manager_audits;
import '../offices/corporate/roles/compliance_manager/incident_review.dart'
    as compliance_manager_incident_review;
import '../offices/corporate/roles/compliance_manager/credential_tracking.dart'
    as compliance_manager_credential_tracking;
import '../offices/corporate/roles/compliance_manager/document_expiry.dart'
    as compliance_manager_document_expiry;
import '../offices/corporate/roles/compliance_manager/risk_register.dart'
    as compliance_manager_risk_register;
import '../offices/corporate/roles/compliance_manager/corrective_actions.dart'
    as compliance_manager_corrective_actions;
import '../offices/corporate/roles/compliance_manager/training_compliance.dart'
    as compliance_manager_training_compliance;
import '../offices/corporate/roles/compliance_manager/reports.dart'
    as compliance_manager_reports;
import '../offices/clinic/roles/head_of_business_development/lead_pipeline.dart'
    as head_of_business_development_lead_pipeline;
import '../offices/clinic/roles/head_of_business_development/franchise_pipeline.dart'
    as head_of_business_development_franchise_pipeline;
import '../offices/clinic/roles/head_of_business_development/territory_map.dart'
    as head_of_business_development_territory_map;
import '../offices/clinic/roles/head_of_business_development/partnerships.dart'
    as head_of_business_development_partnerships;
import '../offices/clinic/roles/head_of_business_development/opportunities.dart'
    as head_of_business_development_opportunities;
import '../offices/clinic/roles/head_of_business_development/sales_performance.dart'
    as head_of_business_development_sales_performance;
import '../offices/clinic/roles/head_of_business_development/expansion_forecast.dart'
    as head_of_business_development_expansion_forecast;
import '../offices/clinic/roles/head_of_business_development/reports.dart'
    as head_of_business_development_reports;
import '../offices/marketing/roles/head_of_marketing/campaigns.dart'
    as head_of_marketing_campaigns;
import '../offices/marketing/roles/head_of_marketing/leads.dart'
    as head_of_marketing_leads;
import '../offices/marketing/roles/head_of_marketing/funnel_analytics.dart'
    as head_of_marketing_funnel_analytics;
import '../offices/marketing/roles/head_of_marketing/brand_assets.dart'
    as head_of_marketing_brand_assets;
import '../offices/marketing/roles/head_of_marketing/regional_campaigns.dart'
    as head_of_marketing_regional_campaigns;
import '../offices/marketing/roles/head_of_marketing/content_approval.dart'
    as head_of_marketing_content_approval;
import '../offices/marketing/roles/head_of_marketing/performance_reports.dart'
    as head_of_marketing_performance_reports;
import '../offices/corporate/roles/training_director/training_programs.dart'
    as training_director_training_programs;
import '../offices/corporate/roles/training_director/staff_training_matrix.dart'
    as training_director_staff_training_matrix;
import '../offices/corporate/roles/training_director/compliance_training.dart'
    as training_director_compliance_training;
import '../offices/corporate/roles/training_director/course_library.dart'
    as training_director_course_library;
import '../offices/corporate/roles/training_director/assessments.dart'
    as training_director_assessments;
import '../offices/corporate/roles/training_director/certifications.dart'
    as training_director_certifications;
import '../offices/corporate/roles/training_director/trainer_assignments.dart'
    as training_director_trainer_assignments;
import '../offices/corporate/roles/training_director/reports.dart'
    as training_director_reports;
import '../offices/business_development/roles/regional_bdm/leads.dart'
    as regional_bdm_leads;
import '../offices/business_development/roles/regional_bdm/franchise_pipeline.dart'
    as regional_bdm_franchise_pipeline;
import '../offices/business_development/roles/regional_bdm/territory_growth.dart'
    as regional_bdm_territory_growth;
import '../offices/business_development/roles/regional_bdm/meetings.dart'
    as regional_bdm_meetings;
import '../offices/business_development/roles/regional_bdm/deal_tracker.dart'
    as regional_bdm_deal_tracker;
import '../offices/business_development/roles/regional_bdm/partners.dart'
    as regional_bdm_partners;
import '../offices/business_development/roles/regional_bdm/competitor_notes.dart'
    as regional_bdm_competitor_notes;
import '../offices/business_development/roles/regional_bdm/tasks.dart'
    as regional_bdm_tasks;
import '../offices/business_development/roles/regional_bdm/reports.dart'
    as regional_bdm_reports;
import '../offices/business_development/roles/franchise_sales_manager/leads.dart'
    as franchise_sales_manager_leads;
import '../offices/business_development/roles/franchise_sales_manager/prospects.dart'
    as franchise_sales_manager_prospects;
import '../offices/business_development/roles/franchise_sales_manager/discovery_calls.dart'
    as franchise_sales_manager_discovery_calls;
import '../offices/business_development/roles/franchise_sales_manager/proposals.dart'
    as franchise_sales_manager_proposals;
import '../offices/business_development/roles/franchise_sales_manager/sales_pipeline.dart'
    as franchise_sales_manager_sales_pipeline;
import '../offices/business_development/roles/franchise_sales_manager/contracts.dart'
    as franchise_sales_manager_contracts;
import '../offices/business_development/roles/franchise_sales_manager/follow_ups.dart'
    as franchise_sales_manager_follow_ups;
import '../offices/business_development/roles/franchise_sales_manager/reports.dart'
    as franchise_sales_manager_reports;
import '../offices/business_development/roles/partnership_manager/partners.dart'
    as partnership_manager_partners;
import '../offices/business_development/roles/partnership_manager/outreach.dart'
    as partnership_manager_outreach;
import '../offices/business_development/roles/partnership_manager/active_deals.dart'
    as partnership_manager_active_deals;
import '../offices/business_development/roles/partnership_manager/proposals.dart'
    as partnership_manager_proposals;
import '../offices/business_development/roles/partnership_manager/renewals.dart'
    as partnership_manager_renewals;
import '../offices/business_development/roles/partnership_manager/reports.dart'
    as partnership_manager_reports;
import '../offices/business_development/roles/territory_expansion_manager/territory_map.dart'
    as territory_expansion_manager_territory_map;
import '../offices/business_development/roles/territory_expansion_manager/market_research.dart'
    as territory_expansion_manager_market_research;
import '../offices/business_development/roles/territory_expansion_manager/demographics.dart'
    as territory_expansion_manager_demographics;
import '../offices/business_development/roles/territory_expansion_manager/open_territories.dart'
    as territory_expansion_manager_open_territories;
import '../offices/business_development/roles/territory_expansion_manager/expansion_plans.dart'
    as territory_expansion_manager_expansion_plans;
import '../offices/business_development/roles/territory_expansion_manager/site_selection.dart'
    as territory_expansion_manager_site_selection;
import '../offices/business_development/roles/territory_expansion_manager/forecast.dart'
    as territory_expansion_manager_forecast;
import '../offices/business_development/roles/territory_expansion_manager/reports.dart'
    as territory_expansion_manager_reports;
import '../offices/franchise/roles/franchise_owner/branch_overview.dart'
    as franchise_owner_branch_overview;
import '../offices/franchise/roles/franchise_owner/financial_snapshot.dart'
    as franchise_owner_financial_snapshot;
import '../offices/franchise/roles/franchise_owner/staff.dart'
    as franchise_owner_staff;
import '../offices/franchise/roles/franchise_owner/appointments.dart'
    as franchise_owner_appointments;
import '../offices/franchise/roles/franchise_owner/clients.dart'
    as franchise_owner_clients;
import '../offices/franchise/roles/franchise_owner/compliance.dart'
    as franchise_owner_compliance;
import '../offices/franchise/roles/franchise_owner/reports.dart'
    as franchise_owner_reports;
import '../offices/franchise/roles/franchise_owner/hiring.dart'
    as franchise_owner_hiring;
import '../offices/franchise/roles/operations_manager/daily_operations.dart'
    as operations_manager_daily_operations;
import '../offices/franchise/roles/operations_manager/schedule.dart'
    as operations_manager_schedule;
import '../offices/franchise/roles/operations_manager/shifts.dart'
    as operations_manager_shifts;
import '../offices/franchise/roles/operations_manager/issues.dart'
    as operations_manager_issues;
import '../offices/franchise/roles/operations_manager/service_quality.dart'
    as operations_manager_service_quality;
import '../offices/franchise/roles/operations_manager/staff_coordination.dart'
    as operations_manager_staff_coordination;
import '../offices/franchise/roles/operations_manager/attendance.dart'
    as operations_manager_attendance;
import '../offices/franchise/roles/operations_manager/reports.dart'
    as operations_manager_reports;
import '../offices/franchise/roles/scheduler_coordinator/appointment_calendar.dart'
    as scheduler_coordinator_appointment_calendar;
import '../offices/franchise/roles/scheduler_coordinator/shift_calendar.dart'
    as scheduler_coordinator_shift_calendar;
import '../offices/franchise/roles/scheduler_coordinator/provider_availability.dart'
    as scheduler_coordinator_provider_availability;
import '../offices/franchise/roles/scheduler_coordinator/booking_requests.dart'
    as scheduler_coordinator_booking_requests;
import '../offices/franchise/roles/scheduler_coordinator/open_shifts.dart'
    as scheduler_coordinator_open_shifts;
import '../offices/franchise/roles/scheduler_coordinator/assignments.dart'
    as scheduler_coordinator_assignments;
import '../offices/franchise/roles/scheduler_coordinator/conflicts.dart'
    as scheduler_coordinator_conflicts;
import '../offices/franchise/roles/scheduler_coordinator/reports.dart'
    as scheduler_coordinator_reports;
import '../offices/franchise/roles/admin/invoices.dart' as admin_invoices;
import '../offices/franchise/roles/admin/payments.dart' as admin_payments;
import '../offices/franchise/roles/admin/claims.dart' as admin_claims;
import '../offices/franchise/roles/admin/reconciliation.dart'
    as admin_reconciliation;
import '../offices/franchise/roles/admin/outstanding_balances.dart'
    as admin_outstanding_balances;
import '../offices/franchise/roles/admin/refunds.dart' as admin_refunds;
import '../offices/franchise/roles/admin/reports.dart' as admin_reports;
import '../offices/franchise/roles/hr_hiring/applicants.dart'
    as hr_hiring_applicants;
import '../offices/franchise/roles/hr_hiring/interviews.dart'
    as hr_hiring_interviews;
import '../offices/franchise/roles/hr_hiring/offers.dart' as hr_hiring_offers;
import '../offices/franchise/roles/hr_hiring/onboarding.dart'
    as hr_hiring_onboarding;
import '../offices/franchise/roles/hr_hiring/staff_documents.dart'
    as hr_hiring_staff_documents;
import '../offices/franchise/roles/hr_hiring/credentials.dart'
    as hr_hiring_credentials;
import '../offices/franchise/roles/hr_hiring/training_status.dart'
    as hr_hiring_training_status;
import '../offices/franchise/roles/hr_hiring/reports.dart' as hr_hiring_reports;
import '../offices/clinic/roles/rn/todays_schedule.dart' as rn_todays_schedule;
import '../offices/clinic/roles/rn/assigned_clients.dart'
    as rn_assigned_clients;
import '../offices/clinic/roles/rn/nursing_notes.dart' as rn_nursing_notes;
import '../offices/clinic/roles/rn/care_plans.dart' as rn_care_plans;
import '../offices/clinic/roles/rn/medication_notes.dart'
    as rn_medication_notes;
import '../offices/clinic/roles/rn/vitals.dart' as rn_vitals;
import '../offices/clinic/roles/rn/incident_reports.dart'
    as rn_incident_reports;
import '../offices/clinic/roles/rn/progress_updates.dart'
    as rn_progress_updates;
import '../offices/clinic/roles/rn/client_history.dart' as rn_client_history;
import '../offices/clinic/roles/rpn/todays_schedule.dart'
    as rpn_todays_schedule;
import '../offices/clinic/roles/rpn/assigned_clients.dart'
    as rpn_assigned_clients;
import '../offices/clinic/roles/rpn/nursing_notes.dart' as rpn_nursing_notes;
import '../offices/clinic/roles/rpn/care_updates.dart' as rpn_care_updates;
import '../offices/clinic/roles/rpn/vitals.dart' as rpn_vitals;
import '../offices/clinic/roles/rpn/medication_support.dart'
    as rpn_medication_support;
import '../offices/clinic/roles/rpn/client_history.dart' as rpn_client_history;
import '../offices/clinic/roles/rpn/incident_reports.dart'
    as rpn_incident_reports;
import '../offices/clinic/roles/rmt/todays_schedule.dart'
    as rmt_todays_schedule;
import '../offices/clinic/roles/rmt/clients.dart' as rmt_clients;
import '../offices/clinic/roles/rmt/assessment.dart' as rmt_assessment;
import '../offices/clinic/roles/rmt/soap_notes.dart' as rmt_soap_notes;
import '../offices/clinic/roles/rmt/treatment_plans.dart'
    as rmt_treatment_plans;
import '../offices/clinic/roles/rmt/homecare.dart' as rmt_homecare;
import '../offices/clinic/roles/rmt/session_history.dart'
    as rmt_session_history;
import '../offices/clinic/roles/rmt/body_chart.dart' as rmt_body_chart;
import '../offices/clinic/roles/rmt/intake_forms.dart' as rmt_intake_forms;
import '../offices/clinic/roles/rmt/invoices.dart' as rmt_invoices;
import '../offices/support/roles/customer_support/tickets.dart'
    as customer_support_tickets;
import '../offices/support/roles/customer_support/escalations.dart'
    as customer_support_escalations;
import '../offices/support/roles/customer_support/issue_categories.dart'
    as customer_support_issue_categories;
import '../offices/support/roles/customer_support/templates.dart'
    as customer_support_templates;
import '../offices/support/roles/customer_support/reports.dart'
    as customer_support_reports;
import '../offices/support/roles/intake_coordinator/new_intakes.dart'
    as intake_coordinator_new_intakes;
import '../offices/support/roles/intake_coordinator/intake_forms.dart'
    as intake_coordinator_intake_forms;
import '../offices/support/roles/intake_coordinator/eligibility.dart'
    as intake_coordinator_eligibility;
import '../offices/support/roles/intake_coordinator/scheduling.dart'
    as intake_coordinator_scheduling;
import '../offices/support/roles/intake_coordinator/client_assignment.dart'
    as intake_coordinator_client_assignment;
import '../offices/support/roles/intake_coordinator/reports.dart'
    as intake_coordinator_reports;
import '../offices/support/roles/quality_assurance/audits.dart'
    as quality_assurance_audits;
import '../offices/support/roles/quality_assurance/reviews.dart'
    as quality_assurance_reviews;
import '../offices/support/roles/quality_assurance/complaints.dart'
    as quality_assurance_complaints;
import '../offices/support/roles/quality_assurance/corrective_actions.dart'
    as quality_assurance_corrective_actions;
import '../offices/support/roles/quality_assurance/scorecards.dart'
    as quality_assurance_scorecards;
import '../offices/support/roles/quality_assurance/compliance_checks.dart'
    as quality_assurance_compliance_checks;
import '../offices/support/roles/quality_assurance/reports.dart'
    as quality_assurance_reports;
import '../offices/support/roles/training_coordinator/training_schedule.dart'
    as training_coordinator_training_schedule;
import '../offices/support/roles/training_coordinator/courses.dart'
    as training_coordinator_courses;
import '../offices/support/roles/training_coordinator/progress.dart'
    as training_coordinator_progress;
import '../offices/support/roles/training_coordinator/workshops.dart'
    as training_coordinator_workshops;
import '../offices/support/roles/training_coordinator/attendance.dart'
    as training_coordinator_attendance;
import '../offices/support/roles/training_coordinator/materials.dart'
    as training_coordinator_materials;
import '../offices/support/roles/training_coordinator/certifications.dart'
    as training_coordinator_certifications;
import '../offices/support/roles/training_coordinator/reports.dart'
    as training_coordinator_reports;
import '../offices/marketing/roles/local_marketing_manager/campaigns.dart'
    as local_marketing_manager_campaigns;
import '../offices/marketing/roles/local_marketing_manager/leads.dart'
    as local_marketing_manager_leads;
import '../offices/marketing/roles/local_marketing_manager/content_calendar.dart'
    as local_marketing_manager_content_calendar;
import '../offices/marketing/roles/local_marketing_manager/events.dart'
    as local_marketing_manager_events;
import '../offices/marketing/roles/local_marketing_manager/budget.dart'
    as local_marketing_manager_budget;
import '../offices/marketing/roles/local_marketing_manager/reports.dart'
    as local_marketing_manager_reports;
import '../offices/marketing/roles/local_marketing_manager/assets.dart'
    as local_marketing_manager_assets;
import '../offices/marketing/roles/community_outreach/programs.dart'
    as community_outreach_programs;
import '../offices/marketing/roles/community_outreach/events.dart'
    as community_outreach_events;
import '../offices/marketing/roles/community_outreach/partnerships.dart'
    as community_outreach_partnerships;
import '../offices/marketing/roles/community_outreach/volunteers.dart'
    as community_outreach_volunteers;
import '../offices/marketing/roles/community_outreach/contacts.dart'
    as community_outreach_contacts;
import '../offices/marketing/roles/community_outreach/follow_ups.dart'
    as community_outreach_follow_ups;
import '../offices/marketing/roles/community_outreach/reports.dart'
    as community_outreach_reports;
import '../offices/marketing/roles/territory_sales_manager/leads.dart'
    as territory_sales_manager_leads;
import '../offices/marketing/roles/territory_sales_manager/pipeline.dart'
    as territory_sales_manager_pipeline;
import '../offices/marketing/roles/territory_sales_manager/field_activity.dart'
    as territory_sales_manager_field_activity;
import '../offices/marketing/roles/territory_sales_manager/conversions.dart'
    as territory_sales_manager_conversions;
import '../offices/marketing/roles/territory_sales_manager/area_performance.dart'
    as territory_sales_manager_area_performance;
import '../offices/marketing/roles/territory_sales_manager/competitors.dart'
    as territory_sales_manager_competitors;
import '../offices/marketing/roles/territory_sales_manager/reports.dart'
    as territory_sales_manager_reports;
import '../offices/client/roles/client/book_appointment.dart'
    as client_book_appointment;
import '../offices/client/roles/client/my_appointments.dart'
    as client_my_appointments;
import '../offices/client/roles/client/care_team.dart' as client_care_team;
import '../offices/client/roles/client/treatment_history.dart'
    as client_treatment_history;
import '../offices/client/roles/client/payments.dart' as client_payments;
import '../offices/client/roles/client/profile.dart' as client_profile;
import '../offices/client/roles/family_member/loved_one_schedule.dart'
    as family_member_loved_one_schedule;
import '../offices/client/roles/family_member/care_updates.dart'
    as family_member_care_updates;
import '../offices/client/roles/family_member/billing.dart'
    as family_member_billing;
import '../offices/client/roles/family_member/emergency_contacts.dart'
    as family_member_emergency_contacts;
import '../offices/client/roles/family_member/profile.dart'
    as family_member_profile;
import '../offices/corporate/roles/ceo/enterprise_overview.dart'
    as ceo_enterprise_overview;
import '../offices/corporate/roles/ceo/franchise_overview.dart'
    as ceo_franchise_overview;
import '../offices/corporate/roles/ceo/region_performance.dart'
    as ceo_region_performance;
import '../offices/corporate/roles/ceo/revenue_summary.dart'
    as ceo_revenue_summary;
import '../offices/corporate/roles/ceo/strategic_kpis.dart'
    as ceo_strategic_kpis;
import '../offices/corporate/roles/ceo/growth_pipeline.dart'
    as ceo_growth_pipeline;
import '../offices/corporate/roles/ceo/leadership_reports.dart'
    as ceo_leadership_reports;
import '../offices/corporate/roles/ceo/alerts_and_risks.dart'
    as ceo_alerts_and_risks;
import '../offices/corporate/roles/ceo/organization_map.dart'
    as ceo_organization_map;
import '../offices/corporate/roles/ceo/approvals.dart' as ceo_approvals;
import '../offices/corporate/roles/ceo/reports.dart' as ceo_reports;
import '../offices/corporate/roles/coo/operations_overview.dart'
    as coo_operations_overview;
import '../offices/corporate/roles/coo/branch_operations.dart'
    as coo_branch_operations;
import '../offices/corporate/roles/coo/staffing_efficiency.dart'
    as coo_staffing_efficiency;
import '../offices/corporate/roles/coo/scheduling_health.dart'
    as coo_scheduling_health;
import '../offices/corporate/roles/coo/service_delivery.dart'
    as coo_service_delivery;
import '../offices/corporate/roles/coo/issue_escalations.dart'
    as coo_issue_escalations;
import '../offices/corporate/roles/coo/compliance_view.dart'
    as coo_compliance_view;
import '../offices/corporate/roles/coo/workflow_performance.dart'
    as coo_workflow_performance;
import '../offices/corporate/roles/coo/branch_comparison.dart'
    as coo_branch_comparison;
import '../offices/corporate/roles/coo/reports.dart' as coo_reports;
import '../offices/corporate/roles/cfo/financial_overview.dart'
    as cfo_financial_overview;
import '../offices/corporate/roles/cfo/revenue.dart' as cfo_revenue;
import '../offices/corporate/roles/cfo/expenses.dart' as cfo_expenses;
import '../offices/corporate/roles/cfo/franchise_financials.dart'
    as cfo_franchise_financials;
import '../offices/corporate/roles/cfo/payroll.dart' as cfo_payroll;
import '../offices/corporate/roles/cfo/accounts_receivable.dart'
    as cfo_accounts_receivable;
import '../offices/corporate/roles/cfo/accounts_payable.dart'
    as cfo_accounts_payable;
import '../offices/corporate/roles/cfo/invoices.dart' as cfo_invoices;
import '../offices/corporate/roles/cfo/profitability.dart' as cfo_profitability;
import '../offices/corporate/roles/cfo/tax_and_remittance.dart'
    as cfo_tax_and_remittance;
import '../offices/corporate/roles/cfo/reports.dart' as cfo_reports;
import '../offices/corporate/roles/cto/system_health.dart' as cto_system_health;
import '../offices/corporate/roles/cto/platform_usage.dart'
    as cto_platform_usage;
import '../offices/corporate/roles/cto/feature_adoption.dart'
    as cto_feature_adoption;
import '../offices/corporate/roles/cto/api_monitoring.dart'
    as cto_api_monitoring;
import '../offices/corporate/roles/cto/integrations.dart' as cto_integrations;
import '../offices/corporate/roles/cto/audit_logs.dart' as cto_audit_logs;
import '../offices/corporate/roles/cto/access_control.dart'
    as cto_access_control;
import '../offices/corporate/roles/cto/release_management.dart'
    as cto_release_management;
import '../offices/corporate/roles/cto/issue_tracking.dart'
    as cto_issue_tracking;
import '../offices/corporate/roles/cto/infrastructure.dart'
    as cto_infrastructure;
import '../offices/corporate/roles/cto/reports.dart' as cto_reports;
import '../offices/corporate/roles/compliance_manager/compliance_cases.dart'
    as compliance_manager_compliance_cases;
import '../offices/corporate/roles/compliance_manager/policies.dart'
    as compliance_manager_policies;
import '../offices/corporate/roles/compliance_manager/audits.dart'
    as compliance_manager_audits;
import '../offices/corporate/roles/compliance_manager/incident_review.dart'
    as compliance_manager_incident_review;
import '../offices/corporate/roles/compliance_manager/credential_tracking.dart'
    as compliance_manager_credential_tracking;
import '../offices/corporate/roles/compliance_manager/document_expiry.dart'
    as compliance_manager_document_expiry;
import '../offices/corporate/roles/compliance_manager/risk_register.dart'
    as compliance_manager_risk_register;
import '../offices/corporate/roles/compliance_manager/corrective_actions.dart'
    as compliance_manager_corrective_actions;
import '../offices/corporate/roles/compliance_manager/training_compliance.dart'
    as compliance_manager_training_compliance;
import '../offices/corporate/roles/compliance_manager/reports.dart'
    as compliance_manager_reports;
import '../offices/clinic/roles/head_of_business_development/lead_pipeline.dart'
    as head_of_business_development_lead_pipeline;
import '../offices/clinic/roles/head_of_business_development/franchise_pipeline.dart'
    as head_of_business_development_franchise_pipeline;
import '../offices/clinic/roles/head_of_business_development/territory_map.dart'
    as head_of_business_development_territory_map;
import '../offices/clinic/roles/head_of_business_development/partnerships.dart'
    as head_of_business_development_partnerships;
import '../offices/clinic/roles/head_of_business_development/opportunities.dart'
    as head_of_business_development_opportunities;
import '../offices/clinic/roles/head_of_business_development/sales_performance.dart'
    as head_of_business_development_sales_performance;
import '../offices/clinic/roles/head_of_business_development/expansion_forecast.dart'
    as head_of_business_development_expansion_forecast;
import '../offices/clinic/roles/head_of_business_development/reports.dart'
    as head_of_business_development_reports;
import '../offices/marketing/roles/head_of_marketing/campaigns.dart'
    as head_of_marketing_campaigns;
import '../offices/marketing/roles/head_of_marketing/leads.dart'
    as head_of_marketing_leads;
import '../offices/marketing/roles/head_of_marketing/funnel_analytics.dart'
    as head_of_marketing_funnel_analytics;
import '../offices/marketing/roles/head_of_marketing/brand_assets.dart'
    as head_of_marketing_brand_assets;
import '../offices/marketing/roles/head_of_marketing/regional_campaigns.dart'
    as head_of_marketing_regional_campaigns;
import '../offices/marketing/roles/head_of_marketing/content_approval.dart'
    as head_of_marketing_content_approval;
import '../offices/marketing/roles/head_of_marketing/performance_reports.dart'
    as head_of_marketing_performance_reports;
import '../offices/corporate/roles/training_director/training_programs.dart'
    as training_director_training_programs;
import '../offices/corporate/roles/training_director/staff_training_matrix.dart'
    as training_director_staff_training_matrix;
import '../offices/corporate/roles/training_director/compliance_training.dart'
    as training_director_compliance_training;
import '../offices/corporate/roles/training_director/course_library.dart'
    as training_director_course_library;
import '../offices/corporate/roles/training_director/assessments.dart'
    as training_director_assessments;
import '../offices/corporate/roles/training_director/certifications.dart'
    as training_director_certifications;
import '../offices/corporate/roles/training_director/trainer_assignments.dart'
    as training_director_trainer_assignments;
import '../offices/corporate/roles/training_director/reports.dart'
    as training_director_reports;
import '../offices/business_development/roles/regional_bdm/leads.dart'
    as regional_bdm_leads;
import '../offices/business_development/roles/regional_bdm/franchise_pipeline.dart'
    as regional_bdm_franchise_pipeline;
import '../offices/business_development/roles/regional_bdm/territory_growth.dart'
    as regional_bdm_territory_growth;
import '../offices/business_development/roles/regional_bdm/meetings.dart'
    as regional_bdm_meetings;
import '../offices/business_development/roles/regional_bdm/deal_tracker.dart'
    as regional_bdm_deal_tracker;
import '../offices/business_development/roles/regional_bdm/partners.dart'
    as regional_bdm_partners;
import '../offices/business_development/roles/regional_bdm/competitor_notes.dart'
    as regional_bdm_competitor_notes;
import '../offices/business_development/roles/regional_bdm/tasks.dart'
    as regional_bdm_tasks;
import '../offices/business_development/roles/regional_bdm/reports.dart'
    as regional_bdm_reports;
import '../offices/business_development/roles/franchise_sales_manager/leads.dart'
    as franchise_sales_manager_leads;
import '../offices/business_development/roles/franchise_sales_manager/prospects.dart'
    as franchise_sales_manager_prospects;
import '../offices/business_development/roles/franchise_sales_manager/discovery_calls.dart'
    as franchise_sales_manager_discovery_calls;
import '../offices/business_development/roles/franchise_sales_manager/proposals.dart'
    as franchise_sales_manager_proposals;
import '../offices/business_development/roles/franchise_sales_manager/sales_pipeline.dart'
    as franchise_sales_manager_sales_pipeline;
import '../offices/business_development/roles/franchise_sales_manager/contracts.dart'
    as franchise_sales_manager_contracts;
import '../offices/business_development/roles/franchise_sales_manager/follow_ups.dart'
    as franchise_sales_manager_follow_ups;
import '../offices/business_development/roles/franchise_sales_manager/reports.dart'
    as franchise_sales_manager_reports;
import '../offices/business_development/roles/partnership_manager/partners.dart'
    as partnership_manager_partners;
import '../offices/business_development/roles/partnership_manager/outreach.dart'
    as partnership_manager_outreach;
import '../offices/business_development/roles/partnership_manager/active_deals.dart'
    as partnership_manager_active_deals;
import '../offices/business_development/roles/partnership_manager/proposals.dart'
    as partnership_manager_proposals;
import '../offices/business_development/roles/partnership_manager/renewals.dart'
    as partnership_manager_renewals;
import '../offices/business_development/roles/partnership_manager/reports.dart'
    as partnership_manager_reports;
import '../offices/business_development/roles/territory_expansion_manager/territory_map.dart'
    as territory_expansion_manager_territory_map;
import '../offices/business_development/roles/territory_expansion_manager/market_research.dart'
    as territory_expansion_manager_market_research;
import '../offices/business_development/roles/territory_expansion_manager/demographics.dart'
    as territory_expansion_manager_demographics;
import '../offices/business_development/roles/territory_expansion_manager/open_territories.dart'
    as territory_expansion_manager_open_territories;
import '../offices/business_development/roles/territory_expansion_manager/expansion_plans.dart'
    as territory_expansion_manager_expansion_plans;
import '../offices/business_development/roles/territory_expansion_manager/site_selection.dart'
    as territory_expansion_manager_site_selection;
import '../offices/business_development/roles/territory_expansion_manager/forecast.dart'
    as territory_expansion_manager_forecast;
import '../offices/business_development/roles/territory_expansion_manager/reports.dart'
    as territory_expansion_manager_reports;
import '../offices/franchise/roles/franchise_owner/branch_overview.dart'
    as franchise_owner_branch_overview;
import '../offices/franchise/roles/franchise_owner/financial_snapshot.dart'
    as franchise_owner_financial_snapshot;
import '../offices/franchise/roles/franchise_owner/staff.dart'
    as franchise_owner_staff;
import '../offices/franchise/roles/franchise_owner/appointments.dart'
    as franchise_owner_appointments;
import '../offices/franchise/roles/franchise_owner/clients.dart'
    as franchise_owner_clients;
import '../offices/franchise/roles/franchise_owner/compliance.dart'
    as franchise_owner_compliance;
import '../offices/franchise/roles/franchise_owner/reports.dart'
    as franchise_owner_reports;
import '../offices/franchise/roles/franchise_owner/hiring.dart'
    as franchise_owner_hiring;
import '../offices/franchise/roles/operations_manager/daily_operations.dart'
    as operations_manager_daily_operations;
import '../offices/franchise/roles/operations_manager/schedule.dart'
    as operations_manager_schedule;
import '../offices/franchise/roles/operations_manager/shifts.dart'
    as operations_manager_shifts;
import '../offices/franchise/roles/operations_manager/issues.dart'
    as operations_manager_issues;
import '../offices/franchise/roles/operations_manager/service_quality.dart'
    as operations_manager_service_quality;
import '../offices/franchise/roles/operations_manager/staff_coordination.dart'
    as operations_manager_staff_coordination;
import '../offices/franchise/roles/operations_manager/attendance.dart'
    as operations_manager_attendance;
import '../offices/franchise/roles/operations_manager/reports.dart'
    as operations_manager_reports;
import '../offices/franchise/roles/scheduler_coordinator/appointment_calendar.dart'
    as scheduler_coordinator_appointment_calendar;
import '../offices/franchise/roles/scheduler_coordinator/shift_calendar.dart'
    as scheduler_coordinator_shift_calendar;
import '../offices/franchise/roles/scheduler_coordinator/provider_availability.dart'
    as scheduler_coordinator_provider_availability;
import '../offices/franchise/roles/scheduler_coordinator/booking_requests.dart'
    as scheduler_coordinator_booking_requests;
import '../offices/franchise/roles/scheduler_coordinator/open_shifts.dart'
    as scheduler_coordinator_open_shifts;
import '../offices/franchise/roles/scheduler_coordinator/assignments.dart'
    as scheduler_coordinator_assignments;
import '../offices/franchise/roles/scheduler_coordinator/conflicts.dart'
    as scheduler_coordinator_conflicts;
import '../offices/franchise/roles/scheduler_coordinator/reports.dart'
    as scheduler_coordinator_reports;
import '../offices/franchise/roles/admin/invoices.dart' as admin_invoices;
import '../offices/franchise/roles/admin/payments.dart' as admin_payments;
import '../offices/franchise/roles/admin/claims.dart' as admin_claims;
import '../offices/franchise/roles/admin/reconciliation.dart'
    as admin_reconciliation;
import '../offices/franchise/roles/admin/outstanding_balances.dart'
    as admin_outstanding_balances;
import '../offices/franchise/roles/admin/refunds.dart' as admin_refunds;
import '../offices/franchise/roles/admin/reports.dart' as admin_reports;
import '../offices/franchise/roles/hr_hiring/applicants.dart'
    as hr_hiring_applicants;
import '../offices/franchise/roles/hr_hiring/interviews.dart'
    as hr_hiring_interviews;
import '../offices/franchise/roles/hr_hiring/offers.dart' as hr_hiring_offers;
import '../offices/franchise/roles/hr_hiring/onboarding.dart'
    as hr_hiring_onboarding;
import '../offices/franchise/roles/hr_hiring/staff_documents.dart'
    as hr_hiring_staff_documents;
import '../offices/franchise/roles/hr_hiring/credentials.dart'
    as hr_hiring_credentials;
import '../offices/franchise/roles/hr_hiring/training_status.dart'
    as hr_hiring_training_status;
import '../offices/franchise/roles/hr_hiring/reports.dart' as hr_hiring_reports;
import '../offices/clinic/roles/rn/todays_schedule.dart' as rn_todays_schedule;
import '../offices/clinic/roles/rn/assigned_clients.dart'
    as rn_assigned_clients;
import '../offices/clinic/roles/rn/nursing_notes.dart' as rn_nursing_notes;
import '../offices/clinic/roles/rn/care_plans.dart' as rn_care_plans;
import '../offices/clinic/roles/rn/medication_notes.dart'
    as rn_medication_notes;
import '../offices/clinic/roles/rn/vitals.dart' as rn_vitals;
import '../offices/clinic/roles/rn/incident_reports.dart'
    as rn_incident_reports;
import '../offices/clinic/roles/rn/progress_updates.dart'
    as rn_progress_updates;
import '../offices/clinic/roles/rn/client_history.dart' as rn_client_history;
import '../offices/clinic/roles/rpn/todays_schedule.dart'
    as rpn_todays_schedule;
import '../offices/clinic/roles/rpn/assigned_clients.dart'
    as rpn_assigned_clients;
import '../offices/clinic/roles/rpn/nursing_notes.dart' as rpn_nursing_notes;
import '../offices/clinic/roles/rpn/care_updates.dart' as rpn_care_updates;
import '../offices/clinic/roles/rpn/vitals.dart' as rpn_vitals;
import '../offices/clinic/roles/rpn/medication_support.dart'
    as rpn_medication_support;
import '../offices/clinic/roles/rpn/client_history.dart' as rpn_client_history;
import '../offices/clinic/roles/rpn/incident_reports.dart'
    as rpn_incident_reports;
import '../offices/clinic/roles/rmt/todays_schedule.dart'
    as rmt_todays_schedule;
import '../offices/clinic/roles/rmt/clients.dart' as rmt_clients;
import '../offices/clinic/roles/rmt/assessment.dart' as rmt_assessment;
import '../offices/clinic/roles/rmt/soap_notes.dart' as rmt_soap_notes;
import '../offices/clinic/roles/rmt/treatment_plans.dart'
    as rmt_treatment_plans;
import '../offices/clinic/roles/rmt/homecare.dart' as rmt_homecare;
import '../offices/clinic/roles/rmt/session_history.dart'
    as rmt_session_history;
import '../offices/clinic/roles/rmt/body_chart.dart' as rmt_body_chart;
import '../offices/clinic/roles/rmt/intake_forms.dart' as rmt_intake_forms;
import '../offices/clinic/roles/rmt/invoices.dart' as rmt_invoices;
import '../offices/support/roles/customer_support/tickets.dart'
    as customer_support_tickets;
import '../offices/support/roles/customer_support/escalations.dart'
    as customer_support_escalations;
import '../offices/support/roles/customer_support/issue_categories.dart'
    as customer_support_issue_categories;
import '../offices/support/roles/customer_support/templates.dart'
    as customer_support_templates;
import '../offices/support/roles/customer_support/reports.dart'
    as customer_support_reports;
import '../offices/support/roles/intake_coordinator/new_intakes.dart'
    as intake_coordinator_new_intakes;
import '../offices/support/roles/intake_coordinator/intake_forms.dart'
    as intake_coordinator_intake_forms;
import '../offices/support/roles/intake_coordinator/eligibility.dart'
    as intake_coordinator_eligibility;
import '../offices/support/roles/intake_coordinator/scheduling.dart'
    as intake_coordinator_scheduling;
import '../offices/support/roles/intake_coordinator/client_assignment.dart'
    as intake_coordinator_client_assignment;
import '../offices/support/roles/intake_coordinator/reports.dart'
    as intake_coordinator_reports;
import '../offices/support/roles/quality_assurance/audits.dart'
    as quality_assurance_audits;
import '../offices/support/roles/quality_assurance/reviews.dart'
    as quality_assurance_reviews;
import '../offices/support/roles/quality_assurance/complaints.dart'
    as quality_assurance_complaints;
import '../offices/support/roles/quality_assurance/corrective_actions.dart'
    as quality_assurance_corrective_actions;
import '../offices/support/roles/quality_assurance/scorecards.dart'
    as quality_assurance_scorecards;
import '../offices/support/roles/quality_assurance/compliance_checks.dart'
    as quality_assurance_compliance_checks;
import '../offices/support/roles/quality_assurance/reports.dart'
    as quality_assurance_reports;
import '../offices/support/roles/training_coordinator/training_schedule.dart'
    as training_coordinator_training_schedule;
import '../offices/support/roles/training_coordinator/courses.dart'
    as training_coordinator_courses;
import '../offices/support/roles/training_coordinator/progress.dart'
    as training_coordinator_progress;
import '../offices/support/roles/training_coordinator/workshops.dart'
    as training_coordinator_workshops;
import '../offices/support/roles/training_coordinator/attendance.dart'
    as training_coordinator_attendance;
import '../offices/support/roles/training_coordinator/materials.dart'
    as training_coordinator_materials;
import '../offices/support/roles/training_coordinator/certifications.dart'
    as training_coordinator_certifications;
import '../offices/support/roles/training_coordinator/reports.dart'
    as training_coordinator_reports;
import '../offices/marketing/roles/local_marketing_manager/campaigns.dart'
    as local_marketing_manager_campaigns;
import '../offices/marketing/roles/local_marketing_manager/leads.dart'
    as local_marketing_manager_leads;
import '../offices/marketing/roles/local_marketing_manager/content_calendar.dart'
    as local_marketing_manager_content_calendar;
import '../offices/marketing/roles/local_marketing_manager/events.dart'
    as local_marketing_manager_events;
import '../offices/marketing/roles/local_marketing_manager/budget.dart'
    as local_marketing_manager_budget;
import '../offices/marketing/roles/local_marketing_manager/reports.dart'
    as local_marketing_manager_reports;
import '../offices/marketing/roles/local_marketing_manager/assets.dart'
    as local_marketing_manager_assets;
import '../offices/marketing/roles/community_outreach/programs.dart'
    as community_outreach_programs;
import '../offices/marketing/roles/community_outreach/events.dart'
    as community_outreach_events;
import '../offices/marketing/roles/community_outreach/partnerships.dart'
    as community_outreach_partnerships;
import '../offices/marketing/roles/community_outreach/volunteers.dart'
    as community_outreach_volunteers;
import '../offices/marketing/roles/community_outreach/contacts.dart'
    as community_outreach_contacts;
import '../offices/marketing/roles/community_outreach/follow_ups.dart'
    as community_outreach_follow_ups;
import '../offices/marketing/roles/community_outreach/reports.dart'
    as community_outreach_reports;
import '../offices/marketing/roles/territory_sales_manager/leads.dart'
    as territory_sales_manager_leads;
import '../offices/marketing/roles/territory_sales_manager/pipeline.dart'
    as territory_sales_manager_pipeline;
import '../offices/marketing/roles/territory_sales_manager/field_activity.dart'
    as territory_sales_manager_field_activity;
import '../offices/marketing/roles/territory_sales_manager/conversions.dart'
    as territory_sales_manager_conversions;
import '../offices/marketing/roles/territory_sales_manager/area_performance.dart'
    as territory_sales_manager_area_performance;
import '../offices/marketing/roles/territory_sales_manager/competitors.dart'
    as territory_sales_manager_competitors;
import '../offices/marketing/roles/territory_sales_manager/reports.dart'
    as territory_sales_manager_reports;
import '../offices/client/roles/client/book_appointment.dart'
    as client_book_appointment;
import '../offices/client/roles/client/my_appointments.dart'
    as client_my_appointments;
import '../offices/client/roles/client/care_team.dart' as client_care_team;
import '../offices/client/roles/client/treatment_history.dart'
    as client_treatment_history;
import '../offices/client/roles/client/payments.dart' as client_payments;
import '../offices/client/roles/client/profile.dart' as client_profile;
import '../offices/client/roles/family_member/loved_one_schedule.dart'
    as family_member_loved_one_schedule;
import '../offices/client/roles/family_member/care_updates.dart'
    as family_member_care_updates;
import '../offices/client/roles/family_member/billing.dart'
    as family_member_billing;
import '../offices/client/roles/family_member/emergency_contacts.dart'
    as family_member_emergency_contacts;
import '../offices/client/roles/family_member/profile.dart'
    as family_member_profile;
import '../offices/client/roles/family_member/family_dashboard.dart'
    as family_member_dash;
import '../offices/clinic/roles/physio/physio_dashboard.dart' as physio_dash;
import '../offices/clinic/roles/chiro/chiro_dashboard.dart' as chiro_dash;
import '../offices/clinic/roles/occupational_therapist/ot_dashboard.dart'
    as ot_dash;
import '../offices/clinic/roles/speech_pathologist/slp_dashboard.dart'
    as slp_dash;
import '../offices/system/roles/guest/guest_dashboard.dart' as guest_dash;
import '../offices/system/roles/scrum_master/scrum_master_dashboard.dart'
    as scrum_master_dash;

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signup ||
          state.matchedLocation == AppRoutes.forgotPassword;
      final isSplash = state.matchedLocation == AppRoutes.splash;

      final isLoggedIn = authState.isAuthenticated;
      final role = authState.role ?? '';

      // Allow splash to render unhindered
      if (isSplash) return null;

      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login;
      }

      if (isLoggedIn && isLoggingIn) {
        return AuthNotifier.getDashboardRouteForRole(role);
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          final role = authState.role ?? '';
          AppShellType type = AppShellType.none;
          if (role == 'ceo' ||
              role.endsWith('manager') ||
              role == 'scrum_master') {
            type = AppShellType.admin;
          } else if (role == 'client' || role == 'family_member') {
            type = AppShellType.client;
          } else if (role.isNotEmpty) {
            type = AppShellType.provider;
          }
          return MasterLayout(shellType: type, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: AppRoutes.globalSettings,
            builder: (context, state) => const GlobalSettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.globalProfile,
            builder: (context, state) => const GlobalProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.notificationCenter,
            builder: (context, state) => const NotificationCenterScreen(),
          ),
          GoRoute(
            path: AppRoutes.messagingHub,
            builder: (context, state) => const MessagingHubScreen(),
          ),
          GoRoute(
            path: AppRoutes.documentVault,
            builder: (context, state) => const DocumentVaultScreen(),
          ),
          GoRoute(
            path: AppRoutes.guestDashboard,
            builder: (context, state) => const guest_dash.GuestDashboard(),
          ),
          GoRoute(
            path: AppRoutes.ceoDashboard,
            builder: (context, state) => const ceo_dash.CeoAnalyticsDashboard(),
          ),
          GoRoute(
            path: AppRoutes.cooDashboard,
            builder: (context, state) => const coo_dash.CooDashboard(),
          ),
          GoRoute(
            path: AppRoutes.cfoDashboard,
            builder: (context, state) => const cfo_dash.CfoDashboard(),
          ),
          GoRoute(
            path: AppRoutes.ctoDashboard,
            builder: (context, state) => const cto_dash.CtoDashboard(),
          ),
          GoRoute(
            path: AppRoutes.complianceManagerDashboard,
            builder: (context, state) =>
                const compliance_manager_dash.ComplianceDashboard(),
          ),
          GoRoute(
            path: AppRoutes.headOfBusDevDashboard,
            builder: (context, state) =>
                const head_of_bus_dev_dash.BusDevDashboard(),
          ),
          GoRoute(
            path: AppRoutes.headOfMarketingDashboard,
            builder: (context, state) =>
                const head_of_marketing_dash.HeadOfMarketingDashboard(),
          ),
          GoRoute(
            path: AppRoutes.trainingDirectorDashboard,
            builder: (context, state) =>
                const training_director_dash.TrainingAdminDashboard(),
          ),
          GoRoute(
            path: AppRoutes.regionalManagerOntarioDashboard,
            builder: (context, state) =>
                const regional_manager_ontario_dash.RegionDashboard(),
          ),
          GoRoute(
            path: AppRoutes.regionalManagerUsaDashboard,
            builder: (context, state) =>
                const regional_manager_usa_dash.RegionDashboard(),
          ),
          GoRoute(
            path: AppRoutes.franchiseSalesManagerDashboard,
            builder: (context, state) =>
                const franchise_sales_manager_dash.FranchiseSalesDashboard(),
          ),
          GoRoute(
            path: AppRoutes.generalManagerDashboard,
            builder: (context, state) =>
                const general_manager_dash.OpsDashboard(),
          ),
          GoRoute(
            path: AppRoutes.partnershipManagerDashboard,
            builder: (context, state) =>
                const partnership_manager_dash.PartnerDashboard(),
          ),
          GoRoute(
            path: AppRoutes.territoryExpansionManagerDashboard,
            builder: (context, state) =>
                const territory_expansion_manager_dash.ExpansionAnalyticsDashboard(),
          ),
          GoRoute(
            path: AppRoutes.franchiseOwnerDashboard,
            builder: (context, state) =>
                const franchise_owner_dash.OwnerDashboard(),
          ),
          GoRoute(
            path: AppRoutes.operationsManagerDashboard,
            builder: (context, state) =>
                const operations_manager_dash.OpsManagerDashboard(),
          ),
          GoRoute(
            path: AppRoutes.schedulerDashboard,
            builder: (context, state) =>
                const scheduler_dash.SchedulingDashboard(),
          ),
          GoRoute(
            path: AppRoutes.billingAdminDashboard,
            builder: (context, state) =>
                const billing_admin_dash.BillingDashboard(),
          ),
          GoRoute(
            path: AppRoutes.hrHiringDashboard,
            builder: (context, state) => const hr_hiring_dash.HrDashboard(),
          ),
          GoRoute(
            path: AppRoutes.localMarketingManagerDashboard,
            builder: (context, state) =>
                const local_marketing_manager_dash.LocalMarketingDashboard(),
          ),
          GoRoute(
            path: AppRoutes.communityOutreachDashboard,
            builder: (context, state) =>
                const community_outreach_dash.CommunityOutreachDashboard(),
          ),
          GoRoute(
            path: AppRoutes.territorySalesManagerDashboard,
            builder: (context, state) =>
                const territory_sales_manager_dash.TerritorySalesDashboard(),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) =>
            MasterLayout(shellType: AppShellType.provider, child: child),
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: '/provider/feature/:id',
            builder: (context, state) => GenericFeatureScreen(
              featureId: state.pathParameters['id'] ?? 'feature',
            ),
          ),
          GoRoute(
            path: AppRoutes.rnDashboard,
            builder: (context, state) => const rn_dash.RnDashboard(),
          ),
          GoRoute(
            path: AppRoutes.rpnDashboard,
            builder: (context, state) => const rpn_dash.RpnDashboard(),
          ),
          GoRoute(
            path: AppRoutes.rmtDashboard,
            builder: (context, state) => const rmt_dash.RmtDashboard(),
          ),
          GoRoute(
            path: AppRoutes.pswDashboard,
            builder: (context, state) => const psw_dash.PswDashboard(),
          ),
          GoRoute(
            path: AppRoutes.pswTodaysShifts,
            builder: (context, state) =>
                const psw_todays_shifts.TodaysShiftsScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswAssignedClients,
            builder: (context, state) =>
                const psw_assigned_clients.AssignedClientsScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswCareTasks,
            builder: (context, state) => const psw_care_tasks.CareTasksScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswAdlTracking,
            builder: (context, state) =>
                const psw_adl_tracking.AdlTrackingScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswDailyLogs,
            builder: (context, state) => const psw_daily_logs.DailyLogsScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswCheckInOut,
            builder: (context, state) =>
                const psw_check_in_out.CheckInOutScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswClientUpdates,
            builder: (context, state) =>
                const psw_client_updates.ClientUpdatesScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswIncidentReports,
            builder: (context, state) =>
                const psw_incident_reports.IncidentReportsScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswCompletedVisits,
            builder: (context, state) =>
                const psw_completed_visits.CompletedVisitsScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswDocuments,
            builder: (context, state) => const psw_documents.DocumentsScreen(),
          ),
          GoRoute(
            path: AppRoutes.pswSettings,
            builder: (context, state) => const psw_settings.SettingsScreen(),
            GoRoute(
              path: AppRoutes.ceoEnterpriseOverview,
              builder: (context, state) =>
                  const ceo_enterprise_overview.EnterpriseOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoFranchiseOverview,
              builder: (context, state) =>
                  const ceo_franchise_overview.FranchiseOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoRegionPerformance,
              builder: (context, state) =>
                  const ceo_region_performance.RegionPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoRevenueSummary,
              builder: (context, state) =>
                  const ceo_revenue_summary.RevenueSummaryScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoStrategicKpis,
              builder: (context, state) =>
                  const ceo_strategic_kpis.StrategicKpisScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoGrowthPipeline,
              builder: (context, state) =>
                  const ceo_growth_pipeline.GrowthPipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoLeadershipReports,
              builder: (context, state) =>
                  const ceo_leadership_reports.LeadershipReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoAlertsAndRisks,
              builder: (context, state) =>
                  const ceo_alerts_and_risks.AlertsAndRisksScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoOrganizationMap,
              builder: (context, state) =>
                  const ceo_organization_map.OrganizationMapScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoApprovals,
              builder: (context, state) =>
                  const ceo_approvals.ApprovalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoReports,
              builder: (context, state) => const ceo_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooOperationsOverview,
              builder: (context, state) =>
                  const coo_operations_overview.OperationsOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooBranchOperations,
              builder: (context, state) =>
                  const coo_branch_operations.BranchOperationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooStaffingEfficiency,
              builder: (context, state) =>
                  const coo_staffing_efficiency.StaffingEfficiencyScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooSchedulingHealth,
              builder: (context, state) =>
                  const coo_scheduling_health.SchedulingHealthScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooServiceDelivery,
              builder: (context, state) =>
                  const coo_service_delivery.ServiceDeliveryScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooIssueEscalations,
              builder: (context, state) =>
                  const coo_issue_escalations.IssueEscalationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooComplianceView,
              builder: (context, state) =>
                  const coo_compliance_view.ComplianceViewScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooWorkflowPerformance,
              builder: (context, state) =>
                  const coo_workflow_performance.WorkflowPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooBranchComparison,
              builder: (context, state) =>
                  const coo_branch_comparison.BranchComparisonScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooReports,
              builder: (context, state) => const coo_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoFinancialOverview,
              builder: (context, state) =>
                  const cfo_financial_overview.FinancialOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoRevenue,
              builder: (context, state) => const cfo_revenue.RevenueScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoExpenses,
              builder: (context, state) => const cfo_expenses.ExpensesScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoFranchiseFinancials,
              builder: (context, state) =>
                  const cfo_franchise_financials.FranchiseFinancialsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoPayroll,
              builder: (context, state) => const cfo_payroll.PayrollScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoAccountsReceivable,
              builder: (context, state) =>
                  const cfo_accounts_receivable.AccountsReceivableScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoAccountsPayable,
              builder: (context, state) =>
                  const cfo_accounts_payable.AccountsPayableScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoInvoices,
              builder: (context, state) => const cfo_invoices.InvoicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoProfitability,
              builder: (context, state) =>
                  const cfo_profitability.ProfitabilityScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoTaxAndRemittance,
              builder: (context, state) =>
                  const cfo_tax_and_remittance.TaxAndRemittanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoReports,
              builder: (context, state) => const cfo_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoSystemHealth,
              builder: (context, state) =>
                  const cto_system_health.SystemHealthScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoPlatformUsage,
              builder: (context, state) =>
                  const cto_platform_usage.PlatformUsageScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoFeatureAdoption,
              builder: (context, state) =>
                  const cto_feature_adoption.FeatureAdoptionScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoApiMonitoring,
              builder: (context, state) =>
                  const cto_api_monitoring.ApiMonitoringScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoIntegrations,
              builder: (context, state) =>
                  const cto_integrations.IntegrationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoAuditLogs,
              builder: (context, state) =>
                  const cto_audit_logs.AuditLogsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoAccessControl,
              builder: (context, state) =>
                  const cto_access_control.AccessControlScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoReleaseManagement,
              builder: (context, state) =>
                  const cto_release_management.ReleaseManagementScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoIssueTracking,
              builder: (context, state) =>
                  const cto_issue_tracking.IssueTrackingScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoInfrastructure,
              builder: (context, state) =>
                  const cto_infrastructure.InfrastructureScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoReports,
              builder: (context, state) => const cto_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerComplianceCases,
              builder: (context, state) =>
                  const compliance_manager_compliance_cases.ComplianceCasesScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerPolicies,
              builder: (context, state) =>
                  const compliance_manager_policies.PoliciesScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerAudits,
              builder: (context, state) =>
                  const compliance_manager_audits.AuditsScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerIncidentReview,
              builder: (context, state) =>
                  const compliance_manager_incident_review.IncidentReviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerCredentialTracking,
              builder: (context, state) =>
                  const compliance_manager_credential_tracking.CredentialTrackingScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerDocumentExpiry,
              builder: (context, state) =>
                  const compliance_manager_document_expiry.DocumentExpiryScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerRiskRegister,
              builder: (context, state) =>
                  const compliance_manager_risk_register.RiskRegisterScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerCorrectiveActions,
              builder: (context, state) =>
                  const compliance_manager_corrective_actions.CorrectiveActionsScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerTrainingCompliance,
              builder: (context, state) =>
                  const compliance_manager_training_compliance.TrainingComplianceScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerReports,
              builder: (context, state) =>
                  const compliance_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentLeadPipeline,
              builder: (context, state) =>
                  const head_of_business_development_lead_pipeline.LeadPipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentFranchisePipeline,
              builder: (context, state) =>
                  const head_of_business_development_franchise_pipeline.FranchisePipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentTerritoryMap,
              builder: (context, state) =>
                  const head_of_business_development_territory_map.TerritoryMapScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentPartnerships,
              builder: (context, state) =>
                  const head_of_business_development_partnerships.PartnershipsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentOpportunities,
              builder: (context, state) =>
                  const head_of_business_development_opportunities.OpportunitiesScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentSalesPerformance,
              builder: (context, state) =>
                  const head_of_business_development_sales_performance.SalesPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentExpansionForecast,
              builder: (context, state) =>
                  const head_of_business_development_expansion_forecast.ExpansionForecastScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentReports,
              builder: (context, state) =>
                  const head_of_business_development_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingCampaigns,
              builder: (context, state) =>
                  const head_of_marketing_campaigns.CampaignsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingLeads,
              builder: (context, state) =>
                  const head_of_marketing_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingFunnelAnalytics,
              builder: (context, state) =>
                  const head_of_marketing_funnel_analytics.FunnelAnalyticsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingBrandAssets,
              builder: (context, state) =>
                  const head_of_marketing_brand_assets.BrandAssetsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingRegionalCampaigns,
              builder: (context, state) =>
                  const head_of_marketing_regional_campaigns.RegionalCampaignsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingContentApproval,
              builder: (context, state) =>
                  const head_of_marketing_content_approval.ContentApprovalScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingPerformanceReports,
              builder: (context, state) =>
                  const head_of_marketing_performance_reports.PerformanceReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorTrainingPrograms,
              builder: (context, state) =>
                  const training_director_training_programs.TrainingProgramsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorStaffTrainingMatrix,
              builder: (context, state) =>
                  const training_director_staff_training_matrix.StaffTrainingMatrixScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorComplianceTraining,
              builder: (context, state) =>
                  const training_director_compliance_training.ComplianceTrainingScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorCourseLibrary,
              builder: (context, state) =>
                  const training_director_course_library.CourseLibraryScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorAssessments,
              builder: (context, state) =>
                  const training_director_assessments.AssessmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorCertifications,
              builder: (context, state) =>
                  const training_director_certifications.CertificationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorTrainerAssignments,
              builder: (context, state) =>
                  const training_director_trainer_assignments.TrainerAssignmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorReports,
              builder: (context, state) =>
                  const training_director_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmLeads,
              builder: (context, state) =>
                  const regional_bdm_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmFranchisePipeline,
              builder: (context, state) =>
                  const regional_bdm_franchise_pipeline.FranchisePipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmTerritoryGrowth,
              builder: (context, state) =>
                  const regional_bdm_territory_growth.TerritoryGrowthScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmMeetings,
              builder: (context, state) =>
                  const regional_bdm_meetings.MeetingsScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmDealTracker,
              builder: (context, state) =>
                  const regional_bdm_deal_tracker.DealTrackerScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmPartners,
              builder: (context, state) =>
                  const regional_bdm_partners.PartnersScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmCompetitorNotes,
              builder: (context, state) =>
                  const regional_bdm_competitor_notes.CompetitorNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmTasks,
              builder: (context, state) =>
                  const regional_bdm_tasks.TasksScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmReports,
              builder: (context, state) =>
                  const regional_bdm_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerLeads,
              builder: (context, state) =>
                  const franchise_sales_manager_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerProspects,
              builder: (context, state) =>
                  const franchise_sales_manager_prospects.ProspectsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerDiscoveryCalls,
              builder: (context, state) =>
                  const franchise_sales_manager_discovery_calls.DiscoveryCallsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerProposals,
              builder: (context, state) =>
                  const franchise_sales_manager_proposals.ProposalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerSalesPipeline,
              builder: (context, state) =>
                  const franchise_sales_manager_sales_pipeline.SalesPipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerContracts,
              builder: (context, state) =>
                  const franchise_sales_manager_contracts.ContractsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerFollowUps,
              builder: (context, state) =>
                  const franchise_sales_manager_follow_ups.FollowUpsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerReports,
              builder: (context, state) =>
                  const franchise_sales_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerPartners,
              builder: (context, state) =>
                  const partnership_manager_partners.PartnersScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerOutreach,
              builder: (context, state) =>
                  const partnership_manager_outreach.OutreachScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerActiveDeals,
              builder: (context, state) =>
                  const partnership_manager_active_deals.ActiveDealsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerProposals,
              builder: (context, state) =>
                  const partnership_manager_proposals.ProposalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerRenewals,
              builder: (context, state) =>
                  const partnership_manager_renewals.RenewalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerReports,
              builder: (context, state) =>
                  const partnership_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerTerritoryMap,
              builder: (context, state) =>
                  const territory_expansion_manager_territory_map.TerritoryMapScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerMarketResearch,
              builder: (context, state) =>
                  const territory_expansion_manager_market_research.MarketResearchScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerDemographics,
              builder: (context, state) =>
                  const territory_expansion_manager_demographics.DemographicsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerOpenTerritories,
              builder: (context, state) =>
                  const territory_expansion_manager_open_territories.OpenTerritoriesScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerExpansionPlans,
              builder: (context, state) =>
                  const territory_expansion_manager_expansion_plans.ExpansionPlansScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerSiteSelection,
              builder: (context, state) =>
                  const territory_expansion_manager_site_selection.SiteSelectionScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerForecast,
              builder: (context, state) =>
                  const territory_expansion_manager_forecast.ForecastScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerReports,
              builder: (context, state) =>
                  const territory_expansion_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerBranchOverview,
              builder: (context, state) =>
                  const franchise_owner_branch_overview.BranchOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerFinancialSnapshot,
              builder: (context, state) =>
                  const franchise_owner_financial_snapshot.FinancialSnapshotScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerStaff,
              builder: (context, state) =>
                  const franchise_owner_staff.StaffScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerAppointments,
              builder: (context, state) =>
                  const franchise_owner_appointments.AppointmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerClients,
              builder: (context, state) =>
                  const franchise_owner_clients.ClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerCompliance,
              builder: (context, state) =>
                  const franchise_owner_compliance.ComplianceScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerReports,
              builder: (context, state) =>
                  const franchise_owner_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerHiring,
              builder: (context, state) =>
                  const franchise_owner_hiring.HiringScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerDailyOperations,
              builder: (context, state) =>
                  const operations_manager_daily_operations.DailyOperationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerSchedule,
              builder: (context, state) =>
                  const operations_manager_schedule.ScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerShifts,
              builder: (context, state) =>
                  const operations_manager_shifts.ShiftsScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerIssues,
              builder: (context, state) =>
                  const operations_manager_issues.IssuesScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerServiceQuality,
              builder: (context, state) =>
                  const operations_manager_service_quality.ServiceQualityScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerStaffCoordination,
              builder: (context, state) =>
                  const operations_manager_staff_coordination.StaffCoordinationScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerAttendance,
              builder: (context, state) =>
                  const operations_manager_attendance.AttendanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerReports,
              builder: (context, state) =>
                  const operations_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorAppointmentCalendar,
              builder: (context, state) =>
                  const scheduler_coordinator_appointment_calendar.AppointmentCalendarScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorShiftCalendar,
              builder: (context, state) =>
                  const scheduler_coordinator_shift_calendar.ShiftCalendarScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorProviderAvailability,
              builder: (context, state) =>
                  const scheduler_coordinator_provider_availability.ProviderAvailabilityScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorBookingRequests,
              builder: (context, state) =>
                  const scheduler_coordinator_booking_requests.BookingRequestsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorOpenShifts,
              builder: (context, state) =>
                  const scheduler_coordinator_open_shifts.OpenShiftsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorAssignments,
              builder: (context, state) =>
                  const scheduler_coordinator_assignments.AssignmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorConflicts,
              builder: (context, state) =>
                  const scheduler_coordinator_conflicts.ConflictsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorReports,
              builder: (context, state) =>
                  const scheduler_coordinator_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminInvoices,
              builder: (context, state) =>
                  const admin_invoices.InvoicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminPayments,
              builder: (context, state) =>
                  const admin_payments.PaymentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminClaims,
              builder: (context, state) => const admin_claims.ClaimsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminReconciliation,
              builder: (context, state) =>
                  const admin_reconciliation.ReconciliationScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminOutstandingBalances,
              builder: (context, state) =>
                  const admin_outstanding_balances.OutstandingBalancesScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminRefunds,
              builder: (context, state) => const admin_refunds.RefundsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminReports,
              builder: (context, state) => const admin_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringApplicants,
              builder: (context, state) =>
                  const hr_hiring_applicants.ApplicantsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringInterviews,
              builder: (context, state) =>
                  const hr_hiring_interviews.InterviewsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringOffers,
              builder: (context, state) =>
                  const hr_hiring_offers.OffersScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringOnboarding,
              builder: (context, state) =>
                  const hr_hiring_onboarding.OnboardingScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringStaffDocuments,
              builder: (context, state) =>
                  const hr_hiring_staff_documents.StaffDocumentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringCredentials,
              builder: (context, state) =>
                  const hr_hiring_credentials.CredentialsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringTrainingStatus,
              builder: (context, state) =>
                  const hr_hiring_training_status.TrainingStatusScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringReports,
              builder: (context, state) =>
                  const hr_hiring_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnTodaysSchedule,
              builder: (context, state) =>
                  const rn_todays_schedule.TodaysScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnAssignedClients,
              builder: (context, state) =>
                  const rn_assigned_clients.AssignedClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnNursingNotes,
              builder: (context, state) =>
                  const rn_nursing_notes.NursingNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnCarePlans,
              builder: (context, state) =>
                  const rn_care_plans.CarePlansScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnMedicationNotes,
              builder: (context, state) =>
                  const rn_medication_notes.MedicationNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnVitals,
              builder: (context, state) => const rn_vitals.VitalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnIncidentReports,
              builder: (context, state) =>
                  const rn_incident_reports.IncidentReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnProgressUpdates,
              builder: (context, state) =>
                  const rn_progress_updates.ProgressUpdatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnClientHistory,
              builder: (context, state) =>
                  const rn_client_history.ClientHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnTodaysSchedule,
              builder: (context, state) =>
                  const rpn_todays_schedule.TodaysScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnAssignedClients,
              builder: (context, state) =>
                  const rpn_assigned_clients.AssignedClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnNursingNotes,
              builder: (context, state) =>
                  const rpn_nursing_notes.NursingNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnCareUpdates,
              builder: (context, state) =>
                  const rpn_care_updates.CareUpdatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnVitals,
              builder: (context, state) => const rpn_vitals.VitalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnMedicationSupport,
              builder: (context, state) =>
                  const rpn_medication_support.MedicationSupportScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnClientHistory,
              builder: (context, state) =>
                  const rpn_client_history.ClientHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnIncidentReports,
              builder: (context, state) =>
                  const rpn_incident_reports.IncidentReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtTodaysSchedule,
              builder: (context, state) =>
                  const rmt_todays_schedule.TodaysScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtClients,
              builder: (context, state) => const rmt_clients.ClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtAssessment,
              builder: (context, state) =>
                  const rmt_assessment.AssessmentScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtSoapNotes,
              builder: (context, state) =>
                  const rmt_soap_notes.SoapNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtTreatmentPlans,
              builder: (context, state) =>
                  const rmt_treatment_plans.TreatmentPlansScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtHomecare,
              builder: (context, state) => const rmt_homecare.HomecareScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtSessionHistory,
              builder: (context, state) =>
                  const rmt_session_history.SessionHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtBodyChart,
              builder: (context, state) =>
                  const rmt_body_chart.BodyChartScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtIntakeForms,
              builder: (context, state) =>
                  const rmt_intake_forms.IntakeFormsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtInvoices,
              builder: (context, state) => const rmt_invoices.InvoicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportTickets,
              builder: (context, state) =>
                  const customer_support_tickets.TicketsScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportEscalations,
              builder: (context, state) =>
                  const customer_support_escalations.EscalationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportIssueCategories,
              builder: (context, state) =>
                  const customer_support_issue_categories.IssueCategoriesScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportTemplates,
              builder: (context, state) =>
                  const customer_support_templates.TemplatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportReports,
              builder: (context, state) =>
                  const customer_support_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorNewIntakes,
              builder: (context, state) =>
                  const intake_coordinator_new_intakes.NewIntakesScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorIntakeForms,
              builder: (context, state) =>
                  const intake_coordinator_intake_forms.IntakeFormsScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorEligibility,
              builder: (context, state) =>
                  const intake_coordinator_eligibility.EligibilityScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorScheduling,
              builder: (context, state) =>
                  const intake_coordinator_scheduling.SchedulingScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorClientAssignment,
              builder: (context, state) =>
                  const intake_coordinator_client_assignment.ClientAssignmentScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorReports,
              builder: (context, state) =>
                  const intake_coordinator_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceAudits,
              builder: (context, state) =>
                  const quality_assurance_audits.AuditsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceReviews,
              builder: (context, state) =>
                  const quality_assurance_reviews.ReviewsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceComplaints,
              builder: (context, state) =>
                  const quality_assurance_complaints.ComplaintsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceCorrectiveActions,
              builder: (context, state) =>
                  const quality_assurance_corrective_actions.CorrectiveActionsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceScorecards,
              builder: (context, state) =>
                  const quality_assurance_scorecards.ScorecardsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceComplianceChecks,
              builder: (context, state) =>
                  const quality_assurance_compliance_checks.ComplianceChecksScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceReports,
              builder: (context, state) =>
                  const quality_assurance_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorTrainingSchedule,
              builder: (context, state) =>
                  const training_coordinator_training_schedule.TrainingScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorCourses,
              builder: (context, state) =>
                  const training_coordinator_courses.CoursesScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorProgress,
              builder: (context, state) =>
                  const training_coordinator_progress.ProgressScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorWorkshops,
              builder: (context, state) =>
                  const training_coordinator_workshops.WorkshopsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorAttendance,
              builder: (context, state) =>
                  const training_coordinator_attendance.AttendanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorMaterials,
              builder: (context, state) =>
                  const training_coordinator_materials.MaterialsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorCertifications,
              builder: (context, state) =>
                  const training_coordinator_certifications.CertificationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorReports,
              builder: (context, state) =>
                  const training_coordinator_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerCampaigns,
              builder: (context, state) =>
                  const local_marketing_manager_campaigns.CampaignsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerLeads,
              builder: (context, state) =>
                  const local_marketing_manager_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerContentCalendar,
              builder: (context, state) =>
                  const local_marketing_manager_content_calendar.ContentCalendarScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerEvents,
              builder: (context, state) =>
                  const local_marketing_manager_events.EventsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerBudget,
              builder: (context, state) =>
                  const local_marketing_manager_budget.BudgetScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerReports,
              builder: (context, state) =>
                  const local_marketing_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerAssets,
              builder: (context, state) =>
                  const local_marketing_manager_assets.AssetsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachPrograms,
              builder: (context, state) =>
                  const community_outreach_programs.ProgramsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachEvents,
              builder: (context, state) =>
                  const community_outreach_events.EventsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachPartnerships,
              builder: (context, state) =>
                  const community_outreach_partnerships.PartnershipsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachVolunteers,
              builder: (context, state) =>
                  const community_outreach_volunteers.VolunteersScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachContacts,
              builder: (context, state) =>
                  const community_outreach_contacts.ContactsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachFollowUps,
              builder: (context, state) =>
                  const community_outreach_follow_ups.FollowUpsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachReports,
              builder: (context, state) =>
                  const community_outreach_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerLeads,
              builder: (context, state) =>
                  const territory_sales_manager_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerPipeline,
              builder: (context, state) =>
                  const territory_sales_manager_pipeline.PipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerFieldActivity,
              builder: (context, state) =>
                  const territory_sales_manager_field_activity.FieldActivityScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerConversions,
              builder: (context, state) =>
                  const territory_sales_manager_conversions.ConversionsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerAreaPerformance,
              builder: (context, state) =>
                  const territory_sales_manager_area_performance.AreaPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerCompetitors,
              builder: (context, state) =>
                  const territory_sales_manager_competitors.CompetitorsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerReports,
              builder: (context, state) =>
                  const territory_sales_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientBookAppointment,
              builder: (context, state) =>
                  const client_book_appointment.BookAppointmentScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientMyAppointments,
              builder: (context, state) =>
                  const client_my_appointments.MyAppointmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientCareTeam,
              builder: (context, state) =>
                  const client_care_team.CareTeamScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientTreatmentHistory,
              builder: (context, state) =>
                  const client_treatment_history.TreatmentHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientPayments,
              builder: (context, state) =>
                  const client_payments.PaymentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientProfile,
              builder: (context, state) => const client_profile.ProfileScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberLovedOneSchedule,
              builder: (context, state) =>
                  const family_member_loved_one_schedule.LovedOneScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberCareUpdates,
              builder: (context, state) =>
                  const family_member_care_updates.CareUpdatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberBilling,
              builder: (context, state) =>
                  const family_member_billing.BillingScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberEmergencyContacts,
              builder: (context, state) =>
                  const family_member_emergency_contacts.EmergencyContactsScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberProfile,
              builder: (context, state) =>
                  const family_member_profile.ProfileScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoEnterpriseOverview,
              builder: (context, state) =>
                  const ceo_enterprise_overview.EnterpriseOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoFranchiseOverview,
              builder: (context, state) =>
                  const ceo_franchise_overview.FranchiseOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoRegionPerformance,
              builder: (context, state) =>
                  const ceo_region_performance.RegionPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoRevenueSummary,
              builder: (context, state) =>
                  const ceo_revenue_summary.RevenueSummaryScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoStrategicKpis,
              builder: (context, state) =>
                  const ceo_strategic_kpis.StrategicKpisScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoGrowthPipeline,
              builder: (context, state) =>
                  const ceo_growth_pipeline.GrowthPipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoLeadershipReports,
              builder: (context, state) =>
                  const ceo_leadership_reports.LeadershipReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoAlertsAndRisks,
              builder: (context, state) =>
                  const ceo_alerts_and_risks.AlertsAndRisksScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoOrganizationMap,
              builder: (context, state) =>
                  const ceo_organization_map.OrganizationMapScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoApprovals,
              builder: (context, state) =>
                  const ceo_approvals.ApprovalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ceoReports,
              builder: (context, state) => const ceo_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooOperationsOverview,
              builder: (context, state) =>
                  const coo_operations_overview.OperationsOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooBranchOperations,
              builder: (context, state) =>
                  const coo_branch_operations.BranchOperationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooStaffingEfficiency,
              builder: (context, state) =>
                  const coo_staffing_efficiency.StaffingEfficiencyScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooSchedulingHealth,
              builder: (context, state) =>
                  const coo_scheduling_health.SchedulingHealthScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooServiceDelivery,
              builder: (context, state) =>
                  const coo_service_delivery.ServiceDeliveryScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooIssueEscalations,
              builder: (context, state) =>
                  const coo_issue_escalations.IssueEscalationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooComplianceView,
              builder: (context, state) =>
                  const coo_compliance_view.ComplianceViewScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooWorkflowPerformance,
              builder: (context, state) =>
                  const coo_workflow_performance.WorkflowPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooBranchComparison,
              builder: (context, state) =>
                  const coo_branch_comparison.BranchComparisonScreen(),
            ),
            GoRoute(
              path: AppRoutes.cooReports,
              builder: (context, state) => const coo_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoFinancialOverview,
              builder: (context, state) =>
                  const cfo_financial_overview.FinancialOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoRevenue,
              builder: (context, state) => const cfo_revenue.RevenueScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoExpenses,
              builder: (context, state) => const cfo_expenses.ExpensesScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoFranchiseFinancials,
              builder: (context, state) =>
                  const cfo_franchise_financials.FranchiseFinancialsScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoPayroll,
              builder: (context, state) => const cfo_payroll.PayrollScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoAccountsReceivable,
              builder: (context, state) =>
                  const cfo_accounts_receivable.AccountsReceivableScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoAccountsPayable,
              builder: (context, state) =>
                  const cfo_accounts_payable.AccountsPayableScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoInvoices,
              builder: (context, state) => const cfo_invoices.InvoicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoProfitability,
              builder: (context, state) =>
                  const cfo_profitability.ProfitabilityScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoTaxAndRemittance,
              builder: (context, state) =>
                  const cfo_tax_and_remittance.TaxAndRemittanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.cfoReports,
              builder: (context, state) => const cfo_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoSystemHealth,
              builder: (context, state) =>
                  const cto_system_health.SystemHealthScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoPlatformUsage,
              builder: (context, state) =>
                  const cto_platform_usage.PlatformUsageScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoFeatureAdoption,
              builder: (context, state) =>
                  const cto_feature_adoption.FeatureAdoptionScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoApiMonitoring,
              builder: (context, state) =>
                  const cto_api_monitoring.ApiMonitoringScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoIntegrations,
              builder: (context, state) =>
                  const cto_integrations.IntegrationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoAuditLogs,
              builder: (context, state) =>
                  const cto_audit_logs.AuditLogsScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoAccessControl,
              builder: (context, state) =>
                  const cto_access_control.AccessControlScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoReleaseManagement,
              builder: (context, state) =>
                  const cto_release_management.ReleaseManagementScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoIssueTracking,
              builder: (context, state) =>
                  const cto_issue_tracking.IssueTrackingScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoInfrastructure,
              builder: (context, state) =>
                  const cto_infrastructure.InfrastructureScreen(),
            ),
            GoRoute(
              path: AppRoutes.ctoReports,
              builder: (context, state) => const cto_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerComplianceCases,
              builder: (context, state) =>
                  const compliance_manager_compliance_cases.ComplianceCasesScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerPolicies,
              builder: (context, state) =>
                  const compliance_manager_policies.PoliciesScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerAudits,
              builder: (context, state) =>
                  const compliance_manager_audits.AuditsScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerIncidentReview,
              builder: (context, state) =>
                  const compliance_manager_incident_review.IncidentReviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerCredentialTracking,
              builder: (context, state) =>
                  const compliance_manager_credential_tracking.CredentialTrackingScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerDocumentExpiry,
              builder: (context, state) =>
                  const compliance_manager_document_expiry.DocumentExpiryScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerRiskRegister,
              builder: (context, state) =>
                  const compliance_manager_risk_register.RiskRegisterScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerCorrectiveActions,
              builder: (context, state) =>
                  const compliance_manager_corrective_actions.CorrectiveActionsScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerTrainingCompliance,
              builder: (context, state) =>
                  const compliance_manager_training_compliance.TrainingComplianceScreen(),
            ),
            GoRoute(
              path: AppRoutes.complianceManagerReports,
              builder: (context, state) =>
                  const compliance_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentLeadPipeline,
              builder: (context, state) =>
                  const head_of_business_development_lead_pipeline.LeadPipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentFranchisePipeline,
              builder: (context, state) =>
                  const head_of_business_development_franchise_pipeline.FranchisePipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentTerritoryMap,
              builder: (context, state) =>
                  const head_of_business_development_territory_map.TerritoryMapScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentPartnerships,
              builder: (context, state) =>
                  const head_of_business_development_partnerships.PartnershipsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentOpportunities,
              builder: (context, state) =>
                  const head_of_business_development_opportunities.OpportunitiesScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentSalesPerformance,
              builder: (context, state) =>
                  const head_of_business_development_sales_performance.SalesPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentExpansionForecast,
              builder: (context, state) =>
                  const head_of_business_development_expansion_forecast.ExpansionForecastScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfBusinessDevelopmentReports,
              builder: (context, state) =>
                  const head_of_business_development_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingCampaigns,
              builder: (context, state) =>
                  const head_of_marketing_campaigns.CampaignsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingLeads,
              builder: (context, state) =>
                  const head_of_marketing_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingFunnelAnalytics,
              builder: (context, state) =>
                  const head_of_marketing_funnel_analytics.FunnelAnalyticsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingBrandAssets,
              builder: (context, state) =>
                  const head_of_marketing_brand_assets.BrandAssetsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingRegionalCampaigns,
              builder: (context, state) =>
                  const head_of_marketing_regional_campaigns.RegionalCampaignsScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingContentApproval,
              builder: (context, state) =>
                  const head_of_marketing_content_approval.ContentApprovalScreen(),
            ),
            GoRoute(
              path: AppRoutes.headOfMarketingPerformanceReports,
              builder: (context, state) =>
                  const head_of_marketing_performance_reports.PerformanceReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorTrainingPrograms,
              builder: (context, state) =>
                  const training_director_training_programs.TrainingProgramsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorStaffTrainingMatrix,
              builder: (context, state) =>
                  const training_director_staff_training_matrix.StaffTrainingMatrixScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorComplianceTraining,
              builder: (context, state) =>
                  const training_director_compliance_training.ComplianceTrainingScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorCourseLibrary,
              builder: (context, state) =>
                  const training_director_course_library.CourseLibraryScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorAssessments,
              builder: (context, state) =>
                  const training_director_assessments.AssessmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorCertifications,
              builder: (context, state) =>
                  const training_director_certifications.CertificationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorTrainerAssignments,
              builder: (context, state) =>
                  const training_director_trainer_assignments.TrainerAssignmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingDirectorReports,
              builder: (context, state) =>
                  const training_director_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmLeads,
              builder: (context, state) =>
                  const regional_bdm_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmFranchisePipeline,
              builder: (context, state) =>
                  const regional_bdm_franchise_pipeline.FranchisePipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmTerritoryGrowth,
              builder: (context, state) =>
                  const regional_bdm_territory_growth.TerritoryGrowthScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmMeetings,
              builder: (context, state) =>
                  const regional_bdm_meetings.MeetingsScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmDealTracker,
              builder: (context, state) =>
                  const regional_bdm_deal_tracker.DealTrackerScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmPartners,
              builder: (context, state) =>
                  const regional_bdm_partners.PartnersScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmCompetitorNotes,
              builder: (context, state) =>
                  const regional_bdm_competitor_notes.CompetitorNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmTasks,
              builder: (context, state) =>
                  const regional_bdm_tasks.TasksScreen(),
            ),
            GoRoute(
              path: AppRoutes.regionalBdmReports,
              builder: (context, state) =>
                  const regional_bdm_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerLeads,
              builder: (context, state) =>
                  const franchise_sales_manager_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerProspects,
              builder: (context, state) =>
                  const franchise_sales_manager_prospects.ProspectsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerDiscoveryCalls,
              builder: (context, state) =>
                  const franchise_sales_manager_discovery_calls.DiscoveryCallsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerProposals,
              builder: (context, state) =>
                  const franchise_sales_manager_proposals.ProposalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerSalesPipeline,
              builder: (context, state) =>
                  const franchise_sales_manager_sales_pipeline.SalesPipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerContracts,
              builder: (context, state) =>
                  const franchise_sales_manager_contracts.ContractsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerFollowUps,
              builder: (context, state) =>
                  const franchise_sales_manager_follow_ups.FollowUpsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseSalesManagerReports,
              builder: (context, state) =>
                  const franchise_sales_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerPartners,
              builder: (context, state) =>
                  const partnership_manager_partners.PartnersScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerOutreach,
              builder: (context, state) =>
                  const partnership_manager_outreach.OutreachScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerActiveDeals,
              builder: (context, state) =>
                  const partnership_manager_active_deals.ActiveDealsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerProposals,
              builder: (context, state) =>
                  const partnership_manager_proposals.ProposalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerRenewals,
              builder: (context, state) =>
                  const partnership_manager_renewals.RenewalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.partnershipManagerReports,
              builder: (context, state) =>
                  const partnership_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerTerritoryMap,
              builder: (context, state) =>
                  const territory_expansion_manager_territory_map.TerritoryMapScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerMarketResearch,
              builder: (context, state) =>
                  const territory_expansion_manager_market_research.MarketResearchScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerDemographics,
              builder: (context, state) =>
                  const territory_expansion_manager_demographics.DemographicsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerOpenTerritories,
              builder: (context, state) =>
                  const territory_expansion_manager_open_territories.OpenTerritoriesScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerExpansionPlans,
              builder: (context, state) =>
                  const territory_expansion_manager_expansion_plans.ExpansionPlansScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerSiteSelection,
              builder: (context, state) =>
                  const territory_expansion_manager_site_selection.SiteSelectionScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerForecast,
              builder: (context, state) =>
                  const territory_expansion_manager_forecast.ForecastScreen(),
            ),
            GoRoute(
              path: AppRoutes.territoryExpansionManagerReports,
              builder: (context, state) =>
                  const territory_expansion_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerBranchOverview,
              builder: (context, state) =>
                  const franchise_owner_branch_overview.BranchOverviewScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerFinancialSnapshot,
              builder: (context, state) =>
                  const franchise_owner_financial_snapshot.FinancialSnapshotScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerStaff,
              builder: (context, state) =>
                  const franchise_owner_staff.StaffScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerAppointments,
              builder: (context, state) =>
                  const franchise_owner_appointments.AppointmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerClients,
              builder: (context, state) =>
                  const franchise_owner_clients.ClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerCompliance,
              builder: (context, state) =>
                  const franchise_owner_compliance.ComplianceScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerReports,
              builder: (context, state) =>
                  const franchise_owner_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.franchiseOwnerHiring,
              builder: (context, state) =>
                  const franchise_owner_hiring.HiringScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerDailyOperations,
              builder: (context, state) =>
                  const operations_manager_daily_operations.DailyOperationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerSchedule,
              builder: (context, state) =>
                  const operations_manager_schedule.ScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerShifts,
              builder: (context, state) =>
                  const operations_manager_shifts.ShiftsScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerIssues,
              builder: (context, state) =>
                  const operations_manager_issues.IssuesScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerServiceQuality,
              builder: (context, state) =>
                  const operations_manager_service_quality.ServiceQualityScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerStaffCoordination,
              builder: (context, state) =>
                  const operations_manager_staff_coordination.StaffCoordinationScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerAttendance,
              builder: (context, state) =>
                  const operations_manager_attendance.AttendanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.operationsManagerReports,
              builder: (context, state) =>
                  const operations_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorAppointmentCalendar,
              builder: (context, state) =>
                  const scheduler_coordinator_appointment_calendar.AppointmentCalendarScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorShiftCalendar,
              builder: (context, state) =>
                  const scheduler_coordinator_shift_calendar.ShiftCalendarScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorProviderAvailability,
              builder: (context, state) =>
                  const scheduler_coordinator_provider_availability.ProviderAvailabilityScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorBookingRequests,
              builder: (context, state) =>
                  const scheduler_coordinator_booking_requests.BookingRequestsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorOpenShifts,
              builder: (context, state) =>
                  const scheduler_coordinator_open_shifts.OpenShiftsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorAssignments,
              builder: (context, state) =>
                  const scheduler_coordinator_assignments.AssignmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorConflicts,
              builder: (context, state) =>
                  const scheduler_coordinator_conflicts.ConflictsScreen(),
            ),
            GoRoute(
              path: AppRoutes.schedulerCoordinatorReports,
              builder: (context, state) =>
                  const scheduler_coordinator_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminInvoices,
              builder: (context, state) =>
                  const admin_invoices.InvoicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminPayments,
              builder: (context, state) =>
                  const admin_payments.PaymentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminClaims,
              builder: (context, state) => const admin_claims.ClaimsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminReconciliation,
              builder: (context, state) =>
                  const admin_reconciliation.ReconciliationScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminOutstandingBalances,
              builder: (context, state) =>
                  const admin_outstanding_balances.OutstandingBalancesScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminRefunds,
              builder: (context, state) => const admin_refunds.RefundsScreen(),
            ),
            GoRoute(
              path: AppRoutes.adminReports,
              builder: (context, state) => const admin_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringApplicants,
              builder: (context, state) =>
                  const hr_hiring_applicants.ApplicantsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringInterviews,
              builder: (context, state) =>
                  const hr_hiring_interviews.InterviewsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringOffers,
              builder: (context, state) =>
                  const hr_hiring_offers.OffersScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringOnboarding,
              builder: (context, state) =>
                  const hr_hiring_onboarding.OnboardingScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringStaffDocuments,
              builder: (context, state) =>
                  const hr_hiring_staff_documents.StaffDocumentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringCredentials,
              builder: (context, state) =>
                  const hr_hiring_credentials.CredentialsScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringTrainingStatus,
              builder: (context, state) =>
                  const hr_hiring_training_status.TrainingStatusScreen(),
            ),
            GoRoute(
              path: AppRoutes.hrHiringReports,
              builder: (context, state) =>
                  const hr_hiring_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnTodaysSchedule,
              builder: (context, state) =>
                  const rn_todays_schedule.TodaysScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnAssignedClients,
              builder: (context, state) =>
                  const rn_assigned_clients.AssignedClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnNursingNotes,
              builder: (context, state) =>
                  const rn_nursing_notes.NursingNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnCarePlans,
              builder: (context, state) =>
                  const rn_care_plans.CarePlansScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnMedicationNotes,
              builder: (context, state) =>
                  const rn_medication_notes.MedicationNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnVitals,
              builder: (context, state) => const rn_vitals.VitalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnIncidentReports,
              builder: (context, state) =>
                  const rn_incident_reports.IncidentReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnProgressUpdates,
              builder: (context, state) =>
                  const rn_progress_updates.ProgressUpdatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rnClientHistory,
              builder: (context, state) =>
                  const rn_client_history.ClientHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnTodaysSchedule,
              builder: (context, state) =>
                  const rpn_todays_schedule.TodaysScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnAssignedClients,
              builder: (context, state) =>
                  const rpn_assigned_clients.AssignedClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnNursingNotes,
              builder: (context, state) =>
                  const rpn_nursing_notes.NursingNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnCareUpdates,
              builder: (context, state) =>
                  const rpn_care_updates.CareUpdatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnVitals,
              builder: (context, state) => const rpn_vitals.VitalsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnMedicationSupport,
              builder: (context, state) =>
                  const rpn_medication_support.MedicationSupportScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnClientHistory,
              builder: (context, state) =>
                  const rpn_client_history.ClientHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.rpnIncidentReports,
              builder: (context, state) =>
                  const rpn_incident_reports.IncidentReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtTodaysSchedule,
              builder: (context, state) =>
                  const rmt_todays_schedule.TodaysScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtClients,
              builder: (context, state) => const rmt_clients.ClientsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtAssessment,
              builder: (context, state) =>
                  const rmt_assessment.AssessmentScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtSoapNotes,
              builder: (context, state) =>
                  const rmt_soap_notes.SoapNotesScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtTreatmentPlans,
              builder: (context, state) =>
                  const rmt_treatment_plans.TreatmentPlansScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtHomecare,
              builder: (context, state) => const rmt_homecare.HomecareScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtSessionHistory,
              builder: (context, state) =>
                  const rmt_session_history.SessionHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtBodyChart,
              builder: (context, state) =>
                  const rmt_body_chart.BodyChartScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtIntakeForms,
              builder: (context, state) =>
                  const rmt_intake_forms.IntakeFormsScreen(),
            ),
            GoRoute(
              path: AppRoutes.rmtInvoices,
              builder: (context, state) => const rmt_invoices.InvoicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportTickets,
              builder: (context, state) =>
                  const customer_support_tickets.TicketsScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportEscalations,
              builder: (context, state) =>
                  const customer_support_escalations.EscalationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportIssueCategories,
              builder: (context, state) =>
                  const customer_support_issue_categories.IssueCategoriesScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportTemplates,
              builder: (context, state) =>
                  const customer_support_templates.TemplatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.customerSupportReports,
              builder: (context, state) =>
                  const customer_support_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorNewIntakes,
              builder: (context, state) =>
                  const intake_coordinator_new_intakes.NewIntakesScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorIntakeForms,
              builder: (context, state) =>
                  const intake_coordinator_intake_forms.IntakeFormsScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorEligibility,
              builder: (context, state) =>
                  const intake_coordinator_eligibility.EligibilityScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorScheduling,
              builder: (context, state) =>
                  const intake_coordinator_scheduling.SchedulingScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorClientAssignment,
              builder: (context, state) =>
                  const intake_coordinator_client_assignment.ClientAssignmentScreen(),
            ),
            GoRoute(
              path: AppRoutes.intakeCoordinatorReports,
              builder: (context, state) =>
                  const intake_coordinator_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceAudits,
              builder: (context, state) =>
                  const quality_assurance_audits.AuditsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceReviews,
              builder: (context, state) =>
                  const quality_assurance_reviews.ReviewsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceComplaints,
              builder: (context, state) =>
                  const quality_assurance_complaints.ComplaintsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceCorrectiveActions,
              builder: (context, state) =>
                  const quality_assurance_corrective_actions.CorrectiveActionsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceScorecards,
              builder: (context, state) =>
                  const quality_assurance_scorecards.ScorecardsScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceComplianceChecks,
              builder: (context, state) =>
                  const quality_assurance_compliance_checks.ComplianceChecksScreen(),
            ),
            GoRoute(
              path: AppRoutes.qualityAssuranceReports,
              builder: (context, state) =>
                  const quality_assurance_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorTrainingSchedule,
              builder: (context, state) =>
                  const training_coordinator_training_schedule.TrainingScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorCourses,
              builder: (context, state) =>
                  const training_coordinator_courses.CoursesScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorProgress,
              builder: (context, state) =>
                  const training_coordinator_progress.ProgressScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorWorkshops,
              builder: (context, state) =>
                  const training_coordinator_workshops.WorkshopsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorAttendance,
              builder: (context, state) =>
                  const training_coordinator_attendance.AttendanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorMaterials,
              builder: (context, state) =>
                  const training_coordinator_materials.MaterialsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorCertifications,
              builder: (context, state) =>
                  const training_coordinator_certifications.CertificationsScreen(),
            ),
            GoRoute(
              path: AppRoutes.trainingCoordinatorReports,
              builder: (context, state) =>
                  const training_coordinator_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerCampaigns,
              builder: (context, state) =>
                  const local_marketing_manager_campaigns.CampaignsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerLeads,
              builder: (context, state) =>
                  const local_marketing_manager_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerContentCalendar,
              builder: (context, state) =>
                  const local_marketing_manager_content_calendar.ContentCalendarScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerEvents,
              builder: (context, state) =>
                  const local_marketing_manager_events.EventsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerBudget,
              builder: (context, state) =>
                  const local_marketing_manager_budget.BudgetScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerReports,
              builder: (context, state) =>
                  const local_marketing_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.localMarketingManagerAssets,
              builder: (context, state) =>
                  const local_marketing_manager_assets.AssetsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachPrograms,
              builder: (context, state) =>
                  const community_outreach_programs.ProgramsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachEvents,
              builder: (context, state) =>
                  const community_outreach_events.EventsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachPartnerships,
              builder: (context, state) =>
                  const community_outreach_partnerships.PartnershipsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachVolunteers,
              builder: (context, state) =>
                  const community_outreach_volunteers.VolunteersScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachContacts,
              builder: (context, state) =>
                  const community_outreach_contacts.ContactsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachFollowUps,
              builder: (context, state) =>
                  const community_outreach_follow_ups.FollowUpsScreen(),
            ),
            GoRoute(
              path: AppRoutes.communityOutreachReports,
              builder: (context, state) =>
                  const community_outreach_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerLeads,
              builder: (context, state) =>
                  const territory_sales_manager_leads.LeadsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerPipeline,
              builder: (context, state) =>
                  const territory_sales_manager_pipeline.PipelineScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerFieldActivity,
              builder: (context, state) =>
                  const territory_sales_manager_field_activity.FieldActivityScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerConversions,
              builder: (context, state) =>
                  const territory_sales_manager_conversions.ConversionsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerAreaPerformance,
              builder: (context, state) =>
                  const territory_sales_manager_area_performance.AreaPerformanceScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerCompetitors,
              builder: (context, state) =>
                  const territory_sales_manager_competitors.CompetitorsScreen(),
            ),
            GoRoute(
              path: AppRoutes.territorySalesManagerReports,
              builder: (context, state) =>
                  const territory_sales_manager_reports.ReportsScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientBookAppointment,
              builder: (context, state) =>
                  const client_book_appointment.BookAppointmentScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientMyAppointments,
              builder: (context, state) =>
                  const client_my_appointments.MyAppointmentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientCareTeam,
              builder: (context, state) =>
                  const client_care_team.CareTeamScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientTreatmentHistory,
              builder: (context, state) =>
                  const client_treatment_history.TreatmentHistoryScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientPayments,
              builder: (context, state) =>
                  const client_payments.PaymentsScreen(),
            ),
            GoRoute(
              path: AppRoutes.clientProfile,
              builder: (context, state) => const client_profile.ProfileScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberLovedOneSchedule,
              builder: (context, state) =>
                  const family_member_loved_one_schedule.LovedOneScheduleScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberCareUpdates,
              builder: (context, state) =>
                  const family_member_care_updates.CareUpdatesScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberBilling,
              builder: (context, state) =>
                  const family_member_billing.BillingScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberEmergencyContacts,
              builder: (context, state) =>
                  const family_member_emergency_contacts.EmergencyContactsScreen(),
            ),
            GoRoute(
              path: AppRoutes.familyMemberProfile,
              builder: (context, state) =>
                  const family_member_profile.ProfileScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.customerSupportDashboard,
            builder: (context, state) =>
                const customer_support_dash.SupportDashboard(),
          ),
          GoRoute(
            path: AppRoutes.intakeCoordinatorDashboard,
            builder: (context, state) =>
                const intake_coordinator_dash.IntakeDashboard(),
          ),
          GoRoute(
            path: AppRoutes.qualityAssuranceDashboard,
            builder: (context, state) =>
                const quality_assurance_dash.QaDashboard(),
          ),
          GoRoute(
            path: AppRoutes.trainingCoordinatorDashboard,
            builder: (context, state) =>
                const training_coordinator_dash.TrainingCoordinatorDashboard(),
          ),
          GoRoute(
            path: AppRoutes.physioDashboard,
            builder: (context, state) => const physio_dash.PhysioDashboard(),
          ),
          GoRoute(
            path: AppRoutes.chiroDashboard,
            builder: (context, state) => const chiro_dash.ChiroDashboard(),
          ),
          GoRoute(
            path: AppRoutes.occupationalTherapistDashboard,
            builder: (context, state) => const ot_dash.OtDashboard(),
          ),
          GoRoute(
            path: AppRoutes.speechPathologistDashboard,
            builder: (context, state) => const slp_dash.SlpDashboard(),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) =>
            MasterLayout(shellType: AppShellType.client, child: child),
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: AppRoutes.patientDashboard,
            builder: (context, state) => const patient_dash.ClientDashboard(),
          ),
          GoRoute(
            path: AppRoutes.familyMemberDashboard,
            builder: (context, state) =>
                const family_member_dash.FamilyDashboard(),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) =>
            MasterLayout(shellType: AppShellType.admin, child: child),
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: AppRoutes.scrumMasterDashboard,
            builder: (context, state) =>
                const scrum_master_dash.ScrumMasterDashboard(),
          ),
        ],
      ),
    ],
  );
});
