// AUTO-GENERATED APP E2E SPEC. SYSTEMATICALLY GENERATED.
// Tests all allowed roles and their respective screens on the portal.
// Leverages reusable SSO commands and custom Semantics selector lookups.

describe("App All Roles All Screens - Primecare Clinic", () => {

  it("verifies operation flow for role: PHYSIO", () => {
    cy.loginAsRole("physio");

    // [1/13] - Screen: AssessmentScreen (assessment)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/assessment (AssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("assessment-screen").should("be.visible");
    cy.getCy("assessment-title").should("be.visible");
    cy.getCy("assessment-content").should("be.visible");
    cy.screenshot("ci_physio_assessment");

    // [2/13] - Screen: ExercisePrescriptionScreen (exercise_prescription)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/exercise-prescription (ExercisePrescriptionScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-prescription");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("exerciseprescription-screen").should("be.visible");
    cy.getCy("exerciseprescription-title").should("be.visible");
    cy.getCy("exerciseprescription-content").should("be.visible");
    cy.screenshot("ci_physio_exercise_prescription");

    // [3/13] - Screen: PhysiotherapistAppointmentsScreen (physiotherapist_appointments)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/appointments (PhysiotherapistAppointmentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/appointments");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistappointments-screen").should("be.visible");
    cy.getCy("physiotherapistappointments-title").should("be.visible");
    cy.getCy("physiotherapistappointments-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_appointments");

    // [4/13] - Screen: PhysiotherapistAssessmentScreen (physiotherapist_assessment)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/assessment (PhysiotherapistAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistassessment-screen").should("be.visible");
    cy.getCy("physiotherapistassessment-title").should("be.visible");
    cy.getCy("physiotherapistassessment-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_assessment");

    // [5/13] - Screen: PhysiotherapistBillingLinkScreen (physiotherapist_billing_link)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/billing-link (PhysiotherapistBillingLinkScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/billing-link");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
    cy.getCy("physiotherapistbillinglink-title").should("be.visible");
    cy.getCy("physiotherapistbillinglink-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_billing_link");

    // [6/13] - Screen: PhysiotherapistClientIntakeScreen (physiotherapist_client_intake)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/client-intake (PhysiotherapistClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/client-intake");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistclientintake-screen").should("be.visible");
    cy.getCy("physiotherapistclientintake-title").should("be.visible");
    cy.getCy("physiotherapistclientintake-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_client_intake");

    // [7/13] - Screen: PhysiotherapistCommandCenterScreen (physiotherapist_command_center)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/command-center (PhysiotherapistCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
    cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
    cy.getCy("physiotherapistcommandcenter-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_command_center");

    // [8/13] - Screen: PhysiotherapistDashboardScreen (physiotherapist_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistdashboard-screen").should("be.visible");
    cy.getCy("physiotherapistdashboard-title").should("be.visible");
    cy.getCy("physiotherapistdashboard-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_dashboard");

    // [9/13] - Screen: PhysiotherapistExercisePlanScreen (physiotherapist_exercise_plan)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/exercise-plan (PhysiotherapistExercisePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
    cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
    cy.getCy("physiotherapistexerciseplan-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_exercise_plan");

    // [10/13] - Screen: PhysiotherapistReportsScreen (physiotherapist_reports)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/reports (PhysiotherapistReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/reports");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapistreports-screen").should("be.visible");
    cy.getCy("physiotherapistreports-title").should("be.visible");
    cy.getCy("physiotherapistreports-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_reports");

    // [11/13] - Screen: PhysiotherapistTreatmentNotesScreen (physiotherapist_treatment_notes)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/treatment-notes (PhysiotherapistTreatmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-notes");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
    cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
    cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");
    cy.screenshot("ci_physio_physiotherapist_treatment_notes");

    // [12/13] - Screen: ProgressTrackingScreen (progress_tracking)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/progress-tracking (ProgressTrackingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/progress-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("progresstracking-screen").should("be.visible");
    cy.getCy("progresstracking-title").should("be.visible");
    cy.getCy("progresstracking-content").should("be.visible");
    cy.screenshot("ci_physio_progress_tracking");

    // [13/13] - Screen: TreatmentPlanScreen (treatment_plan)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/physiotherapist/treatment-plan (TreatmentPlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("treatmentplan-screen").should("be.visible");
    cy.getCy("treatmentplan-title").should("be.visible");
    cy.getCy("treatmentplan-content").should("be.visible");
    cy.screenshot("ci_physio_treatment_plan");
  });

  it("verifies operation flow for role: INTAKE", () => {
    cy.loginAsRole("intake");

    // [1/6] - Screen: BookingScreen (booking)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/intake_coordinator/booking (BookingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/booking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("booking-screen").should("be.visible");
    cy.getCy("booking-title").should("be.visible");
    cy.getCy("booking-content").should("be.visible");
    cy.screenshot("ci_intake_booking");

    // [2/6] - Screen: ClientIntakeScreen (client_intake)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/intake_coordinator/client-intake (ClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/client-intake");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clientintake-screen").should("be.visible");
    cy.getCy("clientintake-title").should("be.visible");
    cy.getCy("clientintake-content").should("be.visible");
    cy.screenshot("ci_intake_client_intake");

    // [3/6] - Screen: FollowupScreen (followup)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/intake_coordinator/followup (FollowupScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/followup");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("followup-screen").should("be.visible");
    cy.getCy("followup-title").should("be.visible");
    cy.getCy("followup-content").should("be.visible");
    cy.screenshot("ci_intake_followup");

    // [4/6] - Screen: IntakeCoordinatorDashboardScreen (intake_coordinator_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/intake_coordinator/coordinator-dashboard (IntakeCoordinatorDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
    cy.getCy("intakecoordinatordashboard-title").should("be.visible");
    cy.getCy("intakecoordinatordashboard-content").should("be.visible");
    cy.screenshot("ci_intake_intake_coordinator_dashboard");

    // [5/6] - Screen: IntakeDashboardScreen (intake_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/intake_coordinator/dashboard (IntakeDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("intakedashboard-screen").should("be.visible");
    cy.getCy("intakedashboard-title").should("be.visible");
    cy.getCy("intakedashboard-content").should("be.visible");
    cy.screenshot("ci_intake_intake_dashboard");

    // [6/6] - Screen: ReferralManagementScreen (referral_management)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/intake_coordinator/referral-management (ReferralManagementScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/referral-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("referralmanagement-screen").should("be.visible");
    cy.getCy("referralmanagement-title").should("be.visible");
    cy.getCy("referralmanagement-content").should("be.visible");
    cy.screenshot("ci_intake_referral_management");
  });

  it("verifies operation flow for role: RN", () => {
    cy.loginAsRole("rn");

    // [1/14] - Screen: CarePlanReviewScreen (care_plan_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/care-plan-review (CarePlanReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/care-plan-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("careplanreview-screen").should("be.visible");
    cy.getCy("careplanreview-title").should("be.visible");
    cy.getCy("careplanreview-content").should("be.visible");
    cy.screenshot("ci_rn_care_plan_review");

    // [2/14] - Screen: IncidentReviewScreen (incident_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/incident-review (IncidentReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/incident-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("incidentreview-screen").should("be.visible");
    cy.getCy("incidentreview-title").should("be.visible");
    cy.getCy("incidentreview-content").should("be.visible");
    cy.screenshot("ci_rn_incident_review");

    // [3/14] - Screen: MedicationAdministrationScreen (medication_administration)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/medication-administration (MedicationAdministrationScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/medication-administration");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("medicationadministration-screen").should("be.visible");
    cy.getCy("medicationadministration-title").should("be.visible");
    cy.getCy("medicationadministration-content").should("be.visible");
    cy.screenshot("ci_rn_medication_administration");

    // [4/14] - Screen: PatientChartingScreen (patient_charting)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/patient-charting (PatientChartingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/patient-charting");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientcharting-screen").should("be.visible");
    cy.getCy("patientcharting-title").should("be.visible");
    cy.getCy("patientcharting-content").should("be.visible");
    cy.screenshot("ci_rn_patient_charting");

    // [5/14] - Screen: RnCarePlanReviewScreen (rn_care_plan_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/rn-care-plan-review (RnCarePlanReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-care-plan-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rncareplanreview-screen").should("be.visible");
    cy.getCy("rncareplanreview-title").should("be.visible");
    cy.getCy("rncareplanreview-content").should("be.visible");
    cy.screenshot("ci_rn_rn_care_plan_review");

    // [6/14] - Screen: RnCommandCenterScreen (rn_command_center)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/rn-command-center (RnCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rncommandcenter-screen").should("be.visible");
    cy.getCy("rncommandcenter-title").should("be.visible");
    cy.getCy("rncommandcenter-content").should("be.visible");
    cy.screenshot("ci_rn_rn_command_center");

    // [7/14] - Screen: RnDashboardScreen (rn_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/dashboard (RnDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rndashboard-screen").should("be.visible");
    cy.getCy("rndashboard-title").should("be.visible");
    cy.getCy("rndashboard-content").should("be.visible");
    cy.screenshot("ci_rn_rn_dashboard");

    // [8/14] - Screen: RnIncidentReviewScreen (rn_incident_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/rn-incident-review (RnIncidentReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-incident-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rnincidentreview-screen").should("be.visible");
    cy.getCy("rnincidentreview-title").should("be.visible");
    cy.getCy("rnincidentreview-content").should("be.visible");
    cy.screenshot("ci_rn_rn_incident_review");

    // [9/14] - Screen: RnMedicationsScreen (rn_medications)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/medications (RnMedicationsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/medications");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rnmedications-screen").should("be.visible");
    cy.getCy("rnmedications-title").should("be.visible");
    cy.getCy("rnmedications-content").should("be.visible");
    cy.screenshot("ci_rn_rn_medications");

    // [10/14] - Screen: RnPatientChartingScreen (rn_patient_charting)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/patient-charting (RnPatientChartingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/patient-charting");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rnpatientcharting-screen").should("be.visible");
    cy.getCy("rnpatientcharting-title").should("be.visible");
    cy.getCy("rnpatientcharting-content").should("be.visible");
    cy.screenshot("ci_rn_rn_patient_charting");

    // [11/14] - Screen: RnReportsScreen (rn_reports)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/rn-reports (RnReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-reports");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rnreports-screen").should("be.visible");
    cy.getCy("rnreports-title").should("be.visible");
    cy.getCy("rnreports-content").should("be.visible");
    cy.screenshot("ci_rn_rn_reports");

    // [12/14] - Screen: RnTasksScreen (rn_tasks)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/rn-tasks (RnTasksScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-tasks");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rntasks-screen").should("be.visible");
    cy.getCy("rntasks-title").should("be.visible");
    cy.getCy("rntasks-content").should("be.visible");
    cy.screenshot("ci_rn_rn_tasks");

    // [13/14] - Screen: RnVitalsScreen (rn_vitals)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/vitals (RnVitalsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/vitals");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rnvitals-screen").should("be.visible");
    cy.getCy("rnvitals-title").should("be.visible");
    cy.getCy("rnvitals-content").should("be.visible");
    cy.screenshot("ci_rn_rn_vitals");

    // [14/14] - Screen: ShiftReportScreen (shift_report)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rn/shift-report (ShiftReportScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/shift-report");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("shiftreport-screen").should("be.visible");
    cy.getCy("shiftreport-title").should("be.visible");
    cy.getCy("shiftreport-content").should("be.visible");
    cy.screenshot("ci_rn_shift_report");
  });

  it("verifies operation flow for role: CHIROPRACTOR", () => {
    cy.loginAsRole("chiropractor");

    // [1/9] - Screen: ChiropractorAppointmentsScreen (chiropractor_appointments)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/appointments (ChiropractorAppointmentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/appointments");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractorappointments-screen").should("be.visible");
    cy.getCy("chiropractorappointments-title").should("be.visible");
    cy.getCy("chiropractorappointments-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_appointments");

    // [2/9] - Screen: ChiropractorAssessmentScreen (chiropractor_assessment)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/assessment (ChiropractorAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/assessment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractorassessment-screen").should("be.visible");
    cy.getCy("chiropractorassessment-title").should("be.visible");
    cy.getCy("chiropractorassessment-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_assessment");

    // [3/9] - Screen: ChiropractorBillingLinkScreen (chiropractor_billing_link)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/billing-link (ChiropractorBillingLinkScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/billing-link");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractorbillinglink-screen").should("be.visible");
    cy.getCy("chiropractorbillinglink-title").should("be.visible");
    cy.getCy("chiropractorbillinglink-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_billing_link");

    // [4/9] - Screen: ChiropractorClientIntakeScreen (chiropractor_client_intake)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/client-intake (ChiropractorClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/client-intake");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractorclientintake-screen").should("be.visible");
    cy.getCy("chiropractorclientintake-title").should("be.visible");
    cy.getCy("chiropractorclientintake-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_client_intake");

    // [5/9] - Screen: ChiropractorCommandCenterScreen (chiropractor_command_center)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/command-center (ChiropractorCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
    cy.getCy("chiropractorcommandcenter-title").should("be.visible");
    cy.getCy("chiropractorcommandcenter-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_command_center");

    // [6/9] - Screen: ChiropractorDashboardScreen (chiropractor_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractordashboard-screen").should("be.visible");
    cy.getCy("chiropractordashboard-title").should("be.visible");
    cy.getCy("chiropractordashboard-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_dashboard");

    // [7/9] - Screen: ChiropractorExercisePlanScreen (chiropractor_exercise_plan)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/exercise-plan (ChiropractorExercisePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/exercise-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
    cy.getCy("chiropractorexerciseplan-title").should("be.visible");
    cy.getCy("chiropractorexerciseplan-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_exercise_plan");

    // [8/9] - Screen: ChiropractorReportsScreen (chiropractor_reports)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/reports (ChiropractorReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/reports");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractorreports-screen").should("be.visible");
    cy.getCy("chiropractorreports-title").should("be.visible");
    cy.getCy("chiropractorreports-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_reports");

    // [9/9] - Screen: ChiropractorTreatmentNotesScreen (chiropractor_treatment_notes)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/chiropractor/treatment-notes (ChiropractorTreatmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/treatment-notes");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
    cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
    cy.getCy("chiropractortreatmentnotes-content").should("be.visible");
    cy.screenshot("ci_chiropractor_chiropractor_treatment_notes");
  });

  it("verifies operation flow for role: CLINICAL_DIRECTOR", () => {
    cy.loginAsRole("clinical_director");

    // [1/13] - Screen: ClinicDashboardScreen (clinic_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/clinic-dashboard (ClinicDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicdashboard-screen").should("be.visible");
    cy.getCy("clinicdashboard-title").should("be.visible");
    cy.getCy("clinicdashboard-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinic_dashboard");

    // [2/13] - Screen: ClinicalDashboardScreen (clinical_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/dashboard (ClinicalDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaldashboard-screen").should("be.visible");
    cy.getCy("clinicaldashboard-title").should("be.visible");
    cy.getCy("clinicaldashboard-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_dashboard");

    // [3/13] - Screen: ClinicalDirectorApprovalsScreen (clinical_director_approvals)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/approvals (ClinicalDirectorApprovalsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/approvals");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaldirectorapprovals-screen").should("be.visible");
    cy.getCy("clinicaldirectorapprovals-title").should("be.visible");
    cy.getCy("clinicaldirectorapprovals-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_director_approvals");

    // [4/13] - Screen: ClinicalDirectorComplianceScreen (clinical_director_compliance)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/compliance-director (ClinicalDirectorComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-director");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
    cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
    cy.getCy("clinicaldirectorcompliance-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_director_compliance");

    // [5/13] - Screen: ClinicalDirectorIncidentReviewScreen (clinical_director_incident_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/incident-review (ClinicalDirectorIncidentReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible");
    cy.getCy("clinicaldirectorincidentreview-title").should("be.visible");
    cy.getCy("clinicaldirectorincidentreview-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_director_incident_review");

    // [6/13] - Screen: ClinicalDirectorPerformanceScreen (clinical_director_performance)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/performance (ClinicalDirectorPerformanceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/performance");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaldirectorperformance-screen").should("be.visible");
    cy.getCy("clinicaldirectorperformance-title").should("be.visible");
    cy.getCy("clinicaldirectorperformance-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_director_performance");

    // [7/13] - Screen: ClinicalDirectorReportsScreen (clinical_director_reports)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/reports (ClinicalDirectorReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/reports");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaldirectorreports-screen").should("be.visible");
    cy.getCy("clinicaldirectorreports-title").should("be.visible");
    cy.getCy("clinicaldirectorreports-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_director_reports");

    // [8/13] - Screen: ClinicalDirectorStaffQualityScreen (clinical_director_staff_quality)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/staff-quality (ClinicalDirectorStaffQualityScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-quality");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible");
    cy.getCy("clinicaldirectorstaffquality-title").should("be.visible");
    cy.getCy("clinicaldirectorstaffquality-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_director_staff_quality");

    // [9/13] - Screen: ClinicalOperations4KScreen (clinical_operations4_k)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/operations4k (ClinicalOperations4KScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/operations4k");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicaloperations4k-screen").should("be.visible");
    cy.getCy("clinicaloperations4k-title").should("be.visible");
    cy.getCy("clinicaloperations4k-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_operations4_k");

    // [10/13] - Screen: ClinicalQualityScreen (clinical_quality)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/quality (ClinicalQualityScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/quality");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("clinicalquality-screen").should("be.visible");
    cy.getCy("clinicalquality-title").should("be.visible");
    cy.getCy("clinicalquality-content").should("be.visible");
    cy.screenshot("ci_clinical_director_clinical_quality");

    // [11/13] - Screen: ComplianceReviewScreen (compliance_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/compliance-review (ComplianceReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("compliancereview-screen").should("be.visible");
    cy.getCy("compliancereview-title").should("be.visible");
    cy.getCy("compliancereview-content").should("be.visible");
    cy.screenshot("ci_clinical_director_compliance_review");

    // [12/13] - Screen: IncidentOversightScreen (incident_oversight)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/incident-oversight (IncidentOversightScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-oversight");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("incidentoversight-screen").should("be.visible");
    cy.getCy("incidentoversight-title").should("be.visible");
    cy.getCy("incidentoversight-content").should("be.visible");
    cy.screenshot("ci_clinical_director_incident_oversight");

    // [13/13] - Screen: StaffPerformanceScreen (staff_performance)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/clinical_director/staff-performance (StaffPerformanceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-performance");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("staffperformance-screen").should("be.visible");
    cy.getCy("staffperformance-title").should("be.visible");
    cy.getCy("staffperformance-content").should("be.visible");
    cy.screenshot("ci_clinical_director_staff_performance");
  });

  it("verifies operation flow for role: CNS", () => {
    cy.loginAsRole("cns");

    // [1/1] - Screen: CnsDashboardScreen (cns_dashboard)
    cy.task("log", "PROGRESS: Visiting /clinical/cns-dashboard (CnsDashboardScreen)...");
    cy.visitWithSemantics("/clinical/cns-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cnsdashboard-screen").should("be.visible");
    cy.getCy("cnsdashboard-title").should("be.visible");
    cy.getCy("cnsdashboard-content").should("be.visible");
    cy.screenshot("ci_cns_cns_dashboard");
  });

  it("verifies operation flow for role: HSW", () => {
    cy.loginAsRole("hsw");

    // [1/1] - Screen: HswDashboardScreen (hsw_dashboard)
    cy.task("log", "PROGRESS: Visiting /clinical/hsw-dashboard (HswDashboardScreen)...");
    cy.visitWithSemantics("/clinical/hsw-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hswdashboard-screen").should("be.visible");
    cy.getCy("hswdashboard-title").should("be.visible");
    cy.getCy("hswdashboard-content").should("be.visible");
    cy.screenshot("ci_hsw_hsw_dashboard");
  });

  it("verifies operation flow for role: PSW", () => {
    cy.loginAsRole("psw");

    // [1/14] - Screen: IncidentReportScreen (incident_report)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/incident-report (IncidentReportScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("incidentreport-screen").should("be.visible");
    cy.getCy("incidentreport-title").should("be.visible");
    cy.getCy("incidentreport-content").should("be.visible");
    cy.screenshot("ci_psw_incident_report");

    // [2/14] - Screen: PswCarePlanScreen (psw_care_plan)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/care-plan (PswCarePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/care-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswcareplan-screen").should("be.visible");
    cy.getCy("pswcareplan-title").should("be.visible");
    cy.getCy("pswcareplan-content").should("be.visible");
    cy.screenshot("ci_psw_psw_care_plan");

    // [3/14] - Screen: PswClientProfileScreen (psw_client_profile)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/psw-client-profile (PswClientProfileScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/psw-client-profile");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswclientprofile-screen").should("be.visible");
    cy.getCy("pswclientprofile-title").should("be.visible");
    cy.getCy("pswclientprofile-content").should("be.visible");
    cy.screenshot("ci_psw_psw_client_profile");

    // [4/14] - Screen: PswCommandCenterScreen (psw_command_center)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/psw-command-center (PswCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/psw-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswcommandcenter-screen").should("be.visible");
    cy.getCy("pswcommandcenter-title").should("be.visible");
    cy.getCy("pswcommandcenter-content").should("be.visible");
    cy.screenshot("ci_psw_psw_command_center");

    // [5/14] - Screen: PswDashboardScreen (psw_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswdashboard-screen").should("be.visible");
    cy.getCy("pswdashboard-title").should("be.visible");
    cy.getCy("pswdashboard-content").should("be.visible");
    cy.screenshot("ci_psw_psw_dashboard");

    // [6/14] - Screen: PswDocumentsScreen (psw_documents)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/documents (PswDocumentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/documents");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswdocuments-screen").should("be.visible");
    cy.getCy("pswdocuments-title").should("be.visible");
    cy.getCy("pswdocuments-content").should("be.visible");
    cy.screenshot("ci_psw_psw_documents");

    // [7/14] - Screen: PswIncidentReportScreen (psw_incident_report)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/incident-report (PswIncidentReportScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswincidentreport-screen").should("be.visible");
    cy.getCy("pswincidentreport-title").should("be.visible");
    cy.getCy("pswincidentreport-content").should("be.visible");
    cy.screenshot("ci_psw_psw_incident_report");

    // [8/14] - Screen: PswMessagesScreen (psw_messages)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswmessages-screen").should("be.visible");
    cy.getCy("pswmessages-title").should("be.visible");
    cy.getCy("pswmessages-content").should("be.visible");
    cy.screenshot("ci_psw_psw_messages");

    // [9/14] - Screen: PswMyShiftsScreen (psw_my_shifts)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/psw-my-shifts (PswMyShiftsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/psw-my-shifts");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswmyshifts-screen").should("be.visible");
    cy.getCy("pswmyshifts-title").should("be.visible");
    cy.getCy("pswmyshifts-content").should("be.visible");
    cy.screenshot("ci_psw_psw_my_shifts");

    // [10/14] - Screen: PswVisitNotesScreen (psw_visit_notes)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswvisitnotes-screen").should("be.visible");
    cy.getCy("pswvisitnotes-title").should("be.visible");
    cy.getCy("pswvisitnotes-content").should("be.visible");
    cy.screenshot("ci_psw_psw_visit_notes");

    // [11/14] - Screen: PswVitalsLogScreen (psw_vitals_log)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/observation-vitals-log (PswVitalsLogScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/observation-vitals-log");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pswvitalslog-screen").should("be.visible");
    cy.getCy("pswvitalslog-title").should("be.visible");
    cy.getCy("pswvitalslog-content").should("be.visible");
    cy.screenshot("ci_psw_psw_vitals_log");

    // [12/14] - Screen: ShiftTasksScreen (shift_tasks)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/shift-tasks (ShiftTasksScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/shift-tasks");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("shifttasks-screen").should("be.visible");
    cy.getCy("shifttasks-title").should("be.visible");
    cy.getCy("shifttasks-content").should("be.visible");
    cy.screenshot("ci_psw_shift_tasks");

    // [13/14] - Screen: VisitNotesScreen (visit_notes)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/visit-notes (VisitNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("visitnotes-screen").should("be.visible");
    cy.getCy("visitnotes-title").should("be.visible");
    cy.getCy("visitnotes-content").should("be.visible");
    cy.screenshot("ci_psw_visit_notes");

    // [14/14] - Screen: VitalsEntryScreen (vitals_entry)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/psw/vitals-entry (VitalsEntryScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/psw/vitals-entry");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("vitalsentry-screen").should("be.visible");
    cy.getCy("vitalsentry-title").should("be.visible");
    cy.getCy("vitalsentry-content").should("be.visible");
    cy.screenshot("ci_psw_vitals_entry");
  });

  it("verifies operation flow for role: LPN", () => {
    cy.loginAsRole("lpn");

    // [1/1] - Screen: LpnDashboardScreen (lpn_dashboard)
    cy.task("log", "PROGRESS: Visiting /clinical/lpn-dashboard (LpnDashboardScreen)...");
    cy.visitWithSemantics("/clinical/lpn-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("lpndashboard-screen").should("be.visible");
    cy.getCy("lpndashboard-title").should("be.visible");
    cy.getCy("lpndashboard-content").should("be.visible");
    cy.screenshot("ci_lpn_lpn_dashboard");
  });

  it("verifies operation flow for role: RPN", () => {
    cy.loginAsRole("rpn");

    // [1/13] - Screen: MedicationScreen (medication)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/medication (MedicationScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/medication");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("medication-screen").should("be.visible");
    cy.getCy("medication-title").should("be.visible");
    cy.getCy("medication-content").should("be.visible");
    cy.screenshot("ci_rpn_medication");

    // [2/13] - Screen: NursingTaskScreen (nursing_task)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/nursing-task (NursingTaskScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/nursing-task");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("nursingtask-screen").should("be.visible");
    cy.getCy("nursingtask-title").should("be.visible");
    cy.getCy("nursingtask-content").should("be.visible");
    cy.screenshot("ci_rpn_nursing_task");

    // [3/13] - Screen: PatientObservationScreen (patient_observation)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/patient-observation (PatientObservationScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-observation");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("patientobservation-screen").should("be.visible");
    cy.getCy("patientobservation-title").should("be.visible");
    cy.getCy("patientobservation-content").should("be.visible");
    cy.screenshot("ci_rpn_patient_observation");

    // [4/13] - Screen: RpnCarePlanReviewScreen (rpn_care_plan_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/rpn-care-plan-review (RpnCarePlanReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-care-plan-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpncareplanreview-screen").should("be.visible");
    cy.getCy("rpncareplanreview-title").should("be.visible");
    cy.getCy("rpncareplanreview-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_care_plan_review");

    // [5/13] - Screen: RpnCommandCenterScreen (rpn_command_center)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/rpn-command-center (RpnCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpncommandcenter-screen").should("be.visible");
    cy.getCy("rpncommandcenter-title").should("be.visible");
    cy.getCy("rpncommandcenter-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_command_center");

    // [6/13] - Screen: RpnDashboardScreen (rpn_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpndashboard-screen").should("be.visible");
    cy.getCy("rpndashboard-title").should("be.visible");
    cy.getCy("rpndashboard-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_dashboard");

    // [7/13] - Screen: RpnIncidentReviewScreen (rpn_incident_review)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/rpn-incident-review (RpnIncidentReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-incident-review");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpnincidentreview-screen").should("be.visible");
    cy.getCy("rpnincidentreview-title").should("be.visible");
    cy.getCy("rpnincidentreview-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_incident_review");

    // [8/13] - Screen: RpnMedicationsScreen (rpn_medications)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/medications (RpnMedicationsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/medications");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpnmedications-screen").should("be.visible");
    cy.getCy("rpnmedications-title").should("be.visible");
    cy.getCy("rpnmedications-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_medications");

    // [9/13] - Screen: RpnPatientChartingScreen (rpn_patient_charting)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/patient-charting (RpnPatientChartingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-charting");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpnpatientcharting-screen").should("be.visible");
    cy.getCy("rpnpatientcharting-title").should("be.visible");
    cy.getCy("rpnpatientcharting-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_patient_charting");

    // [10/13] - Screen: RpnReportsScreen (rpn_reports)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/rpn-reports (RpnReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-reports");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpnreports-screen").should("be.visible");
    cy.getCy("rpnreports-title").should("be.visible");
    cy.getCy("rpnreports-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_reports");

    // [11/13] - Screen: RpnTasksScreen (rpn_tasks)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/rpn-tasks (RpnTasksScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-tasks");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpntasks-screen").should("be.visible");
    cy.getCy("rpntasks-title").should("be.visible");
    cy.getCy("rpntasks-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_tasks");

    // [12/13] - Screen: RpnVitalsScreen (rpn_vitals)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/vitals (RpnVitalsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rpnvitals-screen").should("be.visible");
    cy.getCy("rpnvitals-title").should("be.visible");
    cy.getCy("rpnvitals-content").should("be.visible");
    cy.screenshot("ci_rpn_rpn_vitals");

    // [13/13] - Screen: VitalsTrackingScreen (vitals_tracking)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rpn/vitals-tracking (VitalsTrackingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals-tracking");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("vitalstracking-screen").should("be.visible");
    cy.getCy("vitalstracking-title").should("be.visible");
    cy.getCy("vitalstracking-content").should("be.visible");
    cy.screenshot("ci_rpn_vitals_tracking");
  });

  it("verifies operation flow for role: NP", () => {
    cy.loginAsRole("np");

    // [1/1] - Screen: NpDashboardScreen (np_dashboard)
    cy.task("log", "PROGRESS: Visiting /clinical/np-dashboard (NpDashboardScreen)...");
    cy.visitWithSemantics("/clinical/np-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("npdashboard-screen").should("be.visible");
    cy.getCy("npdashboard-title").should("be.visible");
    cy.getCy("npdashboard-content").should("be.visible");
    cy.screenshot("ci_np_np_dashboard");
  });

  it("verifies operation flow for role: PEDIATRIC", () => {
    cy.loginAsRole("pediatric");

    // [1/1] - Screen: PediatricDashboardScreen (pediatric_dashboard)
    cy.task("log", "PROGRESS: Visiting /clinical/pediatric-dashboard (PediatricDashboardScreen)...");
    cy.visitWithSemantics("/clinical/pediatric-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("pediatricdashboard-screen").should("be.visible");
    cy.getCy("pediatricdashboard-title").should("be.visible");
    cy.getCy("pediatricdashboard-content").should("be.visible");
    cy.screenshot("ci_pediatric_pediatric_dashboard");
  });

  it("verifies operation flow for role: PHYSICIAN", () => {
    cy.loginAsRole("physician");

    // [1/1] - Screen: PhysicianDashboardScreen (physician_dashboard)
    cy.task("log", "PROGRESS: Visiting /clinical/physician-dashboard (PhysicianDashboardScreen)...");
    cy.visitWithSemantics("/clinical/physician-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("physiciandashboard-screen").should("be.visible");
    cy.getCy("physiciandashboard-title").should("be.visible");
    cy.getCy("physiciandashboard-content").should("be.visible");
    cy.screenshot("ci_physician_physician_dashboard");
  });

  it("verifies operation flow for role: RMT", () => {
    cy.loginAsRole("rmt");

    // [1/9] - Screen: RmtAppointmentsScreen (rmt_appointments)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/appointments (RmtAppointmentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/appointments");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtappointments-screen").should("be.visible");
    cy.getCy("rmtappointments-title").should("be.visible");
    cy.getCy("rmtappointments-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_appointments");

    // [2/9] - Screen: RmtAssessmentScreen (rmt_assessment)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/assessment (RmtAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/assessment");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtassessment-screen").should("be.visible");
    cy.getCy("rmtassessment-title").should("be.visible");
    cy.getCy("rmtassessment-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_assessment");

    // [3/9] - Screen: RmtBillingLinkScreen (rmt_billing_link)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/billing-link (RmtBillingLinkScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/billing-link");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtbillinglink-screen").should("be.visible");
    cy.getCy("rmtbillinglink-title").should("be.visible");
    cy.getCy("rmtbillinglink-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_billing_link");

    // [4/9] - Screen: RmtClientIntakeScreen (rmt_client_intake)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/client-intake (RmtClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/client-intake");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtclientintake-screen").should("be.visible");
    cy.getCy("rmtclientintake-title").should("be.visible");
    cy.getCy("rmtclientintake-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_client_intake");

    // [5/9] - Screen: RmtCommandCenterScreen (rmt_command_center)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/command-center (RmtCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtcommandcenter-screen").should("be.visible");
    cy.getCy("rmtcommandcenter-title").should("be.visible");
    cy.getCy("rmtcommandcenter-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_command_center");

    // [6/9] - Screen: RmtDashboardScreen (rmt_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/dashboard (RmtDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtdashboard-screen").should("be.visible");
    cy.getCy("rmtdashboard-title").should("be.visible");
    cy.getCy("rmtdashboard-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_dashboard");

    // [7/9] - Screen: RmtExercisePlanScreen (rmt_exercise_plan)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/exercise-plan (RmtExercisePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/exercise-plan");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtexerciseplan-screen").should("be.visible");
    cy.getCy("rmtexerciseplan-title").should("be.visible");
    cy.getCy("rmtexerciseplan-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_exercise_plan");

    // [8/9] - Screen: RmtReportsScreen (rmt_reports)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/reports (RmtReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/reports");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmtreports-screen").should("be.visible");
    cy.getCy("rmtreports-title").should("be.visible");
    cy.getCy("rmtreports-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_reports");

    // [9/9] - Screen: RmtTreatmentNotesScreen (rmt_treatment_notes)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/rmt/treatment-notes (RmtTreatmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/treatment-notes");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rmttreatmentnotes-screen").should("be.visible");
    cy.getCy("rmttreatmentnotes-title").should("be.visible");
    cy.getCy("rmttreatmentnotes-content").should("be.visible");
    cy.screenshot("ci_rmt_rmt_treatment_notes");
  });

  it("verifies operation flow for role: RN_FIELD_SUPERVISOR", () => {
    cy.loginAsRole("rn_field_supervisor");

    // [1/1] - Screen: RnFieldSupervisorDashboardScreen (rn_field_supervisor_dashboard)
    cy.task("log", "PROGRESS: Visiting /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
    cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
    cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
    cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");
    cy.screenshot("ci_rn_field_supervisor_rn_field_supervisor_dashboard");
  });

  it("verifies operation flow for role: SOCIAL_WORKER", () => {
    cy.loginAsRole("social_worker");

    // [1/1] - Screen: SocialWorkerDashboardScreen (social_worker_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/social_worker/dashboard (SocialWorkerDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/social_worker/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("socialworkerdashboard-screen").should("be.visible");
    cy.getCy("socialworkerdashboard-title").should("be.visible");
    cy.getCy("socialworkerdashboard-content").should("be.visible");
    cy.screenshot("ci_social_worker_social_worker_dashboard");
  });

  it("verifies operation flow for role: THERAPIST", () => {
    cy.loginAsRole("therapist");

    // [1/1] - Screen: TherapistDashboardScreen (therapist_dashboard)
    cy.task("log", "PROGRESS: Visiting /offices/clinical/roles/therapist/dashboard (TherapistDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/therapist/dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("therapistdashboard-screen").should("be.visible");
    cy.getCy("therapistdashboard-title").should("be.visible");
    cy.getCy("therapistdashboard-content").should("be.visible");
    cy.screenshot("ci_therapist_therapist_dashboard");
  });
});
