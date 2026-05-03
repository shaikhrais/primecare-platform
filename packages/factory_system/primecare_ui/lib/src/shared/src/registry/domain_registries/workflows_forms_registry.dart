import 'package:primecare_ui/primecare_ui.dart';
import '../office_screen_registry.dart';

class WorkflowsFormsRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    _registerMetadataScreens();
  }

  void _registerMetadataScreens() {
    registerRoute(
      '/workflows-and-forms/add-franchise-lead-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AddFranchiseLeadForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/approve-expense-reimbursement-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ApproveExpenseReimbursementForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/approve-franchise-disclosure-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ApproveFranchiseDisclosureForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/approve-leave-request-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ApproveLeaveRequestForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/approve-medication-refill-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ApproveMedicationRefillForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/approve-payroll-run-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ApprovePayrollRunForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/approve-real-estate-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ApproveRealEstateForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/approve-system-access-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ApproveSystemAccessForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/assign-care-pod-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AssignCarePodForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/assign-lead-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AssignLeadForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/assign-training-module-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AssignTrainingModuleForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/audit-compliance-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AuditComplianceForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/audit-global-education-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AuditGlobalEducationForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/audit-override-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AuditOverrideForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/audit-payroll-discrepancy-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AuditPayrollDiscrepancyForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/audit-royalty-payment-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AuditRoyaltyPaymentForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/audit-security-compliance-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AuditSecurityComplianceForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/audit-system-logs-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_AuditSystemLogsForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/care-plan-evaluation-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_CarePlanEvaluationForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/create-ad-placement-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_CreateAdPlacementForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/create-canned-response-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_CreateCannedResponseForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/create-custom-invoice-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_CreateCustomInvoiceForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/create-revenue-report-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_CreateRevenueReportForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/create-supply-order-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_CreateSupplyOrderForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/daily-vitals-card-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_DailyVitalsCardForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/discipline-log-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_DisciplineLogForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/franchise-onboarding-checklist-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_FranchiseOnboardingChecklistForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/leave-request-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_LeaveRequestForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/log-clinical-incident-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_LogClinicalIncidentForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/log-employee-grievance-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_LogEmployeeGrievanceForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/log-franchisee-vetting-call-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_LogFranchiseeVettingCallForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/log-infection-control-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_LogInfectionControlForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/log-inventory-spoilage-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_LogInventorySpoilageForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/log-petty-cash-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_LogPettyCashForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/new-employee-onboarding-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_NewEmployeeOnboardingForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/nurture-localized-lead-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_NurtureLocalizedLeadForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/override-global-schedule-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_OverrideGlobalScheduleForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/patient-intake-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_PatientIntakeForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/register-corporate-risk-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_RegisterCorporateRiskForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/request-shift-adjustment-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_RequestShiftAdjustmentForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-care-plan-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewCarePlanForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-clinical-incident-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewClinicalIncidentForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-fleet-maintenance-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewFleetMaintenanceForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-lead-conversion-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewLeadConversionForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-legal-contract-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewLegalContractForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-market-share-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewMarketShareForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-medication-inventory-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewMedicationInventoryForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-monthly-expenses-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewMonthlyExpensesForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-onboarding-status-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewOnboardingStatusForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-peer-performance-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewPeerPerformanceForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/review-vendor-contracts-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ReviewVendorContractsForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/schedule-clinical-audit-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ScheduleClinicalAuditForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/schedule-facility-maintenance-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ScheduleFacilityMaintenanceForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/schedule-interview-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ScheduleInterviewForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/schedule-open-house-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_ScheduleOpenHouseForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/submit-adl-checklist-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_SubmitAdlChecklistForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/submit-daily-census-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_SubmitDailyCensusForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/submit-exit-interview-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_SubmitExitInterviewForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/submit-healthcare-claim-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_SubmitHealthcareClaimForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/submit-marketing-budget-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_SubmitMarketingBudgetForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
    registerRoute(
      '/workflows-and-forms/verify-certificate-form',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Workflows_VerifyCertificateForm',
      componentLabels: ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'SCREEN_ADD_FRANCHISE_LEAD_FORM': {
      'title': 'LocaleKeys.Workflows_AddFranchiseLeadForm',
      'path': '/workflows-and-forms/add-franchise-lead-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_APPROVE_EXPENSE_REIMBURSEMENT_FORM': {
      'title': 'LocaleKeys.Workflows_ApproveExpenseReimbursementForm',
      'path': '/workflows-and-forms/approve-expense-reimbursement-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_APPROVE_FRANCHISE_DISCLOSURE_FORM': {
      'title': 'LocaleKeys.Workflows_ApproveFranchiseDisclosureForm',
      'path': '/workflows-and-forms/approve-franchise-disclosure-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_APPROVE_LEAVE_REQUEST_FORM': {
      'title': 'LocaleKeys.Workflows_ApproveLeaveRequestForm',
      'path': '/workflows-and-forms/approve-leave-request-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_APPROVE_MEDICATION_REFILL_FORM': {
      'title': 'LocaleKeys.Workflows_ApproveMedicationRefillForm',
      'path': '/workflows-and-forms/approve-medication-refill-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_APPROVE_PAYROLL_RUN_FORM': {
      'title': 'LocaleKeys.Workflows_ApprovePayrollRunForm',
      'path': '/workflows-and-forms/approve-payroll-run-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_APPROVE_REAL_ESTATE_FORM': {
      'title': 'LocaleKeys.Workflows_ApproveRealEstateForm',
      'path': '/workflows-and-forms/approve-real-estate-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_APPROVE_SYSTEM_ACCESS_FORM': {
      'title': 'LocaleKeys.Workflows_ApproveSystemAccessForm',
      'path': '/workflows-and-forms/approve-system-access-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_ASSIGN_CARE_POD_FORM': {
      'title': 'LocaleKeys.Workflows_AssignCarePodForm',
      'path': '/workflows-and-forms/assign-care-pod-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_ASSIGN_LEAD_FORM': {
      'title': 'LocaleKeys.Workflows_AssignLeadForm',
      'path': '/workflows-and-forms/assign-lead-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_ASSIGN_TRAINING_MODULE_FORM': {
      'title': 'LocaleKeys.Workflows_AssignTrainingModuleForm',
      'path': '/workflows-and-forms/assign-training-module-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_AUDIT_COMPLIANCE_FORM': {
      'title': 'LocaleKeys.Workflows_AuditComplianceForm',
      'path': '/workflows-and-forms/audit-compliance-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_AUDIT_GLOBAL_EDUCATION_FORM': {
      'title': 'LocaleKeys.Workflows_AuditGlobalEducationForm',
      'path': '/workflows-and-forms/audit-global-education-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_AUDIT_OVERRIDE_FORM': {
      'title': 'LocaleKeys.Workflows_AuditOverrideForm',
      'path': '/workflows-and-forms/audit-override-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_AUDIT_PAYROLL_DISCREPANCY_FORM': {
      'title': 'LocaleKeys.Workflows_AuditPayrollDiscrepancyForm',
      'path': '/workflows-and-forms/audit-payroll-discrepancy-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_AUDIT_ROYALTY_PAYMENT_FORM': {
      'title': 'LocaleKeys.Workflows_AuditRoyaltyPaymentForm',
      'path': '/workflows-and-forms/audit-royalty-payment-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_AUDIT_SECURITY_COMPLIANCE_FORM': {
      'title': 'LocaleKeys.Workflows_AuditSecurityComplianceForm',
      'path': '/workflows-and-forms/audit-security-compliance-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_AUDIT_SYSTEM_LOGS_FORM': {
      'title': 'LocaleKeys.Workflows_AuditSystemLogsForm',
      'path': '/workflows-and-forms/audit-system-logs-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_CARE_PLAN_EVALUATION_FORM': {
      'title': 'LocaleKeys.Workflows_CarePlanEvaluationForm',
      'path': '/workflows-and-forms/care-plan-evaluation-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_CREATE_AD_PLACEMENT_FORM': {
      'title': 'LocaleKeys.Workflows_CreateAdPlacementForm',
      'path': '/workflows-and-forms/create-ad-placement-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_CREATE_CANNED_RESPONSE_FORM': {
      'title': 'LocaleKeys.Workflows_CreateCannedResponseForm',
      'path': '/workflows-and-forms/create-canned-response-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_CREATE_CUSTOM_INVOICE_FORM': {
      'title': 'LocaleKeys.Workflows_CreateCustomInvoiceForm',
      'path': '/workflows-and-forms/create-custom-invoice-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_CREATE_REVENUE_REPORT_FORM': {
      'title': 'LocaleKeys.Workflows_CreateRevenueReportForm',
      'path': '/workflows-and-forms/create-revenue-report-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_CREATE_SUPPLY_ORDER_FORM': {
      'title': 'LocaleKeys.Workflows_CreateSupplyOrderForm',
      'path': '/workflows-and-forms/create-supply-order-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_DAILY_VITALS_CARD_FORM': {
      'title': 'LocaleKeys.Workflows_DailyVitalsCardForm',
      'path': '/workflows-and-forms/daily-vitals-card-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_DISCIPLINE_LOG_FORM': {
      'title': 'LocaleKeys.Workflows_DisciplineLogForm',
      'path': '/workflows-and-forms/discipline-log-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_FRANCHISE_ONBOARDING_CHECKLIST_FORM': {
      'title': 'LocaleKeys.Workflows_FranchiseOnboardingChecklistForm',
      'path': '/workflows-and-forms/franchise-onboarding-checklist-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_LEAVE_REQUEST_FORM': {
      'title': 'LocaleKeys.Workflows_LeaveRequestForm',
      'path': '/workflows-and-forms/leave-request-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_LOG_CLINICAL_INCIDENT_FORM': {
      'title': 'LocaleKeys.Workflows_LogClinicalIncidentForm',
      'path': '/workflows-and-forms/log-clinical-incident-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_LOG_EMPLOYEE_GRIEVANCE_FORM': {
      'title': 'LocaleKeys.Workflows_LogEmployeeGrievanceForm',
      'path': '/workflows-and-forms/log-employee-grievance-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_LOG_FRANCHISEE_VETTING_CALL_FORM': {
      'title': 'LocaleKeys.Workflows_LogFranchiseeVettingCallForm',
      'path': '/workflows-and-forms/log-franchisee-vetting-call-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_LOG_INFECTION_CONTROL_FORM': {
      'title': 'LocaleKeys.Workflows_LogInfectionControlForm',
      'path': '/workflows-and-forms/log-infection-control-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_LOG_INVENTORY_SPOILAGE_FORM': {
      'title': 'LocaleKeys.Workflows_LogInventorySpoilageForm',
      'path': '/workflows-and-forms/log-inventory-spoilage-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_LOG_PETTY_CASH_FORM': {
      'title': 'LocaleKeys.Workflows_LogPettyCashForm',
      'path': '/workflows-and-forms/log-petty-cash-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_NEW_EMPLOYEE_ONBOARDING_FORM': {
      'title': 'LocaleKeys.Workflows_NewEmployeeOnboardingForm',
      'path': '/workflows-and-forms/new-employee-onboarding-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_NURTURE_LOCALIZED_LEAD_FORM': {
      'title': 'LocaleKeys.Workflows_NurtureLocalizedLeadForm',
      'path': '/workflows-and-forms/nurture-localized-lead-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_OVERRIDE_GLOBAL_SCHEDULE_FORM': {
      'title': 'LocaleKeys.Workflows_OverrideGlobalScheduleForm',
      'path': '/workflows-and-forms/override-global-schedule-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_PATIENT_INTAKE_FORM': {
      'title': 'LocaleKeys.Workflows_PatientIntakeForm',
      'path': '/workflows-and-forms/patient-intake-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REGISTER_CORPORATE_RISK_FORM': {
      'title': 'LocaleKeys.Workflows_RegisterCorporateRiskForm',
      'path': '/workflows-and-forms/register-corporate-risk-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REQUEST_SHIFT_ADJUSTMENT_FORM': {
      'title': 'LocaleKeys.Workflows_RequestShiftAdjustmentForm',
      'path': '/workflows-and-forms/request-shift-adjustment-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_CARE_PLAN_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewCarePlanForm',
      'path': '/workflows-and-forms/review-care-plan-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_CLINICAL_INCIDENT_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewClinicalIncidentForm',
      'path': '/workflows-and-forms/review-clinical-incident-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_FLEET_MAINTENANCE_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewFleetMaintenanceForm',
      'path': '/workflows-and-forms/review-fleet-maintenance-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_LEAD_CONVERSION_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewLeadConversionForm',
      'path': '/workflows-and-forms/review-lead-conversion-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_LEGAL_CONTRACT_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewLegalContractForm',
      'path': '/workflows-and-forms/review-legal-contract-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_MARKET_SHARE_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewMarketShareForm',
      'path': '/workflows-and-forms/review-market-share-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_MEDICATION_INVENTORY_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewMedicationInventoryForm',
      'path': '/workflows-and-forms/review-medication-inventory-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_MONTHLY_EXPENSES_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewMonthlyExpensesForm',
      'path': '/workflows-and-forms/review-monthly-expenses-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_ONBOARDING_STATUS_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewOnboardingStatusForm',
      'path': '/workflows-and-forms/review-onboarding-status-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_PEER_PERFORMANCE_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewPeerPerformanceForm',
      'path': '/workflows-and-forms/review-peer-performance-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_REVIEW_VENDOR_CONTRACTS_FORM': {
      'title': 'LocaleKeys.Workflows_ReviewVendorContractsForm',
      'path': '/workflows-and-forms/review-vendor-contracts-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SCHEDULE_CLINICAL_AUDIT_FORM': {
      'title': 'LocaleKeys.Workflows_ScheduleClinicalAuditForm',
      'path': '/workflows-and-forms/schedule-clinical-audit-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SCHEDULE_FACILITY_MAINTENANCE_FORM': {
      'title': 'LocaleKeys.Workflows_ScheduleFacilityMaintenanceForm',
      'path': '/workflows-and-forms/schedule-facility-maintenance-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SCHEDULE_INTERVIEW_FORM': {
      'title': 'LocaleKeys.Workflows_ScheduleInterviewForm',
      'path': '/workflows-and-forms/schedule-interview-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SCHEDULE_OPEN_HOUSE_FORM': {
      'title': 'LocaleKeys.Workflows_ScheduleOpenHouseForm',
      'path': '/workflows-and-forms/schedule-open-house-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SUBMIT_ADL_CHECKLIST_FORM': {
      'title': 'LocaleKeys.Workflows_SubmitAdlChecklistForm',
      'path': '/workflows-and-forms/submit-adl-checklist-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SUBMIT_DAILY_CENSUS_FORM': {
      'title': 'LocaleKeys.Workflows_SubmitDailyCensusForm',
      'path': '/workflows-and-forms/submit-daily-census-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SUBMIT_EXIT_INTERVIEW_FORM': {
      'title': 'LocaleKeys.Workflows_SubmitExitInterviewForm',
      'path': '/workflows-and-forms/submit-exit-interview-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SUBMIT_HEALTHCARE_CLAIM_FORM': {
      'title': 'LocaleKeys.Workflows_SubmitHealthcareClaimForm',
      'path': '/workflows-and-forms/submit-healthcare-claim-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_SUBMIT_MARKETING_BUDGET_FORM': {
      'title': 'LocaleKeys.Workflows_SubmitMarketingBudgetForm',
      'path': '/workflows-and-forms/submit-marketing-budget-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
    'SCREEN_VERIFY_CERTIFICATE_FORM': {
      'title': 'LocaleKeys.Workflows_VerifyCertificateForm',
      'path': '/workflows-and-forms/verify-certificate-form',
      'componentLabels': ['Aura HUD', 'Dynamic Form Engine', 'Execution Gate Guard'],
    },
  };
}
