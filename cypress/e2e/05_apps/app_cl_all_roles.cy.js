// AUTO-GENERATED APP E2E SPEC. SYSTEMATICALLY GENERATED.
// Tests all allowed roles and their respective screens on the portal.
// Leverages reusable SSO commands and custom Semantics selector lookups.

describe("App All Roles All Screens - Primecare Client", () => {

  it("verifies operation flow for role: CHIROPRACTOR", () => {
    cy.loginAsRole("chiropractor");

    // [1/4] - Screen: AdjustmentNotesScreen (adjustment_notes)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/adjustment-notes (AdjustmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/adjustment-notes");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("adjustmentnotes-screen").should("be.visible");
    cy.getCy("adjustmentnotes-title").should("be.visible");
    cy.getCy("adjustmentnotes-content").should("be.visible");
    cy.screenshot("cl_chiropractor_adjustment_notes");

    // [2/4] - Screen: ChiropracticAssessmentScreen (chiropractic_assessment)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/chiropractic-assessment (ChiropracticAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-assessment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropracticassessment-screen").should("be.visible");
    cy.getCy("chiropracticassessment-title").should("be.visible");
    cy.getCy("chiropracticassessment-content").should("be.visible");
    cy.screenshot("cl_chiropractor_chiropractic_assessment");

    // [3/4] - Screen: ChiropracticProgressTrackingScreen (chiropractic_progress_tracking)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/chiropractic-progress-tracking (ChiropracticProgressTrackingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-progress-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
    cy.getCy("chiropracticprogresstracking-title").should("be.visible");
    cy.getCy("chiropracticprogresstracking-content").should("be.visible");
    cy.screenshot("cl_chiropractor_chiropractic_progress_tracking");

    // [4/4] - Screen: XrayReviewScreen (xray_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/xray-review (XrayReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/xray-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("xrayreview-screen").should("be.visible");
    cy.getCy("xrayreview-title").should("be.visible");
    cy.getCy("xrayreview-content").should("be.visible");
    cy.screenshot("cl_chiropractor_xray_review");
  });

  it("verifies operation flow for role: HR_HIRING", () => {
    cy.loginAsRole("hr_hiring");

    // [1/10] - Screen: ApplicantTrackingScreen (applicant_tracking)
    cy.task("log", "PROGRESS: Visiting /staff/applicant-tracking (ApplicantTrackingScreen)...");
    cy.visitWithSemantics("/staff/applicant-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("applicanttracking-screen").should("be.visible");
    cy.getCy("applicanttracking-title").should("be.visible");
    cy.getCy("applicanttracking-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_applicant_tracking");

    // [2/10] - Screen: HrHiringApplicantsScreen (hr_hiring_applicants)
    cy.task("log", "PROGRESS: Visiting /staff/hr-hiring-applicants (HrHiringApplicantsScreen)...");
    cy.visitWithSemantics("/staff/hr-hiring-applicants");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrhiringapplicants-screen").should("be.visible");
    cy.getCy("hrhiringapplicants-title").should("be.visible");
    cy.getCy("hrhiringapplicants-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_hr_hiring_applicants");

    // [3/10] - Screen: HrHiringCredentialsScreen (hr_hiring_credentials)
    cy.task("log", "PROGRESS: Visiting /staff/hr-hiring-credentials (HrHiringCredentialsScreen)...");
    cy.visitWithSemantics("/staff/hr-hiring-credentials");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrhiringcredentials-screen").should("be.visible");
    cy.getCy("hrhiringcredentials-title").should("be.visible");
    cy.getCy("hrhiringcredentials-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_hr_hiring_credentials");

    // [4/10] - Screen: HrHiringDashboardScreen (hr_hiring_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/hr-hiring-dashboard (HrHiringDashboardScreen)...");
    cy.visitWithSemantics("/staff/hr-hiring-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrhiringdashboard-screen").should("be.visible");
    cy.getCy("hrhiringdashboard-title").should("be.visible");
    cy.getCy("hrhiringdashboard-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_hr_hiring_dashboard");

    // [5/10] - Screen: HrHiringInterviewsScreen (hr_hiring_interviews)
    cy.task("log", "PROGRESS: Visiting /staff/hr-hiring-interviews (HrHiringInterviewsScreen)...");
    cy.visitWithSemantics("/staff/hr-hiring-interviews");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrhiringinterviews-screen").should("be.visible");
    cy.getCy("hrhiringinterviews-title").should("be.visible");
    cy.getCy("hrhiringinterviews-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_hr_hiring_interviews");

    // [6/10] - Screen: HrHiringOffersScreen (hr_hiring_offers)
    cy.task("log", "PROGRESS: Visiting /staff/hr-hiring-offers (HrHiringOffersScreen)...");
    cy.visitWithSemantics("/staff/hr-hiring-offers");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrhiringoffers-screen").should("be.visible");
    cy.getCy("hrhiringoffers-title").should("be.visible");
    cy.getCy("hrhiringoffers-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_hr_hiring_offers");

    // [7/10] - Screen: HrHiringOnboardingScreen (hr_hiring_onboarding)
    cy.task("log", "PROGRESS: Visiting /staff/hr-hiring-onboarding (HrHiringOnboardingScreen)...");
    cy.visitWithSemantics("/staff/hr-hiring-onboarding");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrhiringonboarding-screen").should("be.visible");
    cy.getCy("hrhiringonboarding-title").should("be.visible");
    cy.getCy("hrhiringonboarding-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_hr_hiring_onboarding");

    // [8/10] - Screen: InterviewSchedulingScreen (interview_scheduling)
    cy.task("log", "PROGRESS: Visiting /staff/interview-scheduling (InterviewSchedulingScreen)...");
    cy.visitWithSemantics("/staff/interview-scheduling");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("interviewscheduling-screen").should("be.visible");
    cy.getCy("interviewscheduling-title").should("be.visible");
    cy.getCy("interviewscheduling-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_interview_scheduling");

    // [9/10] - Screen: OfferManagementScreen (offer_management)
    cy.task("log", "PROGRESS: Visiting /staff/offer-management (OfferManagementScreen)...");
    cy.visitWithSemantics("/staff/offer-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("offermanagement-screen").should("be.visible");
    cy.getCy("offermanagement-title").should("be.visible");
    cy.getCy("offermanagement-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_offer_management");

    // [10/10] - Screen: OnboardingChecklistScreen (onboarding_checklist)
    cy.task("log", "PROGRESS: Visiting /staff/onboarding-checklist (OnboardingChecklistScreen)...");
    cy.visitWithSemantics("/staff/onboarding-checklist");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("onboardingchecklist-screen").should("be.visible");
    cy.getCy("onboardingchecklist-title").should("be.visible");
    cy.getCy("onboardingchecklist-content").should("be.visible");
    cy.screenshot("cl_hr_hiring_onboarding_checklist");
  });

  it("verifies operation flow for role: PATIENT", () => {
    cy.loginAsRole("patient");

    // [1/13] - Screen: AppointmentScreen (appointment)
    cy.task("log", "PROGRESS: Visiting /common/appointment (AppointmentScreen)...");
    cy.visitWithSemantics("/common/appointment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("appointment-screen").should("be.visible");
    cy.getCy("appointment-title").should("be.visible");
    cy.getCy("appointment-content").should("be.visible");
    cy.screenshot("cl_patient_appointment");

    // [2/13] - Screen: BillingScreen (billing)
    cy.task("log", "PROGRESS: Visiting /common/billing (BillingScreen)...");
    cy.visitWithSemantics("/common/billing");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("billing-screen").should("be.visible");
    cy.getCy("billing-title").should("be.visible");
    cy.getCy("billing-content").should("be.visible");
    cy.screenshot("cl_patient_billing");

    // [3/13] - Screen: CarePlanScreen (care_plan)
    cy.task("log", "PROGRESS: Visiting /common/care-plan (CarePlanScreen)...");
    cy.visitWithSemantics("/common/care-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("careplan-screen").should("be.visible");
    cy.getCy("careplan-title").should("be.visible");
    cy.getCy("careplan-content").should("be.visible");
    cy.screenshot("cl_patient_care_plan");

    // [4/13] - Screen: DocumentsScreen (documents)
    cy.task("log", "PROGRESS: Visiting /common/documents (DocumentsScreen)...");
    cy.visitWithSemantics("/common/documents");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("documents-screen").should("be.visible");
    cy.getCy("documents-title").should("be.visible");
    cy.getCy("documents-content").should("be.visible");
    cy.screenshot("cl_patient_documents");

    // [5/13] - Screen: FamilyMemberDashboardScreen (family_member_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/family-member-dashboard (FamilyMemberDashboardScreen)...");
    cy.visitWithSemantics("/common/family-member-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("familymemberdashboard-screen").should("be.visible");
    cy.getCy("familymemberdashboard-title").should("be.visible");
    cy.getCy("familymemberdashboard-content").should("be.visible");
    cy.screenshot("cl_patient_family_member_dashboard");

    // [6/13] - Screen: PatientAppointmentsScreen (patient_appointments)
    cy.task("log", "PROGRESS: Visiting /common/patient-appointments (PatientAppointmentsScreen)...");
    cy.visitWithSemantics("/common/patient-appointments");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientappointments-screen").should("be.visible");
    cy.getCy("patientappointments-title").should("be.visible");
    cy.getCy("patientappointments-content").should("be.visible");
    cy.screenshot("cl_patient_patient_appointments");

    // [7/13] - Screen: PatientBillingScreen (patient_billing)
    cy.task("log", "PROGRESS: Visiting /common/patient-billing (PatientBillingScreen)...");
    cy.visitWithSemantics("/common/patient-billing");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientbilling-screen").should("be.visible");
    cy.getCy("patientbilling-title").should("be.visible");
    cy.getCy("patientbilling-content").should("be.visible");
    cy.screenshot("cl_patient_patient_billing");

    // [8/13] - Screen: PatientCarePlanScreen (patient_care_plan)
    cy.task("log", "PROGRESS: Visiting /common/patient-care-plan (PatientCarePlanScreen)...");
    cy.visitWithSemantics("/common/patient-care-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientcareplan-screen").should("be.visible");
    cy.getCy("patientcareplan-title").should("be.visible");
    cy.getCy("patientcareplan-content").should("be.visible");
    cy.screenshot("cl_patient_patient_care_plan");

    // [9/13] - Screen: PatientCommandCenterScreen (patient_command_center)
    cy.task("log", "PROGRESS: Visiting /common/patient-command-center (PatientCommandCenterScreen)...");
    cy.visitWithSemantics("/common/patient-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientcommandcenter-screen").should("be.visible");
    cy.getCy("patientcommandcenter-title").should("be.visible");
    cy.getCy("patientcommandcenter-content").should("be.visible");
    cy.screenshot("cl_patient_patient_command_center");

    // [10/13] - Screen: PatientDashboardScreen (patient_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/patient-dashboard (PatientDashboardScreen)...");
    cy.visitWithSemantics("/common/patient-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientdashboard-screen").should("be.visible");
    cy.getCy("patientdashboard-title").should("be.visible");
    cy.getCy("patientdashboard-content").should("be.visible");
    cy.screenshot("cl_patient_patient_dashboard");

    // [11/13] - Screen: PatientDocumentsScreen (patient_documents)
    cy.task("log", "PROGRESS: Visiting /common/patient-documents (PatientDocumentsScreen)...");
    cy.visitWithSemantics("/common/patient-documents");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientdocuments-screen").should("be.visible");
    cy.getCy("patientdocuments-title").should("be.visible");
    cy.getCy("patientdocuments-content").should("be.visible");
    cy.screenshot("cl_patient_patient_documents");

    // [12/13] - Screen: PatientMessagesScreen (patient_messages)
    cy.task("log", "PROGRESS: Visiting /common/patient-messages (PatientMessagesScreen)...");
    cy.visitWithSemantics("/common/patient-messages");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientmessages-screen").should("be.visible");
    cy.getCy("patientmessages-title").should("be.visible");
    cy.getCy("patientmessages-content").should("be.visible");
    cy.screenshot("cl_patient_patient_messages");

    // [13/13] - Screen: PatientProfileScreen (patient_profile)
    cy.task("log", "PROGRESS: Visiting /common/patient-profile (PatientProfileScreen)...");
    cy.visitWithSemantics("/common/patient-profile");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientprofile-screen").should("be.visible");
    cy.getCy("patientprofile-title").should("be.visible");
    cy.getCy("patientprofile-content").should("be.visible");
    cy.screenshot("cl_patient_patient_profile");
  });

  it("verifies operation flow for role: OPS_MANAGER", () => {
    cy.loginAsRole("ops_manager");

    // [1/5] - Screen: AttendanceScreen (attendance)
    cy.task("log", "PROGRESS: Visiting /management/attendance (AttendanceScreen)...");
    cy.visitWithSemantics("/management/attendance");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("attendance-screen").should("be.visible");
    cy.getCy("attendance-title").should("be.visible");
    cy.getCy("attendance-content").should("be.visible");
    cy.screenshot("cl_ops_manager_attendance");

    // [2/5] - Screen: DailyOperationsScreen (daily_operations)
    cy.task("log", "PROGRESS: Visiting /management/daily-operations (DailyOperationsScreen)...");
    cy.visitWithSemantics("/management/daily-operations");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("dailyoperations-screen").should("be.visible");
    cy.getCy("dailyoperations-title").should("be.visible");
    cy.getCy("dailyoperations-content").should("be.visible");
    cy.screenshot("cl_ops_manager_daily_operations");

    // [3/5] - Screen: OperationsManagerDashboardScreen (operations_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/operations-manager-dashboard (OperationsManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/operations-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
    cy.getCy("operationsmanagerdashboard-title").should("be.visible");
    cy.getCy("operationsmanagerdashboard-content").should("be.visible");
    cy.screenshot("cl_ops_manager_operations_manager_dashboard");

    // [4/5] - Screen: SchedulingHealthScreen (scheduling_health)
    cy.task("log", "PROGRESS: Visiting /management/scheduling-health (SchedulingHealthScreen)...");
    cy.visitWithSemantics("/management/scheduling-health");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulinghealth-screen").should("be.visible");
    cy.getCy("schedulinghealth-title").should("be.visible");
    cy.getCy("schedulinghealth-content").should("be.visible");
    cy.screenshot("cl_ops_manager_scheduling_health");

    // [5/5] - Screen: ServiceIssueScreen (service_issue)
    cy.task("log", "PROGRESS: Visiting /management/service-issue (ServiceIssueScreen)...");
    cy.visitWithSemantics("/management/service-issue");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("serviceissue-screen").should("be.visible");
    cy.getCy("serviceissue-title").should("be.visible");
    cy.getCy("serviceissue-content").should("be.visible");
    cy.screenshot("cl_ops_manager_service_issue");
  });

  it("verifies operation flow for role: COMPLIANCE", () => {
    cy.loginAsRole("compliance");

    // [1/5] - Screen: AuditReviewScreen (audit_review)
    cy.task("log", "PROGRESS: Visiting /management/audit-review (AuditReviewScreen)...");
    cy.visitWithSemantics("/management/audit-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("auditreview-screen").should("be.visible");
    cy.getCy("auditreview-title").should("be.visible");
    cy.getCy("auditreview-content").should("be.visible");
    cy.screenshot("cl_compliance_audit_review");

    // [2/5] - Screen: ComplianceDashboardScreen (compliance_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/compliance-dashboard (ComplianceDashboardScreen)...");
    cy.visitWithSemantics("/management/compliance-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("compliancedashboard-screen").should("be.visible");
    cy.getCy("compliancedashboard-title").should("be.visible");
    cy.getCy("compliancedashboard-content").should("be.visible");
    cy.screenshot("cl_compliance_compliance_dashboard");

    // [3/5] - Screen: CorrectiveActionScreen (corrective_action)
    cy.task("log", "PROGRESS: Visiting /management/corrective-action (CorrectiveActionScreen)...");
    cy.visitWithSemantics("/management/corrective-action");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("correctiveaction-screen").should("be.visible");
    cy.getCy("correctiveaction-title").should("be.visible");
    cy.getCy("correctiveaction-content").should("be.visible");
    cy.screenshot("cl_compliance_corrective_action");

    // [4/5] - Screen: IncidentManagementScreen (incident_management)
    cy.task("log", "PROGRESS: Visiting /management/incident-management (IncidentManagementScreen)...");
    cy.visitWithSemantics("/management/incident-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("incidentmanagement-screen").should("be.visible");
    cy.getCy("incidentmanagement-title").should("be.visible");
    cy.getCy("incidentmanagement-content").should("be.visible");
    cy.screenshot("cl_compliance_incident_management");

    // [5/5] - Screen: PolicyManagementScreen (policy_management)
    cy.task("log", "PROGRESS: Visiting /management/policy-management (PolicyManagementScreen)...");
    cy.visitWithSemantics("/management/policy-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("policymanagement-screen").should("be.visible");
    cy.getCy("policymanagement-title").should("be.visible");
    cy.getCy("policymanagement-content").should("be.visible");
    cy.screenshot("cl_compliance_policy_management");
  });

  it("verifies operation flow for role: ADMIN", () => {
    cy.loginAsRole("admin");

    // [1/7] - Screen: BillingAdminDashboardScreen (billing_admin_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/billing-admin-dashboard (BillingAdminDashboardScreen)...");
    cy.visitWithSemantics("/staff/billing-admin-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("billingadmindashboard-screen").should("be.visible");
    cy.getCy("billingadmindashboard-title").should("be.visible");
    cy.getCy("billingadmindashboard-content").should("be.visible");
    cy.screenshot("cl_admin_billing_admin_dashboard");

    // [2/7] - Screen: ClaimsProcessingScreen (claims_processing)
    cy.task("log", "PROGRESS: Visiting /staff/claims-processing (ClaimsProcessingScreen)...");
    cy.visitWithSemantics("/staff/claims-processing");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("claimsprocessing-screen").should("be.visible");
    cy.getCy("claimsprocessing-title").should("be.visible");
    cy.getCy("claimsprocessing-content").should("be.visible");
    cy.screenshot("cl_admin_claims_processing");

    // [3/7] - Screen: InvoiceManagementScreen (invoice_management)
    cy.task("log", "PROGRESS: Visiting /staff/invoice-management (InvoiceManagementScreen)...");
    cy.visitWithSemantics("/staff/invoice-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("invoicemanagement-screen").should("be.visible");
    cy.getCy("invoicemanagement-title").should("be.visible");
    cy.getCy("invoicemanagement-content").should("be.visible");
    cy.screenshot("cl_admin_invoice_management");

    // [4/7] - Screen: OfficeDashboardScreen (office_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/office-dashboard (OfficeDashboardScreen)...");
    cy.visitWithSemantics("/common/office-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("officedashboard-screen").should("be.visible");
    cy.getCy("officedashboard-title").should("be.visible");
    cy.getCy("officedashboard-content").should("be.visible");
    cy.screenshot("cl_admin_office_dashboard");

    // [5/7] - Screen: PaymentTrackingScreen (payment_tracking)
    cy.task("log", "PROGRESS: Visiting /staff/payment-tracking (PaymentTrackingScreen)...");
    cy.visitWithSemantics("/staff/payment-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("paymenttracking-screen").should("be.visible");
    cy.getCy("paymenttracking-title").should("be.visible");
    cy.getCy("paymenttracking-content").should("be.visible");
    cy.screenshot("cl_admin_payment_tracking");

    // [6/7] - Screen: ReceptionistDashboardScreen (receptionist_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/receptionist-dashboard (ReceptionistDashboardScreen)...");
    cy.visitWithSemantics("/staff/receptionist-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("receptionistdashboard-screen").should("be.visible");
    cy.getCy("receptionistdashboard-title").should("be.visible");
    cy.getCy("receptionistdashboard-content").should("be.visible");
    cy.screenshot("cl_admin_receptionist_dashboard");

    // [7/7] - Screen: RefundManagementScreen (refund_management)
    cy.task("log", "PROGRESS: Visiting /staff/refund-management (RefundManagementScreen)...");
    cy.visitWithSemantics("/staff/refund-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("refundmanagement-screen").should("be.visible");
    cy.getCy("refundmanagement-title").should("be.visible");
    cy.getCy("refundmanagement-content").should("be.visible");
    cy.screenshot("cl_admin_refund_management");
  });

  it("verifies operation flow for role: FAMILY", () => {
    cy.loginAsRole("family");

    // [1/4] - Screen: BillingOverviewScreen (billing_overview)
    cy.task("log", "PROGRESS: Visiting /common/billing-overview (BillingOverviewScreen)...");
    cy.visitWithSemantics("/common/billing-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("billingoverview-screen").should("be.visible");
    cy.getCy("billingoverview-title").should("be.visible");
    cy.getCy("billingoverview-content").should("be.visible");
    cy.screenshot("cl_family_billing_overview");

    // [2/4] - Screen: CareUpdatesScreen (care_updates)
    cy.task("log", "PROGRESS: Visiting /common/care-updates (CareUpdatesScreen)...");
    cy.visitWithSemantics("/common/care-updates");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("careupdates-screen").should("be.visible");
    cy.getCy("careupdates-title").should("be.visible");
    cy.getCy("careupdates-content").should("be.visible");
    cy.screenshot("cl_family_care_updates");

    // [3/4] - Screen: EmergencyContactsScreen (emergency_contacts)
    cy.task("log", "PROGRESS: Visiting /common/emergency-contacts (EmergencyContactsScreen)...");
    cy.visitWithSemantics("/common/emergency-contacts");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("emergencycontacts-screen").should("be.visible");
    cy.getCy("emergencycontacts-title").should("be.visible");
    cy.getCy("emergencycontacts-content").should("be.visible");
    cy.screenshot("cl_family_emergency_contacts");

    // [4/4] - Screen: FamilyOverviewScreen (family_overview)
    cy.task("log", "PROGRESS: Visiting /common/family-overview (FamilyOverviewScreen)...");
    cy.visitWithSemantics("/common/family-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("familyoverview-screen").should("be.visible");
    cy.getCy("familyoverview-title").should("be.visible");
    cy.getCy("familyoverview-content").should("be.visible");
    cy.screenshot("cl_family_family_overview");
  });

  it("verifies operation flow for role: SCHEDULER", () => {
    cy.loginAsRole("scheduler");

    // [1/12] - Screen: CalendarManagementScreen (calendar_management)
    cy.task("log", "PROGRESS: Visiting /staff/calendar-management (CalendarManagementScreen)...");
    cy.visitWithSemantics("/staff/calendar-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("calendarmanagement-screen").should("be.visible");
    cy.getCy("calendarmanagement-title").should("be.visible");
    cy.getCy("calendarmanagement-content").should("be.visible");
    cy.screenshot("cl_scheduler_calendar_management");

    // [2/12] - Screen: ConflictResolutionScreen (conflict_resolution)
    cy.task("log", "PROGRESS: Visiting /staff/conflict-resolution (ConflictResolutionScreen)...");
    cy.visitWithSemantics("/staff/conflict-resolution");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("conflictresolution-screen").should("be.visible");
    cy.getCy("conflictresolution-title").should("be.visible");
    cy.getCy("conflictresolution-content").should("be.visible");
    cy.screenshot("cl_scheduler_conflict_resolution");

    // [3/12] - Screen: OpenShiftScreen (open_shift)
    cy.task("log", "PROGRESS: Visiting /staff/open-shift (OpenShiftScreen)...");
    cy.visitWithSemantics("/staff/open-shift");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("openshift-screen").should("be.visible");
    cy.getCy("openshift-title").should("be.visible");
    cy.getCy("openshift-content").should("be.visible");
    cy.screenshot("cl_scheduler_open_shift");

    // [4/12] - Screen: SchedulerBookingRequestsScreen (scheduler_booking_requests)
    cy.task("log", "PROGRESS: Visiting /staff/scheduler-booking-requests (SchedulerBookingRequestsScreen)...");
    cy.visitWithSemantics("/staff/scheduler-booking-requests");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulerbookingrequests-screen").should("be.visible");
    cy.getCy("schedulerbookingrequests-title").should("be.visible");
    cy.getCy("schedulerbookingrequests-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduler_booking_requests");

    // [5/12] - Screen: SchedulerCalendarScreen (scheduler_calendar)
    cy.task("log", "PROGRESS: Visiting /staff/scheduler-calendar (SchedulerCalendarScreen)...");
    cy.visitWithSemantics("/staff/scheduler-calendar");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulercalendar-screen").should("be.visible");
    cy.getCy("schedulercalendar-title").should("be.visible");
    cy.getCy("schedulercalendar-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduler_calendar");

    // [6/12] - Screen: SchedulerCommandCenterScreen (scheduler_command_center)
    cy.task("log", "PROGRESS: Visiting /staff/scheduler-command-center (SchedulerCommandCenterScreen)...");
    cy.visitWithSemantics("/staff/scheduler-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulercommandcenter-screen").should("be.visible");
    cy.getCy("schedulercommandcenter-title").should("be.visible");
    cy.getCy("schedulercommandcenter-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduler_command_center");

    // [7/12] - Screen: SchedulerConflictsScreen (scheduler_conflicts)
    cy.task("log", "PROGRESS: Visiting /staff/scheduler-conflicts (SchedulerConflictsScreen)...");
    cy.visitWithSemantics("/staff/scheduler-conflicts");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulerconflicts-screen").should("be.visible");
    cy.getCy("schedulerconflicts-title").should("be.visible");
    cy.getCy("schedulerconflicts-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduler_conflicts");

    // [8/12] - Screen: SchedulerDashboardScreen (scheduler_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/scheduler-dashboard (SchedulerDashboardScreen)...");
    cy.visitWithSemantics("/staff/scheduler-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulerdashboard-screen").should("be.visible");
    cy.getCy("schedulerdashboard-title").should("be.visible");
    cy.getCy("schedulerdashboard-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduler_dashboard");

    // [9/12] - Screen: SchedulerOpenShiftsScreen (scheduler_open_shifts)
    cy.task("log", "PROGRESS: Visiting /staff/scheduler-open-shifts (SchedulerOpenShiftsScreen)...");
    cy.visitWithSemantics("/staff/scheduler-open-shifts");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("scheduleropenshifts-screen").should("be.visible");
    cy.getCy("scheduleropenshifts-title").should("be.visible");
    cy.getCy("scheduleropenshifts-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduler_open_shifts");

    // [10/12] - Screen: SchedulerProviderAvailabilityScreen (scheduler_provider_availability)
    cy.task("log", "PROGRESS: Visiting /staff/scheduler-provider-availability (SchedulerProviderAvailabilityScreen)...");
    cy.visitWithSemantics("/staff/scheduler-provider-availability");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulerprovideravailability-screen").should("be.visible");
    cy.getCy("schedulerprovideravailability-title").should("be.visible");
    cy.getCy("schedulerprovideravailability-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduler_provider_availability");

    // [11/12] - Screen: SchedulingDashboardScreen (scheduling_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/scheduling-dashboard (SchedulingDashboardScreen)...");
    cy.visitWithSemantics("/staff/scheduling-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulingdashboard-screen").should("be.visible");
    cy.getCy("schedulingdashboard-title").should("be.visible");
    cy.getCy("schedulingdashboard-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduling_dashboard");

    // [12/12] - Screen: SchedulingOperations4KScreen (scheduling_operations4_k)
    cy.task("log", "PROGRESS: Visiting /staff/scheduling-operations4-k (SchedulingOperations4KScreen)...");
    cy.visitWithSemantics("/staff/scheduling-operations4-k");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedulingoperations4k-screen").should("be.visible");
    cy.getCy("schedulingoperations4k-title").should("be.visible");
    cy.getCy("schedulingoperations4k-content").should("be.visible");
    cy.screenshot("cl_scheduler_scheduling_operations4_k");
  });

  it("verifies operation flow for role: CAREGIVER", () => {
    cy.loginAsRole("caregiver");

    // [1/8] - Screen: CaregiverClientProfileScreen (caregiver_client_profile)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/client-profile (CaregiverClientProfileScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/client-profile");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("caregiverclientprofile-screen").should("be.visible");
    cy.getCy("caregiverclientprofile-title").should("be.visible");
    cy.getCy("caregiverclientprofile-content").should("be.visible");
    cy.screenshot("cl_caregiver_caregiver_client_profile");

    // [2/8] - Screen: CaregiverDashboardScreen (caregiver_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/dashboard (CaregiverDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("caregiverdashboard-screen").should("be.visible");
    cy.getCy("caregiverdashboard-title").should("be.visible");
    cy.getCy("caregiverdashboard-content").should("be.visible");
    cy.screenshot("cl_caregiver_caregiver_dashboard");

    // [3/8] - Screen: CaregiverIncidentReportScreen (caregiver_incident_report)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/incident-report (CaregiverIncidentReportScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/incident-report");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("caregiverincidentreport-screen").should("be.visible");
    cy.getCy("caregiverincidentreport-title").should("be.visible");
    cy.getCy("caregiverincidentreport-content").should("be.visible");
    cy.screenshot("cl_caregiver_caregiver_incident_report");

    // [4/8] - Screen: CaregiverScheduleScreen (caregiver_schedule)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/schedule (CaregiverScheduleScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/schedule");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("caregiverschedule-screen").should("be.visible");
    cy.getCy("caregiverschedule-title").should("be.visible");
    cy.getCy("caregiverschedule-content").should("be.visible");
    cy.screenshot("cl_caregiver_caregiver_schedule");

    // [5/8] - Screen: CaregiverTasksScreen (caregiver_tasks)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/tasks (CaregiverTasksScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/tasks");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("caregivertasks-screen").should("be.visible");
    cy.getCy("caregivertasks-title").should("be.visible");
    cy.getCy("caregivertasks-content").should("be.visible");
    cy.screenshot("cl_caregiver_caregiver_tasks");

    // [6/8] - Screen: CaregiverVisitNotesScreen (caregiver_visit_notes)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/visit-notes (CaregiverVisitNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/visit-notes");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("caregivervisitnotes-screen").should("be.visible");
    cy.getCy("caregivervisitnotes-title").should("be.visible");
    cy.getCy("caregivervisitnotes-content").should("be.visible");
    cy.screenshot("cl_caregiver_caregiver_visit_notes");

    // [7/8] - Screen: MessagingScreen (messaging)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/messaging (MessagingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/messaging");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("messaging-screen").should("be.visible");
    cy.getCy("messaging-title").should("be.visible");
    cy.getCy("messaging-content").should("be.visible");
    cy.screenshot("cl_caregiver_messaging");

    // [8/8] - Screen: ScheduleScreen (schedule)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/caregiver/psw-schedule (ScheduleScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/caregiver/psw-schedule");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("schedule-screen").should("be.visible");
    cy.getCy("schedule-title").should("be.visible");
    cy.getCy("schedule-content").should("be.visible");
    cy.screenshot("cl_caregiver_schedule");
  });

  it("verifies operation flow for role: TRAINING_COORDINATOR", () => {
    cy.loginAsRole("training_coordinator");

    // [1/4] - Screen: CertificationTrackingScreen (certification_tracking)
    cy.task("log", "PROGRESS: Visiting /staff/certification-tracking (CertificationTrackingScreen)...");
    cy.visitWithSemantics("/staff/certification-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("certificationtracking-screen").should("be.visible");
    cy.getCy("certificationtracking-title").should("be.visible");
    cy.getCy("certificationtracking-content").should("be.visible");
    cy.screenshot("cl_training_coordinator_certification_tracking");

    // [2/4] - Screen: CourseAssignmentScreen (course_assignment)
    cy.task("log", "PROGRESS: Visiting /staff/course-assignment (CourseAssignmentScreen)...");
    cy.visitWithSemantics("/staff/course-assignment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("courseassignment-screen").should("be.visible");
    cy.getCy("courseassignment-title").should("be.visible");
    cy.getCy("courseassignment-content").should("be.visible");
    cy.screenshot("cl_training_coordinator_course_assignment");

    // [3/4] - Screen: StaffProgressScreen (staff_progress)
    cy.task("log", "PROGRESS: Visiting /staff/staff-progress (StaffProgressScreen)...");
    cy.visitWithSemantics("/staff/staff-progress");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("staffprogress-screen").should("be.visible");
    cy.getCy("staffprogress-title").should("be.visible");
    cy.getCy("staffprogress-content").should("be.visible");
    cy.screenshot("cl_training_coordinator_staff_progress");

    // [4/4] - Screen: TrainingDashboardScreen (training_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/training-dashboard (TrainingDashboardScreen)...");
    cy.visitWithSemantics("/staff/training-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("trainingdashboard-screen").should("be.visible");
    cy.getCy("trainingdashboard-title").should("be.visible");
    cy.getCy("trainingdashboard-content").should("be.visible");
    cy.screenshot("cl_training_coordinator_training_dashboard");
  });

  it("verifies operation flow for role: CUSTOMER_SUPPORT", () => {
    cy.loginAsRole("customer_support");

    // [1/4] - Screen: ClientIssueScreen (client_issue)
    cy.task("log", "PROGRESS: Visiting /staff/client-issue (ClientIssueScreen)...");
    cy.visitWithSemantics("/staff/client-issue");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clientissue-screen").should("be.visible");
    cy.getCy("clientissue-title").should("be.visible");
    cy.getCy("clientissue-content").should("be.visible");
    cy.screenshot("cl_customer_support_client_issue");

    // [2/4] - Screen: CommunicationScreen (communication)
    cy.task("log", "PROGRESS: Visiting /staff/communication (CommunicationScreen)...");
    cy.visitWithSemantics("/staff/communication");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("communication-screen").should("be.visible");
    cy.getCy("communication-title").should("be.visible");
    cy.getCy("communication-content").should("be.visible");
    cy.screenshot("cl_customer_support_communication");

    // [3/4] - Screen: ResolutionTrackingScreen (resolution_tracking)
    cy.task("log", "PROGRESS: Visiting /staff/resolution-tracking (ResolutionTrackingScreen)...");
    cy.visitWithSemantics("/staff/resolution-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("resolutiontracking-screen").should("be.visible");
    cy.getCy("resolutiontracking-title").should("be.visible");
    cy.getCy("resolutiontracking-content").should("be.visible");
    cy.screenshot("cl_customer_support_resolution_tracking");

    // [4/4] - Screen: TicketManagementScreen (ticket_management)
    cy.task("log", "PROGRESS: Visiting /staff/ticket-management (TicketManagementScreen)...");
    cy.visitWithSemantics("/staff/ticket-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("ticketmanagement-screen").should("be.visible");
    cy.getCy("ticketmanagement-title").should("be.visible");
    cy.getCy("ticketmanagement-content").should("be.visible");
    cy.screenshot("cl_customer_support_ticket_management");
  });

  it("verifies operation flow for role: RMT", () => {
    cy.loginAsRole("rmt");

    // [1/3] - Screen: ClientProgressScreen (client_progress)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/client-progress (ClientProgressScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/client-progress");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clientprogress-screen").should("be.visible");
    cy.getCy("clientprogress-title").should("be.visible");
    cy.getCy("clientprogress-content").should("be.visible");
    cy.screenshot("cl_rmt_client_progress");

    // [2/3] - Screen: HomeCarePlanScreen (home_care_plan)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/home-care-plan (HomeCarePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/home-care-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("homecareplan-screen").should("be.visible");
    cy.getCy("homecareplan-title").should("be.visible");
    cy.getCy("homecareplan-content").should("be.visible");
    cy.screenshot("cl_rmt_home_care_plan");

    // [3/3] - Screen: MassageAssessmentScreen (massage_assessment)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/massage-assessment (MassageAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/massage-assessment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("massageassessment-screen").should("be.visible");
    cy.getCy("massageassessment-title").should("be.visible");
    cy.getCy("massageassessment-content").should("be.visible");
    cy.screenshot("cl_rmt_massage_assessment");
  });

  it("verifies operation flow for role: COMMUNITY_OUTREACH", () => {
    cy.loginAsRole("community_outreach");

    // [1/1] - Screen: CommunityOutreachDashboardScreen (community_outreach_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/community-outreach-dashboard (CommunityOutreachDashboardScreen)...");
    cy.visitWithSemantics("/management/community-outreach-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("communityoutreachdashboard-screen").should("be.visible");
    cy.getCy("communityoutreachdashboard-title").should("be.visible");
    cy.getCy("communityoutreachdashboard-content").should("be.visible");
    cy.screenshot("cl_community_outreach_community_outreach_dashboard");
  });

  it("verifies operation flow for role: TRAINING_DIRECTOR", () => {
    cy.loginAsRole("training_director");

    // [1/2] - Screen: CourseArchitectDashboardScreen (course_architect_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/course-architect-dashboard (CourseArchitectDashboardScreen)...");
    cy.visitWithSemantics("/common/course-architect-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("coursearchitectdashboard-screen").should("be.visible");
    cy.getCy("coursearchitectdashboard-title").should("be.visible");
    cy.getCy("coursearchitectdashboard-content").should("be.visible");
    cy.screenshot("cl_training_director_course_architect_dashboard");

    // [2/2] - Screen: TrainingDirectorDashboardScreen (training_director_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/training-director-dashboard (TrainingDirectorDashboardScreen)...");
    cy.visitWithSemantics("/executive/training-director-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("trainingdirectordashboard-screen").should("be.visible");
    cy.getCy("trainingdirectordashboard-title").should("be.visible");
    cy.getCy("trainingdirectordashboard-content").should("be.visible");
    cy.screenshot("cl_training_director_training_director_dashboard");
  });

  it("verifies operation flow for role: HR_DIRECTOR", () => {
    cy.loginAsRole("hr_director");

    // [1/5] - Screen: CredentialExpiryScreen (credential_expiry)
    cy.task("log", "PROGRESS: Visiting /management/credential-expiry (CredentialExpiryScreen)...");
    cy.visitWithSemantics("/management/credential-expiry");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("credentialexpiry-screen").should("be.visible");
    cy.getCy("credentialexpiry-title").should("be.visible");
    cy.getCy("credentialexpiry-content").should("be.visible");
    cy.screenshot("cl_hr_director_credential_expiry");

    // [2/5] - Screen: EmployeeRecordsScreen (employee_records)
    cy.task("log", "PROGRESS: Visiting /management/employee-records (EmployeeRecordsScreen)...");
    cy.visitWithSemantics("/management/employee-records");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("employeerecords-screen").should("be.visible");
    cy.getCy("employeerecords-title").should("be.visible");
    cy.getCy("employeerecords-content").should("be.visible");
    cy.screenshot("cl_hr_director_employee_records");

    // [3/5] - Screen: HiringPipelineScreen (hiring_pipeline)
    cy.task("log", "PROGRESS: Visiting /management/hiring-pipeline (HiringPipelineScreen)...");
    cy.visitWithSemantics("/management/hiring-pipeline");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hiringpipeline-screen").should("be.visible");
    cy.getCy("hiringpipeline-title").should("be.visible");
    cy.getCy("hiringpipeline-content").should("be.visible");
    cy.screenshot("cl_hr_director_hiring_pipeline");

    // [4/5] - Screen: OnboardingScreen (onboarding)
    cy.task("log", "PROGRESS: Visiting /management/onboarding (OnboardingScreen)...");
    cy.visitWithSemantics("/management/onboarding");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("onboarding-screen").should("be.visible");
    cy.getCy("onboarding-title").should("be.visible");
    cy.getCy("onboarding-content").should("be.visible");
    cy.screenshot("cl_hr_director_onboarding");

    // [5/5] - Screen: TrainingManagementScreen (training_management)
    cy.task("log", "PROGRESS: Visiting /management/training-management (TrainingManagementScreen)...");
    cy.visitWithSemantics("/management/training-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("trainingmanagement-screen").should("be.visible");
    cy.getCy("trainingmanagement-title").should("be.visible");
    cy.getCy("trainingmanagement-content").should("be.visible");
    cy.screenshot("cl_hr_director_training_management");
  });

  it("verifies operation flow for role: DYNAMIC", () => {
    cy.loginAsRole("dynamic");

    // [1/2] - Screen: CustomerSupportDashboardScreen (customer_support_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/customer-support-dashboard (CustomerSupportDashboardScreen)...");
    cy.visitWithSemantics("/common/customer-support-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("customersupportdashboard-screen").should("be.visible");
    cy.getCy("customersupportdashboard-title").should("be.visible");
    cy.getCy("customersupportdashboard-content").should("be.visible");
    cy.screenshot("cl_dynamic_customer_support_dashboard");

    // [2/2] - Screen: SupportDashboardScreen (support_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/support-dashboard (SupportDashboardScreen)...");
    cy.visitWithSemantics("/common/support-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("supportdashboard-screen").should("be.visible");
    cy.getCy("supportdashboard-title").should("be.visible");
    cy.getCy("supportdashboard-content").should("be.visible");
    cy.screenshot("cl_dynamic_support_dashboard");
  });

  it("verifies operation flow for role: CX_DIRECTOR", () => {
    cy.loginAsRole("cx_director");

    // [1/1] - Screen: CxDirectorDashboardScreen (cx_director_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/cx-director-dashboard (CxDirectorDashboardScreen)...");
    cy.visitWithSemantics("/executive/cx-director-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cxdirectordashboard-screen").should("be.visible");
    cy.getCy("cxdirectordashboard-title").should("be.visible");
    cy.getCy("cxdirectordashboard-content").should("be.visible");
    cy.screenshot("cl_cx_director_cx_director_dashboard");
  });

  it("verifies operation flow for role: QA_SPECIALIST", () => {
    cy.loginAsRole("qa_specialist");

    // [1/4] - Screen: DefectTrackingScreen (defect_tracking)
    cy.task("log", "PROGRESS: Visiting /staff/defect-tracking (DefectTrackingScreen)...");
    cy.visitWithSemantics("/staff/defect-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("defecttracking-screen").should("be.visible");
    cy.getCy("defecttracking-title").should("be.visible");
    cy.getCy("defecttracking-content").should("be.visible");
    cy.screenshot("cl_qa_specialist_defect_tracking");

    // [2/4] - Screen: FailedWorkflowScreen (failed_workflow)
    cy.task("log", "PROGRESS: Visiting /staff/failed-workflow (FailedWorkflowScreen)...");
    cy.visitWithSemantics("/staff/failed-workflow");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("failedworkflow-screen").should("be.visible");
    cy.getCy("failedworkflow-title").should("be.visible");
    cy.getCy("failedworkflow-content").should("be.visible");
    cy.screenshot("cl_qa_specialist_failed_workflow");

    // [3/4] - Screen: QualityAuditScreen (quality_audit)
    cy.task("log", "PROGRESS: Visiting /staff/quality-audit (QualityAuditScreen)...");
    cy.visitWithSemantics("/staff/quality-audit");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("qualityaudit-screen").should("be.visible");
    cy.getCy("qualityaudit-title").should("be.visible");
    cy.getCy("qualityaudit-content").should("be.visible");
    cy.screenshot("cl_qa_specialist_quality_audit");

    // [4/4] - Screen: TestingOverviewScreen (testing_overview)
    cy.task("log", "PROGRESS: Visiting /staff/testing-overview (TestingOverviewScreen)...");
    cy.visitWithSemantics("/staff/testing-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("testingoverview-screen").should("be.visible");
    cy.getCy("testingoverview-title").should("be.visible");
    cy.getCy("testingoverview-content").should("be.visible");
    cy.screenshot("cl_qa_specialist_testing_overview");
  });

  it("verifies operation flow for role: GUEST", () => {
    cy.loginAsRole("guest");

    // [1/2] - Screen: DynamicScreenDashboardScreen (dynamic_screen_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/dynamic-dashboard (DynamicScreenDashboardScreen)...");
    cy.visitWithSemantics("/common/dynamic-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("dynamicdashboard-screen").should("be.visible");
    cy.getCy("dynamicdashboard-title").should("be.visible");
    cy.getCy("dynamicdashboard-content").should("be.visible");
    cy.screenshot("cl_guest_dynamic_screen_dashboard");

    // [2/2] - Screen: GuestDashboardScreen (guest_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/guest-dashboard (GuestDashboardScreen)...");
    cy.visitWithSemantics("/common/guest-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("guestdashboard-screen").should("be.visible");
    cy.getCy("guestdashboard-title").should("be.visible");
    cy.getCy("guestdashboard-content").should("be.visible");
    cy.screenshot("cl_guest_guest_dashboard");
  });

  it("verifies operation flow for role: EMPLOYEE", () => {
    cy.loginAsRole("employee");

    // [1/1] - Screen: EmployeeDashboardScreen (employee_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/employee-dashboard (EmployeeDashboardScreen)...");
    cy.visitWithSemantics("/staff/employee-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("employeedashboard-screen").should("be.visible");
    cy.getCy("employeedashboard-title").should("be.visible");
    cy.getCy("employeedashboard-content").should("be.visible");
    cy.screenshot("cl_employee_employee_dashboard");
  });

  it("verifies operation flow for role: GM", () => {
    cy.loginAsRole("gm");

    // [1/1] - Screen: GeneralManagerDashboardScreen (general_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/general-manager-dashboard (GeneralManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/general-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("generalmanagerdashboard-screen").should("be.visible");
    cy.getCy("generalmanagerdashboard-title").should("be.visible");
    cy.getCy("generalmanagerdashboard-content").should("be.visible");
    cy.screenshot("cl_gm_general_manager_dashboard");
  });

  it("verifies operation flow for role: INFRASTRUCTURE", () => {
    cy.loginAsRole("infrastructure");

    // [1/1] - Screen: InfrastructureDashboardScreen (infrastructure_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/infrastructure-dashboard (InfrastructureDashboardScreen)...");
    cy.visitWithSemantics("/common/infrastructure-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("infrastructuredashboard-screen").should("be.visible");
    cy.getCy("infrastructuredashboard-title").should("be.visible");
    cy.getCy("infrastructuredashboard-content").should("be.visible");
    cy.screenshot("cl_infrastructure_infrastructure_dashboard");
  });

  it("verifies operation flow for role: VOLUNTEER_COORDINATOR", () => {
    cy.loginAsRole("volunteer_coordinator");

    // [1/7] - Screen: IntakeCoordinatorAssessmentQueueScreen (intake_coordinator_assessment_queue)
    cy.task("log", "PROGRESS: Visiting /executive/intake-coordinator-assessment-queue (IntakeCoordinatorAssessmentQueueScreen)...");
    cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
    cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
    cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");
    cy.screenshot("cl_volunteer_coordinator_intake_coordinator_assessment_queue");

    // [2/7] - Screen: IntakeCoordinatorBookingScreen (intake_coordinator_booking)
    cy.task("log", "PROGRESS: Visiting /executive/intake-coordinator-booking (IntakeCoordinatorBookingScreen)...");
    cy.visitWithSemantics("/executive/intake-coordinator-booking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
    cy.getCy("intakecoordinatorbooking-title").should("be.visible");
    cy.getCy("intakecoordinatorbooking-content").should("be.visible");
    cy.screenshot("cl_volunteer_coordinator_intake_coordinator_booking");

    // [3/7] - Screen: IntakeCoordinatorDocumentsScreen (intake_coordinator_documents)
    cy.task("log", "PROGRESS: Visiting /executive/intake-coordinator-documents (IntakeCoordinatorDocumentsScreen)...");
    cy.visitWithSemantics("/executive/intake-coordinator-documents");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
    cy.getCy("intakecoordinatordocuments-title").should("be.visible");
    cy.getCy("intakecoordinatordocuments-content").should("be.visible");
    cy.screenshot("cl_volunteer_coordinator_intake_coordinator_documents");

    // [4/7] - Screen: IntakeCoordinatorFollowUpScreen (intake_coordinator_follow_up)
    cy.task("log", "PROGRESS: Visiting /executive/intake-coordinator-follow-up (IntakeCoordinatorFollowUpScreen)...");
    cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
    cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
    cy.getCy("intakecoordinatorfollowup-content").should("be.visible");
    cy.screenshot("cl_volunteer_coordinator_intake_coordinator_follow_up");

    // [5/7] - Screen: IntakeCoordinatorNewClientIntakeScreen (intake_coordinator_new_client_intake)
    cy.task("log", "PROGRESS: Visiting /executive/intake-coordinator-new-client-intake (IntakeCoordinatorNewClientIntakeScreen)...");
    cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
    cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
    cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");
    cy.screenshot("cl_volunteer_coordinator_intake_coordinator_new_client_intake");

    // [6/7] - Screen: IntakeCoordinatorReferralsScreen (intake_coordinator_referrals)
    cy.task("log", "PROGRESS: Visiting /executive/intake-coordinator-referrals (IntakeCoordinatorReferralsScreen)...");
    cy.visitWithSemantics("/executive/intake-coordinator-referrals");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
    cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
    cy.getCy("intakecoordinatorreferrals-content").should("be.visible");
    cy.screenshot("cl_volunteer_coordinator_intake_coordinator_referrals");

    // [7/7] - Screen: VolunteerCoordinatorDashboardScreen (volunteer_coordinator_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/volunteer-coordinator-dashboard (VolunteerCoordinatorDashboardScreen)...");
    cy.visitWithSemantics("/staff/volunteer-coordinator-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
    cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
    cy.getCy("volunteercoordinatordashboard-content").should("be.visible");
    cy.screenshot("cl_volunteer_coordinator_volunteer_coordinator_dashboard");
  });

  it("verifies operation flow for role: LEGAL", () => {
    cy.loginAsRole("legal");

    // [1/1] - Screen: LegalDashboardScreen (legal_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/legal-dashboard (LegalDashboardScreen)...");
    cy.visitWithSemantics("/executive/legal-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("legaldashboard-screen").should("be.visible");
    cy.getCy("legaldashboard-title").should("be.visible");
    cy.getCy("legaldashboard-content").should("be.visible");
    cy.screenshot("cl_legal_legal_dashboard");
  });

  it("verifies operation flow for role: PARTNERSHIP", () => {
    cy.loginAsRole("partnership");

    // [1/1] - Screen: PartnershipManagerDashboardScreen (partnership_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/partnership-manager-dashboard (PartnershipManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/partnership-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
    cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
    cy.getCy("partnershipmanagerdashboard-content").should("be.visible");
    cy.screenshot("cl_partnership_partnership_manager_dashboard");
  });

  it("verifies operation flow for role: PORTAL", () => {
    cy.loginAsRole("portal");

    // [1/1] - Screen: PortalDashboardScreen (portal_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/portal-dashboard (PortalDashboardScreen)...");
    cy.visitWithSemantics("/common/portal-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("portaldashboard-screen").should("be.visible");
    cy.getCy("portaldashboard-title").should("be.visible");
    cy.getCy("portaldashboard-content").should("be.visible");
    cy.screenshot("cl_portal_portal_dashboard");
  });

  it("verifies operation flow for role: PREMIUM_CONCIERGE", () => {
    cy.loginAsRole("premium_concierge");

    // [1/1] - Screen: PremiumConciergeDashboardScreen (premium_concierge_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/premium-concierge-dashboard (PremiumConciergeDashboardScreen)...");
    cy.visitWithSemantics("/management/premium-concierge-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("premiumconciergedashboard-screen").should("be.visible");
    cy.getCy("premiumconciergedashboard-title").should("be.visible");
    cy.getCy("premiumconciergedashboard-content").should("be.visible");
    cy.screenshot("cl_premium_concierge_premium_concierge_dashboard");
  });

  it("verifies operation flow for role: SYSTEM_VERIFICATION", () => {
    cy.loginAsRole("system_verification");

    // [1/3] - Screen: QaDashboardScreen (qa_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/qa-dashboard (QaDashboardScreen)...");
    cy.visitWithSemantics("/common/qa-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("qadashboard-screen").should("be.visible");
    cy.getCy("qadashboard-title").should("be.visible");
    cy.getCy("qadashboard-content").should("be.visible");
    cy.screenshot("cl_system_verification_qa_dashboard");

    // [2/3] - Screen: QualityAssuranceDashboardScreen (quality_assurance_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/quality-assurance-dashboard (QualityAssuranceDashboardScreen)...");
    cy.visitWithSemantics("/staff/quality-assurance-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("qualityassurancedashboard-screen").should("be.visible");
    cy.getCy("qualityassurancedashboard-title").should("be.visible");
    cy.getCy("qualityassurancedashboard-content").should("be.visible");
    cy.screenshot("cl_system_verification_quality_assurance_dashboard");

    // [3/3] - Screen: SystemVerificationDashboardScreen (system_verification_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/system-verification-dashboard (SystemVerificationDashboardScreen)...");
    cy.visitWithSemantics("/common/system-verification-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("systemverificationdashboard-screen").should("be.visible");
    cy.getCy("systemverificationdashboard-title").should("be.visible");
    cy.getCy("systemverificationdashboard-content").should("be.visible");
    cy.screenshot("cl_system_verification_system_verification_dashboard");
  });

  it("verifies operation flow for role: REGIONAL_BDM", () => {
    cy.loginAsRole("regional_bdm");

    // [1/1] - Screen: RegionalBdmDashboardScreen (regional_bdm_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/regional-bdm-dashboard (RegionalBdmDashboardScreen)...");
    cy.visitWithSemantics("/management/regional-bdm-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("regionalbdmdashboard-screen").should("be.visible");
    cy.getCy("regionalbdmdashboard-title").should("be.visible");
    cy.getCy("regionalbdmdashboard-content").should("be.visible");
    cy.screenshot("cl_regional_bdm_regional_bdm_dashboard");
  });

  it("verifies operation flow for role: REGIONAL_MANAGER_USA", () => {
    cy.loginAsRole("regional_manager_usa");

    // [1/1] - Screen: RegionalManagerUsaDashboardScreen (regional_manager_usa_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/regional-manager-usa-dashboard (RegionalManagerUsaDashboardScreen)...");
    cy.visitWithSemantics("/management/regional-manager-usa-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
    cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
    cy.getCy("regionalmanagerusadashboard-content").should("be.visible");
    cy.screenshot("cl_regional_manager_usa_regional_manager_usa_dashboard");
  });

  it("verifies operation flow for role: SCRUM_MASTER", () => {
    cy.loginAsRole("scrum_master");

    // [1/1] - Screen: ScrumMasterDashboardScreen (scrum_master_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/scrum-master-dashboard (ScrumMasterDashboardScreen)...");
    cy.visitWithSemantics("/management/scrum-master-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("scrummasterdashboard-screen").should("be.visible");
    cy.getCy("scrummasterdashboard-title").should("be.visible");
    cy.getCy("scrummasterdashboard-content").should("be.visible");
    cy.screenshot("cl_scrum_master_scrum_master_dashboard");
  });

  it("verifies operation flow for role: SHAREHOLDER", () => {
    cy.loginAsRole("shareholder");

    // [1/1] - Screen: ShareholderDashboardScreen (shareholder_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/shareholder-dashboard (ShareholderDashboardScreen)...");
    cy.visitWithSemantics("/executive/shareholder-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("shareholderdashboard-screen").should("be.visible");
    cy.getCy("shareholderdashboard-title").should("be.visible");
    cy.getCy("shareholderdashboard-content").should("be.visible");
    cy.screenshot("cl_shareholder_shareholder_dashboard");
  });

  it("verifies operation flow for role: TERRITORY_EXPANSION", () => {
    cy.loginAsRole("territory_expansion");

    // [1/1] - Screen: TerritoryExpansionManagerDashboardScreen (territory_expansion_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/territory-expansion-manager-dashboard (TerritoryExpansionManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/territory-expansion-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
    cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
    cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");
    cy.screenshot("cl_territory_expansion_territory_expansion_manager_dashboard");
  });

  it("verifies operation flow for role: TERRITORY_SALES", () => {
    cy.loginAsRole("territory_sales");

    // [1/1] - Screen: TerritorySalesManagerDashboardScreen (territory_sales_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/territory-sales-manager-dashboard (TerritorySalesManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/territory-sales-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
    cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
    cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");
    cy.screenshot("cl_territory_sales_territory_sales_manager_dashboard");
  });

  it("verifies operation flow for role: TRAINING", () => {
    cy.loginAsRole("training");

    // [1/2] - Screen: TrainingCoordinatorDashboardScreen (training_coordinator_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/training-coordinator-dashboard (TrainingCoordinatorDashboardScreen)...");
    cy.visitWithSemantics("/staff/training-coordinator-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
    cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
    cy.getCy("trainingcoordinatordashboard-content").should("be.visible");
    cy.screenshot("cl_training_training_coordinator_dashboard");

    // [2/2] - Screen: TrainingHubDashboardScreen (training_hub_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/training-hub-dashboard (TrainingHubDashboardScreen)...");
    cy.visitWithSemantics("/common/training-hub-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("traininghubdashboard-screen").should("be.visible");
    cy.getCy("traininghubdashboard-title").should("be.visible");
    cy.getCy("traininghubdashboard-content").should("be.visible");
    cy.screenshot("cl_training_training_hub_dashboard");
  });

  it("verifies operation flow for role: VIP_MANAGER", () => {
    cy.loginAsRole("vip_manager");

    // [1/1] - Screen: VipManagerDashboardScreen (vip_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/vip-manager-dashboard (VipManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/vip-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("vipmanagerdashboard-screen").should("be.visible");
    cy.getCy("vipmanagerdashboard-title").should("be.visible");
    cy.getCy("vipmanagerdashboard-content").should("be.visible");
    cy.screenshot("cl_vip_manager_vip_manager_dashboard");
  });

  it("verifies operation flow for role: VOLUNTEER", () => {
    cy.loginAsRole("volunteer");

    // [1/1] - Screen: VolunteerDashboardScreen (volunteer_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/volunteer-dashboard (VolunteerDashboardScreen)...");
    cy.visitWithSemantics("/staff/volunteer-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("volunteerdashboard-screen").should("be.visible");
    cy.getCy("volunteerdashboard-title").should("be.visible");
    cy.getCy("volunteerdashboard-content").should("be.visible");
    cy.screenshot("cl_volunteer_volunteer_dashboard");
  });
});
