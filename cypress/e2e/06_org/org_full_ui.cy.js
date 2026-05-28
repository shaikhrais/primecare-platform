// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Org Full UI Test", () => {

  it("tests org role chiropractor", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/common/chiropractor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  cy.getCy("chiropractordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");

  cy.visitWithSemantics("/common/chiropractor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractoranalytics-screen").should("be.visible");
  cy.getCy("chiropractoranalytics-title").should("be.visible");
  cy.getCy("chiropractoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_analytics");

  cy.visitWithSemantics("/common/chiropractor-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcompliance-screen").should("be.visible");
  cy.getCy("chiropractorcompliance-title").should("be.visible");
  cy.getCy("chiropractorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_compliance");

  cy.visitWithSemantics("/common/chiropractor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorworkflow-screen").should("be.visible");
  cy.getCy("chiropractorworkflow-title").should("be.visible");
  cy.getCy("chiropractorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_workflow");

  cy.visitWithSemantics("/allied/chiropractor-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
  cy.getCy("chiropractorcommandcenter-title").should("be.visible");
  cy.getCy("chiropractorcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_command_center");

  cy.visitWithSemantics("/allied/chiropractor-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorappointments-screen").should("be.visible");
  cy.getCy("chiropractorappointments-title").should("be.visible");
  cy.getCy("chiropractorappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_appointments");

  cy.visitWithSemantics("/allied/chiropractor-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorclientintake-screen").should("be.visible");
  cy.getCy("chiropractorclientintake-title").should("be.visible");
  cy.getCy("chiropractorclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_client_intake");

  cy.visitWithSemantics("/allied/chiropractor-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorassessment-screen").should("be.visible");
  cy.getCy("chiropractorassessment-title").should("be.visible");
  cy.getCy("chiropractorassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_assessment");

  cy.visitWithSemantics("/allied/chiropractor-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_treatment_notes");

  cy.visitWithSemantics("/allied/chiropractor-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
  cy.getCy("chiropractorexerciseplan-title").should("be.visible");
  cy.getCy("chiropractorexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_exercise_plan");

  cy.visitWithSemantics("/allied/chiropractor-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorbillinglink-screen").should("be.visible");
  cy.getCy("chiropractorbillinglink-title").should("be.visible");
  cy.getCy("chiropractorbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_billing_link");

  cy.visitWithSemantics("/allied/chiropractor-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorreports-screen").should("be.visible");
  cy.getCy("chiropractorreports-title").should("be.visible");
  cy.getCy("chiropractorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_reports");

  cy.visitWithSemantics("/allied/chiropractic-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticassessment-screen").should("be.visible");
  cy.getCy("chiropracticassessment-title").should("be.visible");
  cy.getCy("chiropracticassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_assessment");

  cy.visitWithSemantics("/allied/adjustment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adjustmentnotes-screen").should("be.visible");
  cy.getCy("adjustmentnotes-title").should("be.visible");
  cy.getCy("adjustmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("adjustment_notes");

  cy.visitWithSemantics("/allied/xray-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("xrayreview-screen").should("be.visible");
  cy.getCy("xrayreview-title").should("be.visible");
  cy.getCy("xrayreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("xray_review");

  cy.visitWithSemantics("/allied/chiropractic-progress-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
  cy.getCy("chiropracticprogresstracking-title").should("be.visible");
  cy.getCy("chiropracticprogresstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_progress_tracking");
  });

  it("tests org role physio", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/common/physiotherapist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistdashboard-screen").should("be.visible");
  cy.getCy("physiotherapistdashboard-title").should("be.visible");
  cy.getCy("physiotherapistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_dashboard");

  cy.visitWithSemantics("/common/physiotherapist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistanalytics-screen").should("be.visible");
  cy.getCy("physiotherapistanalytics-title").should("be.visible");
  cy.getCy("physiotherapistanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_analytics");

  cy.visitWithSemantics("/common/physiotherapist-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcompliance-screen").should("be.visible");
  cy.getCy("physiotherapistcompliance-title").should("be.visible");
  cy.getCy("physiotherapistcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_compliance");

  cy.visitWithSemantics("/common/physiotherapist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistworkflow-screen").should("be.visible");
  cy.getCy("physiotherapistworkflow-title").should("be.visible");
  cy.getCy("physiotherapistworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_workflow");

  cy.visitWithSemantics("/allied/physiotherapist-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_command_center");

  cy.visitWithSemantics("/allied/physiotherapist-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistappointments-screen").should("be.visible");
  cy.getCy("physiotherapistappointments-title").should("be.visible");
  cy.getCy("physiotherapistappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_appointments");

  cy.visitWithSemantics("/allied/physiotherapist-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistclientintake-screen").should("be.visible");
  cy.getCy("physiotherapistclientintake-title").should("be.visible");
  cy.getCy("physiotherapistclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_client_intake");

  cy.visitWithSemantics("/allied/physiotherapist-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistassessment-screen").should("be.visible");
  cy.getCy("physiotherapistassessment-title").should("be.visible");
  cy.getCy("physiotherapistassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_assessment");

  cy.visitWithSemantics("/allied/physiotherapist-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_treatment_notes");

  cy.visitWithSemantics("/allied/physiotherapist-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_exercise_plan");

  cy.visitWithSemantics("/allied/physiotherapist-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
  cy.getCy("physiotherapistbillinglink-title").should("be.visible");
  cy.getCy("physiotherapistbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_billing_link");

  cy.visitWithSemantics("/allied/physiotherapist-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistreports-screen").should("be.visible");
  cy.getCy("physiotherapistreports-title").should("be.visible");
  cy.getCy("physiotherapistreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_reports");

  cy.visitWithSemantics("/clinical/assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("assessment-screen").should("be.visible");
  cy.getCy("assessment-title").should("be.visible");
  cy.getCy("assessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("assessment");

  cy.visitWithSemantics("/clinical/treatment-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentplan-screen").should("be.visible");
  cy.getCy("treatmentplan-title").should("be.visible");
  cy.getCy("treatmentplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("treatment_plan");

  cy.visitWithSemantics("/clinical/exercise-prescription");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("exerciseprescription-screen").should("be.visible");
  cy.getCy("exerciseprescription-title").should("be.visible");
  cy.getCy("exerciseprescription-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("exercise_prescription");

  cy.visitWithSemantics("/clinical/progress-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("progresstracking-screen").should("be.visible");
  cy.getCy("progresstracking-title").should("be.visible");
  cy.getCy("progresstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("progress_tracking");
  });

  it("tests org role rmt", () => {
    cy.loginAsRole("rmt");

  cy.visitWithSemantics("/allied/rmt-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtdashboard-screen").should("be.visible");
  cy.getCy("rmtdashboard-title").should("be.visible");
  cy.getCy("rmtdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_dashboard");

  cy.visitWithSemantics("/allied/rmt-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtanalytics-screen").should("be.visible");
  cy.getCy("rmtanalytics-title").should("be.visible");
  cy.getCy("rmtanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_analytics");

  cy.visitWithSemantics("/allied/rmt-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcompliance-screen").should("be.visible");
  cy.getCy("rmtcompliance-title").should("be.visible");
  cy.getCy("rmtcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_compliance");

  cy.visitWithSemantics("/allied/rmt-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtworkflow-screen").should("be.visible");
  cy.getCy("rmtworkflow-title").should("be.visible");
  cy.getCy("rmtworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_workflow");

  cy.visitWithSemantics("/allied/rmt-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcommandcenter-screen").should("be.visible");
  cy.getCy("rmtcommandcenter-title").should("be.visible");
  cy.getCy("rmtcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_command_center");

  cy.visitWithSemantics("/allied/rmt-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtappointments-screen").should("be.visible");
  cy.getCy("rmtappointments-title").should("be.visible");
  cy.getCy("rmtappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_appointments");

  cy.visitWithSemantics("/allied/rmt-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtclientintake-screen").should("be.visible");
  cy.getCy("rmtclientintake-title").should("be.visible");
  cy.getCy("rmtclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_client_intake");

  cy.visitWithSemantics("/allied/rmt-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtassessment-screen").should("be.visible");
  cy.getCy("rmtassessment-title").should("be.visible");
  cy.getCy("rmtassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_assessment");

  cy.visitWithSemantics("/allied/rmt-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmttreatmentnotes-screen").should("be.visible");
  cy.getCy("rmttreatmentnotes-title").should("be.visible");
  cy.getCy("rmttreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_treatment_notes");

  cy.visitWithSemantics("/allied/rmt-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtexerciseplan-screen").should("be.visible");
  cy.getCy("rmtexerciseplan-title").should("be.visible");
  cy.getCy("rmtexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_exercise_plan");

  cy.visitWithSemantics("/allied/rmt-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtbillinglink-screen").should("be.visible");
  cy.getCy("rmtbillinglink-title").should("be.visible");
  cy.getCy("rmtbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_billing_link");

  cy.visitWithSemantics("/allied/rmt-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtreports-screen").should("be.visible");
  cy.getCy("rmtreports-title").should("be.visible");
  cy.getCy("rmtreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_reports");

  cy.visitWithSemantics("/allied/massage-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("massageassessment-screen").should("be.visible");
  cy.getCy("massageassessment-title").should("be.visible");
  cy.getCy("massageassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("massage_assessment");

  cy.visitWithSemantics("/allied/treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentnotes-screen").should("be.visible");
  cy.getCy("treatmentnotes-title").should("be.visible");
  cy.getCy("treatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("treatment_notes");

  cy.visitWithSemantics("/allied/home-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("homecareplan-screen").should("be.visible");
  cy.getCy("homecareplan-title").should("be.visible");
  cy.getCy("homecareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("home_care_plan");

  cy.visitWithSemantics("/allied/client-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientprogress-screen").should("be.visible");
  cy.getCy("clientprogress-title").should("be.visible");
  cy.getCy("clientprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_progress");
  });

  it("tests org role social_worker", () => {
    cy.loginAsRole("social_worker");

  cy.visitWithSemantics("/common/social-worker-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerdashboard-screen").should("be.visible");
  cy.getCy("socialworkerdashboard-title").should("be.visible");
  cy.getCy("socialworkerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_dashboard");

  cy.visitWithSemantics("/common/social-worker-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkeranalytics-screen").should("be.visible");
  cy.getCy("socialworkeranalytics-title").should("be.visible");
  cy.getCy("socialworkeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_analytics");

  cy.visitWithSemantics("/common/social-worker-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkercompliance-screen").should("be.visible");
  cy.getCy("socialworkercompliance-title").should("be.visible");
  cy.getCy("socialworkercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_compliance");

  cy.visitWithSemantics("/common/social-worker-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerworkflow-screen").should("be.visible");
  cy.getCy("socialworkerworkflow-title").should("be.visible");
  cy.getCy("socialworkerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_workflow");
  });

  it("tests org role therapist", () => {
    cy.loginAsRole("therapist");

  cy.visitWithSemantics("/allied/therapist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistdashboard-screen").should("be.visible");
  cy.getCy("therapistdashboard-title").should("be.visible");
  cy.getCy("therapistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_dashboard");

  cy.visitWithSemantics("/allied/therapist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapist analytics-screen").should("be.visible");
  cy.getCy("therapist analytics-title").should("be.visible");
  cy.getCy("therapist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_analytics");

  cy.visitWithSemantics("/allied/therapist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapist compliance workflow-screen").should("be.visible");
  cy.getCy("therapist compliance workflow-title").should("be.visible");
  cy.getCy("therapist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_workflow");
  });

  it("tests org role clinical_director", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/clinical/clinical-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldashboard-screen").should("be.visible");
  cy.getCy("clinicaldashboard-title").should("be.visible");
  cy.getCy("clinicaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_dashboard");

  cy.visitWithSemantics("/common/clinic-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");

  cy.visitWithSemantics("/clinical/clinical-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalanalytics-screen").should("be.visible");
  cy.getCy("clinicalanalytics-title").should("be.visible");
  cy.getCy("clinicalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_analytics");

  cy.visitWithSemantics("/clinical/clinical-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalcompliance-screen").should("be.visible");
  cy.getCy("clinicalcompliance-title").should("be.visible");
  cy.getCy("clinicalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_compliance");

  cy.visitWithSemantics("/clinical/clinical-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalworkflow-screen").should("be.visible");
  cy.getCy("clinicalworkflow-title").should("be.visible");
  cy.getCy("clinicalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_workflow");

  cy.visitWithSemantics("/common/clinic-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicanalytics-screen").should("be.visible");
  cy.getCy("clinicanalytics-title").should("be.visible");
  cy.getCy("clinicanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_analytics");

  cy.visitWithSemantics("/common/clinic-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cliniccompliance-screen").should("be.visible");
  cy.getCy("cliniccompliance-title").should("be.visible");
  cy.getCy("cliniccompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_compliance");

  cy.visitWithSemantics("/common/clinic-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicworkflow-screen").should("be.visible");
  cy.getCy("clinicworkflow-title").should("be.visible");
  cy.getCy("clinicworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_workflow");

  cy.visitWithSemantics("/clinical/clinical-director-staff-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-title").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_staff_quality");

  cy.visitWithSemantics("/clinical/clinical-director-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-title").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_incident_review");

  cy.visitWithSemantics("/clinical/clinical-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");

  cy.visitWithSemantics("/clinical/clinical-director-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorreports-screen").should("be.visible");
  cy.getCy("clinicaldirectorreports-title").should("be.visible");
  cy.getCy("clinicaldirectorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");

  cy.visitWithSemantics("/clinical/clinical-director-approvals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorapprovals-screen").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-title").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_approvals");

  cy.visitWithSemantics("/clinical/clinical-director-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorperformance-screen").should("be.visible");
  cy.getCy("clinicaldirectorperformance-title").should("be.visible");
  cy.getCy("clinicaldirectorperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_performance");

  cy.visitWithSemantics("/clinical/clinical-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalquality-screen").should("be.visible");
  cy.getCy("clinicalquality-title").should("be.visible");
  cy.getCy("clinicalquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_quality");

  cy.visitWithSemantics("/clinical/staff-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffperformance-screen").should("be.visible");
  cy.getCy("staffperformance-title").should("be.visible");
  cy.getCy("staffperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_performance");

  cy.visitWithSemantics("/clinical/compliance-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereview-screen").should("be.visible");
  cy.getCy("compliancereview-title").should("be.visible");
  cy.getCy("compliancereview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_review");

  cy.visitWithSemantics("/clinical/incident-oversight");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentoversight-screen").should("be.visible");
  cy.getCy("incidentoversight-title").should("be.visible");
  cy.getCy("incidentoversight-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_oversight");

  cy.visitWithSemantics("/clinical/clinical-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloperations4k-screen").should("be.visible");
  cy.getCy("clinicaloperations4k-title").should("be.visible");
  cy.getCy("clinicaloperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");
  });

  it("tests org role intake", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/common/intake-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakedashboard-screen").should("be.visible");
  cy.getCy("intakedashboard-title").should("be.visible");
  cy.getCy("intakedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_dashboard");

  cy.visitWithSemantics("/staff/intake-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
  cy.getCy("intakecoordinatordashboard-title").should("be.visible");
  cy.getCy("intakecoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");

  cy.visitWithSemantics("/common/intake-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeanalytics-screen").should("be.visible");
  cy.getCy("intakeanalytics-title").should("be.visible");
  cy.getCy("intakeanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_analytics");

  cy.visitWithSemantics("/common/intake-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecompliance-screen").should("be.visible");
  cy.getCy("intakecompliance-title").should("be.visible");
  cy.getCy("intakecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_compliance");

  cy.visitWithSemantics("/common/intake-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeworkflow-screen").should("be.visible");
  cy.getCy("intakeworkflow-title").should("be.visible");
  cy.getCy("intakeworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_workflow");

  cy.visitWithSemantics("/staff/intake-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatoranalytics-screen").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-title").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_analytics");

  cy.visitWithSemantics("/staff/intake-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorcompliance-screen").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-title").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_compliance");

  cy.visitWithSemantics("/staff/intake-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorworkflow-screen").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-title").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_workflow");

  cy.visitWithSemantics("/executive/referral-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("referralmanagement-screen").should("be.visible");
  cy.getCy("referralmanagement-title").should("be.visible");
  cy.getCy("referralmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("referral_management");

  cy.visitWithSemantics("/executive/client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientintake-screen").should("be.visible");
  cy.getCy("clientintake-title").should("be.visible");
  cy.getCy("clientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_intake");

  cy.visitWithSemantics("/executive/booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("booking-screen").should("be.visible");
  cy.getCy("booking-title").should("be.visible");
  cy.getCy("booking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("booking");

  cy.visitWithSemantics("/executive/followup");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("followup-screen").should("be.visible");
  cy.getCy("followup-title").should("be.visible");
  cy.getCy("followup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("followup");
  });

  it("tests org role rn", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/common/system-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_dashboard");

  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");

  cy.visitWithSemantics("/rn/rn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rndashboard-screen").should("be.visible");
  cy.getCy("rndashboard-title").should("be.visible");
  cy.getCy("rndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_dashboard");

  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");

  cy.visitWithSemantics("/management/governance-officer-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");

  cy.visitWithSemantics("/management/governance-officer-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");

  cy.visitWithSemantics("/management/governance-officer-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");

  cy.visitWithSemantics("/rn/rn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnanalytics-screen").should("be.visible");
  cy.getCy("rnanalytics-title").should("be.visible");
  cy.getCy("rnanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_analytics");

  cy.visitWithSemantics("/rn/rn-assessments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnassessments-screen").should("be.visible");
  cy.getCy("rnassessments-title").should("be.visible");
  cy.getCy("rnassessments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_assessments");

  cy.visitWithSemantics("/rn/rn-care-plans");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplans-screen").should("be.visible");
  cy.getCy("rncareplans-title").should("be.visible");
  cy.getCy("rncareplans-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_care_plans");

  cy.visitWithSemantics("/rn/rn-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncompliance-screen").should("be.visible");
  cy.getCy("rncompliance-title").should("be.visible");
  cy.getCy("rncompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_compliance");

  cy.visitWithSemantics("/rn/rn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnworkflow-screen").should("be.visible");
  cy.getCy("rnworkflow-title").should("be.visible");
  cy.getCy("rnworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_workflow");

  cy.visitWithSemantics("/rn/rn-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncommandcenter-screen").should("be.visible");
  cy.getCy("rncommandcenter-title").should("be.visible");
  cy.getCy("rncommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_command_center");

  cy.visitWithSemantics("/rn/rn-patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnpatientcharting-screen").should("be.visible");
  cy.getCy("rnpatientcharting-title").should("be.visible");
  cy.getCy("rnpatientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_patient_charting");

  cy.visitWithSemantics("/rn/rn-medications");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnmedications-screen").should("be.visible");
  cy.getCy("rnmedications-title").should("be.visible");
  cy.getCy("rnmedications-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_medications");

  cy.visitWithSemantics("/rn/rn-vitals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnvitals-screen").should("be.visible");
  cy.getCy("rnvitals-title").should("be.visible");
  cy.getCy("rnvitals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_vitals");

  cy.visitWithSemantics("/rn/rn-care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplanreview-screen").should("be.visible");
  cy.getCy("rncareplanreview-title").should("be.visible");
  cy.getCy("rncareplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_care_plan_review");

  cy.visitWithSemantics("/rn/rn-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnincidentreview-screen").should("be.visible");
  cy.getCy("rnincidentreview-title").should("be.visible");
  cy.getCy("rnincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_incident_review");

  cy.visitWithSemantics("/rn/rn-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rntasks-screen").should("be.visible");
  cy.getCy("rntasks-title").should("be.visible");
  cy.getCy("rntasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_tasks");

  cy.visitWithSemantics("/rn/rn-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnreports-screen").should("be.visible");
  cy.getCy("rnreports-title").should("be.visible");
  cy.getCy("rnreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_reports");

  cy.visitWithSemantics("/rn/patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcharting-screen").should("be.visible");
  cy.getCy("patientcharting-title").should("be.visible");
  cy.getCy("patientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_charting");

  cy.visitWithSemantics("/rn/medication-administration");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medicationadministration-screen").should("be.visible");
  cy.getCy("medicationadministration-title").should("be.visible");
  cy.getCy("medicationadministration-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("medication_administration");

  cy.visitWithSemantics("/rn/care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplanreview-screen").should("be.visible");
  cy.getCy("careplanreview-title").should("be.visible");
  cy.getCy("careplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_plan_review");

  cy.visitWithSemantics("/rn/incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreview-screen").should("be.visible");
  cy.getCy("incidentreview-title").should("be.visible");
  cy.getCy("incidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_review");

  cy.visitWithSemantics("/rn/shift-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shiftreport-screen").should("be.visible");
  cy.getCy("shiftreport-title").should("be.visible");
  cy.getCy("shiftreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shift_report");

  cy.visitWithSemantics("/common/governance-control-room");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancecontrolroom-screen").should("be.visible");
  cy.getCy("governancecontrolroom-title").should("be.visible");
  cy.getCy("governancecontrolroom-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_control_room");

  cy.visitWithSemantics("/common/runtime-verification");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("runtimeverification-screen").should("be.visible");
  cy.getCy("runtimeverification-title").should("be.visible");
  cy.getCy("runtimeverification-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("runtime_verification");

  cy.visitWithSemantics("/common/drift-findings");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("drift_findings");

  cy.visitWithSemantics("/common/pending-task-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pending_task_queue");

  cy.visitWithSemantics("/common/agent-dispatch");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("agent_dispatch");

  cy.visitWithSemantics("/common/audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit");

  cy.visitWithSemantics("/common/api-health-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");

  cy.visitWithSemantics("/common/release-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releaseoperations-screen").should("be.visible");
  cy.getCy("releaseoperations-title").should("be.visible");
  cy.getCy("releaseoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("release_operations");

  cy.visitWithSemantics("/common/file-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");

  cy.visitWithSemantics("/common/role-coverage-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");

  cy.visitWithSemantics("/common/responsive-preview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("responsive_preview");

  cy.visitWithSemantics("/common/workflow-execution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_execution");

  cy.visitWithSemantics("/common/governance-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceoperations4k-screen").should("be.visible");
  cy.getCy("governanceoperations4k-title").should("be.visible");
  cy.getCy("governanceoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_operations4_k");

  cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor analytics-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");

  cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor compliance workflow-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");
  });

  it("tests org role physician", () => {
    cy.loginAsRole("physician");

  cy.visitWithSemantics("/clinical/physician-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciandashboard-screen").should("be.visible");
  cy.getCy("physiciandashboard-title").should("be.visible");
  cy.getCy("physiciandashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_dashboard");

  cy.visitWithSemantics("/clinical/physician-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physician analytics-screen").should("be.visible");
  cy.getCy("physician analytics-title").should("be.visible");
  cy.getCy("physician analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_analytics");

  cy.visitWithSemantics("/clinical/physician-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physician compliance workflow-screen").should("be.visible");
  cy.getCy("physician compliance workflow-title").should("be.visible");
  cy.getCy("physician compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_workflow");
  });

  it("tests org role cns", () => {
    cy.loginAsRole("cns");

  cy.visitWithSemantics("/clinical/cns-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsdashboard-screen").should("be.visible");
  cy.getCy("cnsdashboard-title").should("be.visible");
  cy.getCy("cnsdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_dashboard");

  cy.visitWithSemantics("/rn/cns-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinical nurse specialist analytics-screen").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-title").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_analytics");

  cy.visitWithSemantics("/rn/cns-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinical nurse specialist compliance workflow-screen").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-title").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_workflow");
  });

  it("tests org role pediatric", () => {
    cy.loginAsRole("pediatric");

  cy.visitWithSemantics("/clinical/pediatric-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricdashboard-screen").should("be.visible");
  cy.getCy("pediatricdashboard-title").should("be.visible");
  cy.getCy("pediatricdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_dashboard");

  cy.visitWithSemantics("/clinical/pediatric-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatric specialist analytics-screen").should("be.visible");
  cy.getCy("pediatric specialist analytics-title").should("be.visible");
  cy.getCy("pediatric specialist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_analytics");

  cy.visitWithSemantics("/clinical/pediatric-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatric specialist compliance workflow-screen").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-title").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_workflow");
  });

  it("tests org role caregiver", () => {
    cy.loginAsRole("caregiver");

  cy.visitWithSemantics("/common/caregiver-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverdashboard-screen").should("be.visible");
  cy.getCy("caregiverdashboard-title").should("be.visible");
  cy.getCy("caregiverdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_dashboard");

  cy.visitWithSemantics("/psw/caregiver-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivertasks-screen").should("be.visible");
  cy.getCy("caregivertasks-title").should("be.visible");
  cy.getCy("caregivertasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_tasks");

  cy.visitWithSemantics("/psw/caregiver-client-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverclientprofile-screen").should("be.visible");
  cy.getCy("caregiverclientprofile-title").should("be.visible");
  cy.getCy("caregiverclientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_client_profile");

  cy.visitWithSemantics("/psw/caregiver-visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivervisitnotes-screen").should("be.visible");
  cy.getCy("caregivervisitnotes-title").should("be.visible");
  cy.getCy("caregivervisitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_visit_notes");

  cy.visitWithSemantics("/psw/caregiver-schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverschedule-screen").should("be.visible");
  cy.getCy("caregiverschedule-title").should("be.visible");
  cy.getCy("caregiverschedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_schedule");

  cy.visitWithSemantics("/psw/caregiver-incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverincidentreport-screen").should("be.visible");
  cy.getCy("caregiverincidentreport-title").should("be.visible");
  cy.getCy("caregiverincidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_incident_report");

  cy.visitWithSemantics("/psw/schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedule-screen").should("be.visible");
  cy.getCy("schedule-title").should("be.visible");
  cy.getCy("schedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("schedule");

  cy.visitWithSemantics("/psw/messaging");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("messaging-screen").should("be.visible");
  cy.getCy("messaging-title").should("be.visible");
  cy.getCy("messaging-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("messaging");
  });

  it("tests org role guest", () => {
    cy.loginAsRole("guest");

  cy.visitWithSemantics("/common/dynamic-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicdashboard-screen").should("be.visible");
  cy.getCy("dynamicdashboard-title").should("be.visible");
  cy.getCy("dynamicdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_screen_dashboard");

  cy.visitWithSemantics("/common/guest-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestdashboard-screen").should("be.visible");
  cy.getCy("guestdashboard-title").should("be.visible");
  cy.getCy("guestdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_dashboard");

  cy.visitWithSemantics("/common/guest-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestanalytics-screen").should("be.visible");
  cy.getCy("guestanalytics-title").should("be.visible");
  cy.getCy("guestanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_analytics");

  cy.visitWithSemantics("/common/guest-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestcompliance-screen").should("be.visible");
  cy.getCy("guestcompliance-title").should("be.visible");
  cy.getCy("guestcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_compliance");

  cy.visitWithSemantics("/common/guest-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestworkflow-screen").should("be.visible");
  cy.getCy("guestworkflow-title").should("be.visible");
  cy.getCy("guestworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_workflow");
  });

  it("tests org role portal", () => {
    cy.loginAsRole("portal");

  cy.visitWithSemantics("/common/portal-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portaldashboard-screen").should("be.visible");
  cy.getCy("portaldashboard-title").should("be.visible");
  cy.getCy("portaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_dashboard");

  cy.visitWithSemantics("/common/portal-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalanalytics-screen").should("be.visible");
  cy.getCy("portalanalytics-title").should("be.visible");
  cy.getCy("portalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_analytics");

  cy.visitWithSemantics("/common/portal-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalcompliance-screen").should("be.visible");
  cy.getCy("portalcompliance-title").should("be.visible");
  cy.getCy("portalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_compliance");

  cy.visitWithSemantics("/common/portal-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalworkflow-screen").should("be.visible");
  cy.getCy("portalworkflow-title").should("be.visible");
  cy.getCy("portalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_workflow");
  });

  it("tests org role patient", () => {
    cy.loginAsRole("patient");

  cy.visitWithSemantics("/common/family-member-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");

  cy.visitWithSemantics("/common/patient-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdashboard-screen").should("be.visible");
  cy.getCy("patientdashboard-title").should("be.visible");
  cy.getCy("patientdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_dashboard");

  cy.visitWithSemantics("/common/patient-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientanalytics-screen").should("be.visible");
  cy.getCy("patientanalytics-title").should("be.visible");
  cy.getCy("patientanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_analytics");

  cy.visitWithSemantics("/common/patient-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcompliance-screen").should("be.visible");
  cy.getCy("patientcompliance-title").should("be.visible");
  cy.getCy("patientcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_compliance");

  cy.visitWithSemantics("/common/patient-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientworkflow-screen").should("be.visible");
  cy.getCy("patientworkflow-title").should("be.visible");
  cy.getCy("patientworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_workflow");

  cy.visitWithSemantics("/common/patient-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcommandcenter-screen").should("be.visible");
  cy.getCy("patientcommandcenter-title").should("be.visible");
  cy.getCy("patientcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_command_center");

  cy.visitWithSemantics("/common/patient-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientappointments-screen").should("be.visible");
  cy.getCy("patientappointments-title").should("be.visible");
  cy.getCy("patientappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_appointments");

  cy.visitWithSemantics("/common/patient-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcareplan-screen").should("be.visible");
  cy.getCy("patientcareplan-title").should("be.visible");
  cy.getCy("patientcareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_care_plan");

  cy.visitWithSemantics("/common/patient-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientmessages-screen").should("be.visible");
  cy.getCy("patientmessages-title").should("be.visible");
  cy.getCy("patientmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_messages");

  cy.visitWithSemantics("/common/patient-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdocuments-screen").should("be.visible");
  cy.getCy("patientdocuments-title").should("be.visible");
  cy.getCy("patientdocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_documents");

  cy.visitWithSemantics("/common/patient-billing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientbilling-screen").should("be.visible");
  cy.getCy("patientbilling-title").should("be.visible");
  cy.getCy("patientbilling-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_billing");

  cy.visitWithSemantics("/common/patient-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientprofile-screen").should("be.visible");
  cy.getCy("patientprofile-title").should("be.visible");
  cy.getCy("patientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_profile");

  cy.visitWithSemantics("/common/appointment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointment-screen").should("be.visible");
  cy.getCy("appointment-title").should("be.visible");
  cy.getCy("appointment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("appointment");

  cy.visitWithSemantics("/common/care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplan-screen").should("be.visible");
  cy.getCy("careplan-title").should("be.visible");
  cy.getCy("careplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_plan");

  cy.visitWithSemantics("/common/billing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billing-screen").should("be.visible");
  cy.getCy("billing-title").should("be.visible");
  cy.getCy("billing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing");

  cy.visitWithSemantics("/common/documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("documents-screen").should("be.visible");
  cy.getCy("documents-title").should("be.visible");
  cy.getCy("documents-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("documents");
  });

  it("tests org role dynamic", () => {
    cy.loginAsRole("dynamic");

  cy.visitWithSemantics("/common/customer-support-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportdashboard-screen").should("be.visible");
  cy.getCy("customersupportdashboard-title").should("be.visible");
  cy.getCy("customersupportdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_dashboard");

  cy.visitWithSemantics("/common/support-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportdashboard-screen").should("be.visible");
  cy.getCy("supportdashboard-title").should("be.visible");
  cy.getCy("supportdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_dashboard");

  cy.visitWithSemantics("/common/dynamic-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicanalytics-screen").should("be.visible");
  cy.getCy("dynamicanalytics-title").should("be.visible");
  cy.getCy("dynamicanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_analytics");

  cy.visitWithSemantics("/common/dynamic-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamiccompliance-screen").should("be.visible");
  cy.getCy("dynamiccompliance-title").should("be.visible");
  cy.getCy("dynamiccompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_compliance");

  cy.visitWithSemantics("/common/dynamic-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicworkflow-screen").should("be.visible");
  cy.getCy("dynamicworkflow-title").should("be.visible");
  cy.getCy("dynamicworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_workflow");

  cy.visitWithSemantics("/common/shared-stubs");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("sharedstubs-screen").should("be.visible");
  cy.getCy("sharedstubs-title").should("be.visible");
  cy.getCy("sharedstubs-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shared_stubs");
  });

  it("tests org role infrastructure", () => {
    cy.loginAsRole("infrastructure");

  cy.visitWithSemantics("/common/infrastructure-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructuredashboard-screen").should("be.visible");
  cy.getCy("infrastructuredashboard-title").should("be.visible");
  cy.getCy("infrastructuredashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_dashboard");

  cy.visitWithSemantics("/common/architecture-planning-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanninganalytics-screen").should("be.visible");
  cy.getCy("architectureplanninganalytics-title").should("be.visible");
  cy.getCy("architectureplanninganalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_analytics");

  cy.visitWithSemantics("/common/architecture-planning-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningcompliance-screen").should("be.visible");
  cy.getCy("architectureplanningcompliance-title").should("be.visible");
  cy.getCy("architectureplanningcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_compliance");

  cy.visitWithSemantics("/common/architecture-planning-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningworkflow-screen").should("be.visible");
  cy.getCy("architectureplanningworkflow-title").should("be.visible");
  cy.getCy("architectureplanningworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_workflow");

  cy.visitWithSemantics("/common/infrastructure-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureanalytics-screen").should("be.visible");
  cy.getCy("infrastructureanalytics-title").should("be.visible");
  cy.getCy("infrastructureanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_analytics");

  cy.visitWithSemantics("/common/infrastructure-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructurecompliance-screen").should("be.visible");
  cy.getCy("infrastructurecompliance-title").should("be.visible");
  cy.getCy("infrastructurecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_compliance");

  cy.visitWithSemantics("/common/infrastructure-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureworkflow-screen").should("be.visible");
  cy.getCy("infrastructureworkflow-title").should("be.visible");
  cy.getCy("infrastructureworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_workflow");
  });

  it("tests org role system_verification", () => {
    cy.loginAsRole("system_verification");

  cy.visitWithSemantics("/common/qa-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qadashboard-screen").should("be.visible");
  cy.getCy("qadashboard-title").should("be.visible");
  cy.getCy("qadashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_dashboard");

  cy.visitWithSemantics("/common/system-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationdashboard-screen").should("be.visible");
  cy.getCy("systemverificationdashboard-title").should("be.visible");
  cy.getCy("systemverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_dashboard");

  cy.visitWithSemantics("/staff/quality-assurance-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancedashboard-screen").should("be.visible");
  cy.getCy("qualityassurancedashboard-title").should("be.visible");
  cy.getCy("qualityassurancedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_dashboard");

  cy.visitWithSemantics("/common/system-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemanalytics-screen").should("be.visible");
  cy.getCy("systemanalytics-title").should("be.visible");
  cy.getCy("systemanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_analytics");

  cy.visitWithSemantics("/common/system-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemcompliance-screen").should("be.visible");
  cy.getCy("systemcompliance-title").should("be.visible");
  cy.getCy("systemcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_compliance");

  cy.visitWithSemantics("/common/system-verification-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationanalytics-screen").should("be.visible");
  cy.getCy("systemverificationanalytics-title").should("be.visible");
  cy.getCy("systemverificationanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_analytics");

  cy.visitWithSemantics("/common/system-verification-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationcompliance-screen").should("be.visible");
  cy.getCy("systemverificationcompliance-title").should("be.visible");
  cy.getCy("systemverificationcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_compliance");

  cy.visitWithSemantics("/common/system-verification-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationworkflow-screen").should("be.visible");
  cy.getCy("systemverificationworkflow-title").should("be.visible");
  cy.getCy("systemverificationworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_workflow");

  cy.visitWithSemantics("/common/system-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemworkflow-screen").should("be.visible");
  cy.getCy("systemworkflow-title").should("be.visible");
  cy.getCy("systemworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_workflow");
  });

  it("tests org role training", () => {
    cy.loginAsRole("training");

  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");

  cy.visitWithSemantics("/common/training-hub-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubdashboard-screen").should("be.visible");
  cy.getCy("traininghubdashboard-title").should("be.visible");
  cy.getCy("traininghubdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_dashboard");

  cy.visitWithSemantics("/executive/training-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");

  cy.visitWithSemantics("/staff/training-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_dashboard");

  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");

  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");

  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");

  cy.visitWithSemantics("/common/training-hub-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubanalytics-screen").should("be.visible");
  cy.getCy("traininghubanalytics-title").should("be.visible");
  cy.getCy("traininghubanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_analytics");

  cy.visitWithSemantics("/common/training-hub-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubcompliance-screen").should("be.visible");
  cy.getCy("traininghubcompliance-title").should("be.visible");
  cy.getCy("traininghubcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_compliance");

  cy.visitWithSemantics("/common/training-hub-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubworkflow-screen").should("be.visible");
  cy.getCy("traininghubworkflow-title").should("be.visible");
  cy.getCy("traininghubworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_workflow");

  cy.visitWithSemantics("/executive/training-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectoranalytics-screen").should("be.visible");
  cy.getCy("trainingdirectoranalytics-title").should("be.visible");
  cy.getCy("trainingdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_analytics");

  cy.visitWithSemantics("/executive/training-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcompliance-screen").should("be.visible");
  cy.getCy("trainingdirectorcompliance-title").should("be.visible");
  cy.getCy("trainingdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_compliance");

  cy.visitWithSemantics("/executive/training-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorworkflow-screen").should("be.visible");
  cy.getCy("trainingdirectorworkflow-title").should("be.visible");
  cy.getCy("trainingdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_workflow");

  cy.visitWithSemantics("/staff/training-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatoranalytics-screen").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-title").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_analytics");

  cy.visitWithSemantics("/staff/training-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorcompliance-screen").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-title").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_compliance");

  cy.visitWithSemantics("/staff/training-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorworkflow-screen").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-title").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_workflow");

  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_dashboard");

  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_assignment");

  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("certification_tracking");

  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_progress");
  });

  it("tests org role ceo", () => {
    cy.loginAsRole("ceo");

  cy.visitWithSemantics("/executive/executive-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("executivecommandcenter-screen").should("be.visible");
  cy.getCy("executivecommandcenter-title").should("be.visible");
  cy.getCy("executivecommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("executive_command_center");

  cy.visitWithSemantics("/executive/enterprise-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisehealth-screen").should("be.visible");
  cy.getCy("enterprisehealth-title").should("be.visible");
  cy.getCy("enterprisehealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("enterprise_health");

  cy.visitWithSemantics("/executive/revenue-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenueanalytics-screen").should("be.visible");
  cy.getCy("revenueanalytics-title").should("be.visible");
  cy.getCy("revenueanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue_analytics");

  cy.visitWithSemantics("/executive/risk-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("riskmanagement-screen").should("be.visible");
  cy.getCy("riskmanagement-title").should("be.visible");
  cy.getCy("riskmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("risk_management");

  cy.visitWithSemantics("/executive/franchise-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseoverview-screen").should("be.visible");
  cy.getCy("franchiseoverview-title").should("be.visible");
  cy.getCy("franchiseoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_overview");

  cy.visitWithSemantics("/executive/enterprise-command-center4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisecommandcenter4k-screen").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-title").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("enterprise_command_center4_k");
  });

  it("tests org role cfo", () => {
    cy.loginAsRole("cfo");

  cy.visitWithSemantics("/executive/cfo-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfodashboard-screen").should("be.visible");
  cy.getCy("cfodashboard-title").should("be.visible");
  cy.getCy("cfodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_dashboard");

  cy.visitWithSemantics("/executive/cfo-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoanalytics-screen").should("be.visible");
  cy.getCy("cfoanalytics-title").should("be.visible");
  cy.getCy("cfoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_analytics");

  cy.visitWithSemantics("/executive/cfo-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocompliance-screen").should("be.visible");
  cy.getCy("cfocompliance-title").should("be.visible");
  cy.getCy("cfocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_compliance");

  cy.visitWithSemantics("/executive/cfo-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoworkflow-screen").should("be.visible");
  cy.getCy("cfoworkflow-title").should("be.visible");
  cy.getCy("cfoworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_workflow");

  cy.visitWithSemantics("/executive/cfo-revenue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cforevenue-screen").should("be.visible");
  cy.getCy("cforevenue-title").should("be.visible");
  cy.getCy("cforevenue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_revenue");

  cy.visitWithSemantics("/executive/cfo-expenses");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoexpenses-screen").should("be.visible");
  cy.getCy("cfoexpenses-title").should("be.visible");
  cy.getCy("cfoexpenses-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_expenses");

  cy.visitWithSemantics("/executive/cfo-payroll");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfopayroll-screen").should("be.visible");
  cy.getCy("cfopayroll-title").should("be.visible");
  cy.getCy("cfopayroll-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_payroll");

  cy.visitWithSemantics("/executive/cfo-invoices");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoinvoices-screen").should("be.visible");
  cy.getCy("cfoinvoices-title").should("be.visible");
  cy.getCy("cfoinvoices-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_invoices");

  cy.visitWithSemantics("/executive/cfo-tax");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfotax-screen").should("be.visible");
  cy.getCy("cfotax-title").should("be.visible");
  cy.getCy("cfotax-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_tax");

  cy.visitWithSemantics("/executive/cfo-profitability");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoprofitability-screen").should("be.visible");
  cy.getCy("cfoprofitability-title").should("be.visible");
  cy.getCy("cfoprofitability-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_profitability");

  cy.visitWithSemantics("/executive/cfo-cashflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocashflow-screen").should("be.visible");
  cy.getCy("cfocashflow-title").should("be.visible");
  cy.getCy("cfocashflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_cashflow");

  cy.visitWithSemantics("/executive/financial-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialdashboard-screen").should("be.visible");
  cy.getCy("financialdashboard-title").should("be.visible");
  cy.getCy("financialdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("financial_dashboard");

  cy.visitWithSemantics("/executive/revenue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenue-screen").should("be.visible");
  cy.getCy("revenue-title").should("be.visible");
  cy.getCy("revenue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue");

  cy.visitWithSemantics("/executive/expense-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("expensemanagement-screen").should("be.visible");
  cy.getCy("expensemanagement-title").should("be.visible");
  cy.getCy("expensemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("expense_management");

  cy.visitWithSemantics("/executive/payroll");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("payroll-screen").should("be.visible");
  cy.getCy("payroll-title").should("be.visible");
  cy.getCy("payroll-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("payroll");

  cy.visitWithSemantics("/executive/tax-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("taxcompliance-screen").should("be.visible");
  cy.getCy("taxcompliance-title").should("be.visible");
  cy.getCy("taxcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("tax_compliance");

  cy.visitWithSemantics("/executive/financial-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialoperations4k-screen").should("be.visible");
  cy.getCy("financialoperations4k-title").should("be.visible");
  cy.getCy("financialoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("financial_operations4_k");
  });

  it("tests org role ciso", () => {
    cy.loginAsRole("ciso");

  cy.visitWithSemantics("/executive/ciso-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisodashboard-screen").should("be.visible");
  cy.getCy("cisodashboard-title").should("be.visible");
  cy.getCy("cisodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_dashboard");

  cy.visitWithSemantics("/executive/ciso-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoanalytics-screen").should("be.visible");
  cy.getCy("cisoanalytics-title").should("be.visible");
  cy.getCy("cisoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_analytics");

  cy.visitWithSemantics("/executive/ciso-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisocompliance-screen").should("be.visible");
  cy.getCy("cisocompliance-title").should("be.visible");
  cy.getCy("cisocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_compliance");

  cy.visitWithSemantics("/executive/ciso-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoworkflow-screen").should("be.visible");
  cy.getCy("cisoworkflow-title").should("be.visible");
  cy.getCy("cisoworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_workflow");
  });

  it("tests org role coo", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/coo-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coodashboard-screen").should("be.visible");
  cy.getCy("coodashboard-title").should("be.visible");
  cy.getCy("coodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_dashboard");

  cy.visitWithSemantics("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visitWithSemantics("/executive/coo-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooanalytics-screen").should("be.visible");
  cy.getCy("cooanalytics-title").should("be.visible");
  cy.getCy("cooanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_analytics");

  cy.visitWithSemantics("/executive/coo-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocompliance-screen").should("be.visible");
  cy.getCy("coocompliance-title").should("be.visible");
  cy.getCy("coocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_compliance");

  cy.visitWithSemantics("/executive/coo-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflow-screen").should("be.visible");
  cy.getCy("cooworkflow-title").should("be.visible");
  cy.getCy("cooworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_workflow");

  cy.visitWithSemantics("/executive/coo-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocommandcenter-screen").should("be.visible");
  cy.getCy("coocommandcenter-title").should("be.visible");
  cy.getCy("coocommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_command_center");

  cy.visitWithSemantics("/executive/coo-operations-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coooperationsoverview-screen").should("be.visible");
  cy.getCy("coooperationsoverview-title").should("be.visible");
  cy.getCy("coooperationsoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_operations_overview");

  cy.visitWithSemantics("/executive/coo-staffing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coostaffing-screen").should("be.visible");
  cy.getCy("coostaffing-title").should("be.visible");
  cy.getCy("coostaffing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_staffing");

  cy.visitWithSemantics("/executive/coo-scheduling-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooschedulinghealth-screen").should("be.visible");
  cy.getCy("cooschedulinghealth-title").should("be.visible");
  cy.getCy("cooschedulinghealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_scheduling_health");

  cy.visitWithSemantics("/executive/coo-workflow-issues");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflowissues-screen").should("be.visible");
  cy.getCy("cooworkflowissues-title").should("be.visible");
  cy.getCy("cooworkflowissues-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_workflow_issues");

  cy.visitWithSemantics("/executive/coo-branch-comparison");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coobranchcomparison-screen").should("be.visible");
  cy.getCy("coobranchcomparison-title").should("be.visible");
  cy.getCy("coobranchcomparison-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_branch_comparison");

  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");

  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");

  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");

  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");

  cy.visitWithSemantics("/executive/operations-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationscommandcenter-screen").should("be.visible");
  cy.getCy("operationscommandcenter-title").should("be.visible");
  cy.getCy("operationscommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_command_center");

  cy.visitWithSemantics("/executive/staffing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffingoverview-screen").should("be.visible");
  cy.getCy("staffingoverview-title").should("be.visible");
  cy.getCy("staffingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staffing_overview");

  cy.visitWithSemantics("/executive/workflow-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowissue-screen").should("be.visible");
  cy.getCy("workflowissue-title").should("be.visible");
  cy.getCy("workflowissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_issue");

  cy.visitWithSemantics("/executive/service-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("servicequality-screen").should("be.visible");
  cy.getCy("servicequality-title").should("be.visible");
  cy.getCy("servicequality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("service_quality");

  cy.visitWithSemantics("/executive/branch-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("branchperformance-screen").should("be.visible");
  cy.getCy("branchperformance-title").should("be.visible");
  cy.getCy("branchperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("branch_performance");

  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_dashboard");

  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_assignment");

  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("certification_tracking");

  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_progress");
  });

  it("tests org role cto", () => {
    cy.loginAsRole("cto");

  cy.visitWithSemantics("/clinical/clinical-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldashboard-screen").should("be.visible");
  cy.getCy("clinicaldashboard-title").should("be.visible");
  cy.getCy("clinicaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_dashboard");

  cy.visitWithSemantics("/common/architecture-planning-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningdashboard-screen").should("be.visible");
  cy.getCy("architectureplanningdashboard-title").should("be.visible");
  cy.getCy("architectureplanningdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_dashboard");

  cy.visitWithSemantics("/common/chiropractor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  cy.getCy("chiropractordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");

  cy.visitWithSemantics("/common/clinic-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");

  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");

  cy.visitWithSemantics("/executive/cto-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctodashboard-screen").should("be.visible");
  cy.getCy("ctodashboard-title").should("be.visible");
  cy.getCy("ctodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cto_dashboard");

  cy.visitWithSemantics("/executive/cx-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");

  cy.visitWithSemantics("/executive/finance-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectordashboard-screen").should("be.visible");
  cy.getCy("financedirectordashboard-title").should("be.visible");
  cy.getCy("financedirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_dashboard");

  cy.visitWithSemantics("/executive/hr-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");

  cy.visitWithSemantics("/executive/training-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");

  cy.visitWithSemantics("/staff/hr-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");

  cy.visitWithSemantics("/clinical/clinical-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalanalytics-screen").should("be.visible");
  cy.getCy("clinicalanalytics-title").should("be.visible");
  cy.getCy("clinicalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_analytics");

  cy.visitWithSemantics("/clinical/clinical-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalcompliance-screen").should("be.visible");
  cy.getCy("clinicalcompliance-title").should("be.visible");
  cy.getCy("clinicalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_compliance");

  cy.visitWithSemantics("/clinical/clinical-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalworkflow-screen").should("be.visible");
  cy.getCy("clinicalworkflow-title").should("be.visible");
  cy.getCy("clinicalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_workflow");

  cy.visitWithSemantics("/common/chiropractor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractoranalytics-screen").should("be.visible");
  cy.getCy("chiropractoranalytics-title").should("be.visible");
  cy.getCy("chiropractoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_analytics");

  cy.visitWithSemantics("/common/chiropractor-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcompliance-screen").should("be.visible");
  cy.getCy("chiropractorcompliance-title").should("be.visible");
  cy.getCy("chiropractorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_compliance");

  cy.visitWithSemantics("/common/chiropractor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorworkflow-screen").should("be.visible");
  cy.getCy("chiropractorworkflow-title").should("be.visible");
  cy.getCy("chiropractorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_workflow");

  cy.visitWithSemantics("/common/clinic-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicanalytics-screen").should("be.visible");
  cy.getCy("clinicanalytics-title").should("be.visible");
  cy.getCy("clinicanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_analytics");

  cy.visitWithSemantics("/common/clinic-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cliniccompliance-screen").should("be.visible");
  cy.getCy("cliniccompliance-title").should("be.visible");
  cy.getCy("cliniccompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_compliance");

  cy.visitWithSemantics("/common/clinic-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicworkflow-screen").should("be.visible");
  cy.getCy("clinicworkflow-title").should("be.visible");
  cy.getCy("clinicworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_workflow");

  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");

  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");

  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");

  cy.visitWithSemantics("/executive/cto-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoanalytics-screen").should("be.visible");
  cy.getCy("ctoanalytics-title").should("be.visible");
  cy.getCy("ctoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cto_analytics");

  cy.visitWithSemantics("/executive/cto-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctocompliance-screen").should("be.visible");
  cy.getCy("ctocompliance-title").should("be.visible");
  cy.getCy("ctocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cto_compliance");

  cy.visitWithSemantics("/executive/cto-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoworkflow-screen").should("be.visible");
  cy.getCy("ctoworkflow-title").should("be.visible");
  cy.getCy("ctoworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cto_workflow");

  cy.visitWithSemantics("/executive/cx-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectoranalytics-screen").should("be.visible");
  cy.getCy("cxdirectoranalytics-title").should("be.visible");
  cy.getCy("cxdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_analytics");

  cy.visitWithSemantics("/executive/cx-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorcompliance-screen").should("be.visible");
  cy.getCy("cxdirectorcompliance-title").should("be.visible");
  cy.getCy("cxdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_compliance");

  cy.visitWithSemantics("/executive/cx-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorworkflow-screen").should("be.visible");
  cy.getCy("cxdirectorworkflow-title").should("be.visible");
  cy.getCy("cxdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_workflow");

  cy.visitWithSemantics("/executive/finance-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectoranalytics-screen").should("be.visible");
  cy.getCy("financedirectoranalytics-title").should("be.visible");
  cy.getCy("financedirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_analytics");

  cy.visitWithSemantics("/executive/finance-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcompliance-screen").should("be.visible");
  cy.getCy("financedirectorcompliance-title").should("be.visible");
  cy.getCy("financedirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_compliance");

  cy.visitWithSemantics("/executive/finance-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorworkflow-screen").should("be.visible");
  cy.getCy("financedirectorworkflow-title").should("be.visible");
  cy.getCy("financedirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_workflow");

  cy.visitWithSemantics("/executive/hr-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoranalytics-screen").should("be.visible");
  cy.getCy("hrdirectoranalytics-title").should("be.visible");
  cy.getCy("hrdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_analytics");

  cy.visitWithSemantics("/executive/hr-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcompliance-screen").should("be.visible");
  cy.getCy("hrdirectorcompliance-title").should("be.visible");
  cy.getCy("hrdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_compliance");

  cy.visitWithSemantics("/executive/hr-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorworkflow-screen").should("be.visible");
  cy.getCy("hrdirectorworkflow-title").should("be.visible");
  cy.getCy("hrdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_workflow");

  cy.visitWithSemantics("/staff/hr-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanageranalytics-screen").should("be.visible");
  cy.getCy("hrmanageranalytics-title").should("be.visible");
  cy.getCy("hrmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_analytics");

  cy.visitWithSemantics("/staff/hr-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagercompliance-screen").should("be.visible");
  cy.getCy("hrmanagercompliance-title").should("be.visible");
  cy.getCy("hrmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_compliance");

  cy.visitWithSemantics("/staff/hr-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerworkflow-screen").should("be.visible");
  cy.getCy("hrmanagerworkflow-title").should("be.visible");
  cy.getCy("hrmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_workflow");

  cy.visitWithSemantics("/allied/chiropractor-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
  cy.getCy("chiropractorcommandcenter-title").should("be.visible");
  cy.getCy("chiropractorcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_command_center");

  cy.visitWithSemantics("/allied/chiropractor-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorappointments-screen").should("be.visible");
  cy.getCy("chiropractorappointments-title").should("be.visible");
  cy.getCy("chiropractorappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_appointments");

  cy.visitWithSemantics("/allied/chiropractor-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorclientintake-screen").should("be.visible");
  cy.getCy("chiropractorclientintake-title").should("be.visible");
  cy.getCy("chiropractorclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_client_intake");

  cy.visitWithSemantics("/allied/chiropractor-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorassessment-screen").should("be.visible");
  cy.getCy("chiropractorassessment-title").should("be.visible");
  cy.getCy("chiropractorassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_assessment");

  cy.visitWithSemantics("/allied/chiropractor-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_treatment_notes");

  cy.visitWithSemantics("/allied/chiropractor-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
  cy.getCy("chiropractorexerciseplan-title").should("be.visible");
  cy.getCy("chiropractorexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_exercise_plan");

  cy.visitWithSemantics("/allied/chiropractor-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorbillinglink-screen").should("be.visible");
  cy.getCy("chiropractorbillinglink-title").should("be.visible");
  cy.getCy("chiropractorbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_billing_link");

  cy.visitWithSemantics("/allied/chiropractor-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorreports-screen").should("be.visible");
  cy.getCy("chiropractorreports-title").should("be.visible");
  cy.getCy("chiropractorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_reports");

  cy.visitWithSemantics("/clinical/clinical-director-staff-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-title").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_staff_quality");

  cy.visitWithSemantics("/clinical/clinical-director-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-title").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_incident_review");

  cy.visitWithSemantics("/clinical/clinical-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");

  cy.visitWithSemantics("/clinical/clinical-director-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorreports-screen").should("be.visible");
  cy.getCy("clinicaldirectorreports-title").should("be.visible");
  cy.getCy("clinicaldirectorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");

  cy.visitWithSemantics("/clinical/clinical-director-approvals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorapprovals-screen").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-title").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_approvals");

  cy.visitWithSemantics("/clinical/clinical-director-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorperformance-screen").should("be.visible");
  cy.getCy("clinicaldirectorperformance-title").should("be.visible");
  cy.getCy("clinicaldirectorperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_performance");

  cy.visitWithSemantics("/executive/hr-director-hiring-pipeline");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorhiringpipeline-screen").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-title").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_hiring_pipeline");

  cy.visitWithSemantics("/executive/hr-director-staff-files");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
  cy.getCy("hrdirectorstafffiles-title").should("be.visible");
  cy.getCy("hrdirectorstafffiles-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_staff_files");

  cy.visitWithSemantics("/executive/hr-director-training");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectortraining-screen").should("be.visible");
  cy.getCy("hrdirectortraining-title").should("be.visible");
  cy.getCy("hrdirectortraining-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_training");

  cy.visitWithSemantics("/executive/hr-director-credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_credential_expiry");

  cy.visitWithSemantics("/executive/hr-director-onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoronboarding-screen").should("be.visible");
  cy.getCy("hrdirectoronboarding-title").should("be.visible");
  cy.getCy("hrdirectoronboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_onboarding");

  cy.visitWithSemantics("/executive/system-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemhealth-screen").should("be.visible");
  cy.getCy("systemhealth-title").should("be.visible");
  cy.getCy("systemhealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_health");

  cy.visitWithSemantics("/executive/api-monitoring");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apimonitoring-screen").should("be.visible");
  cy.getCy("apimonitoring-title").should("be.visible");
  cy.getCy("apimonitoring-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("api_monitoring");

  cy.visitWithSemantics("/executive/deployment-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("deploymentcenter-screen").should("be.visible");
  cy.getCy("deploymentcenter-title").should("be.visible");
  cy.getCy("deploymentcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("deployment_center");

  cy.visitWithSemantics("/executive/security-audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securityaudit-screen").should("be.visible");
  cy.getCy("securityaudit-title").should("be.visible");
  cy.getCy("securityaudit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("security_audit");

  cy.visitWithSemantics("/executive/release-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releasemanagement-screen").should("be.visible");
  cy.getCy("releasemanagement-title").should("be.visible");
  cy.getCy("releasemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("release_management");

  cy.visitWithSemantics("/management/hiring-pipeline");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hiringpipeline-screen").should("be.visible");
  cy.getCy("hiringpipeline-title").should("be.visible");
  cy.getCy("hiringpipeline-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hiring_pipeline");

  cy.visitWithSemantics("/management/employee-records");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeerecords-screen").should("be.visible");
  cy.getCy("employeerecords-title").should("be.visible");
  cy.getCy("employeerecords-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_records");

  cy.visitWithSemantics("/management/credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialexpiry-screen").should("be.visible");
  cy.getCy("credentialexpiry-title").should("be.visible");
  cy.getCy("credentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("credential_expiry");

  cy.visitWithSemantics("/management/training-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingmanagement-screen").should("be.visible");
  cy.getCy("trainingmanagement-title").should("be.visible");
  cy.getCy("trainingmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_management");

  cy.visitWithSemantics("/management/onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboarding-screen").should("be.visible");
  cy.getCy("onboarding-title").should("be.visible");
  cy.getCy("onboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("onboarding");

  cy.visitWithSemantics("/allied/chiropractic-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticassessment-screen").should("be.visible");
  cy.getCy("chiropracticassessment-title").should("be.visible");
  cy.getCy("chiropracticassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_assessment");

  cy.visitWithSemantics("/allied/adjustment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adjustmentnotes-screen").should("be.visible");
  cy.getCy("adjustmentnotes-title").should("be.visible");
  cy.getCy("adjustmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("adjustment_notes");

  cy.visitWithSemantics("/allied/xray-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("xrayreview-screen").should("be.visible");
  cy.getCy("xrayreview-title").should("be.visible");
  cy.getCy("xrayreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("xray_review");

  cy.visitWithSemantics("/allied/chiropractic-progress-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
  cy.getCy("chiropracticprogresstracking-title").should("be.visible");
  cy.getCy("chiropracticprogresstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_progress_tracking");

  cy.visitWithSemantics("/clinical/clinical-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalquality-screen").should("be.visible");
  cy.getCy("clinicalquality-title").should("be.visible");
  cy.getCy("clinicalquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_quality");

  cy.visitWithSemantics("/clinical/staff-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffperformance-screen").should("be.visible");
  cy.getCy("staffperformance-title").should("be.visible");
  cy.getCy("staffperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_performance");

  cy.visitWithSemantics("/clinical/compliance-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereview-screen").should("be.visible");
  cy.getCy("compliancereview-title").should("be.visible");
  cy.getCy("compliancereview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_review");

  cy.visitWithSemantics("/clinical/incident-oversight");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentoversight-screen").should("be.visible");
  cy.getCy("incidentoversight-title").should("be.visible");
  cy.getCy("incidentoversight-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_oversight");

  cy.visitWithSemantics("/clinical/clinical-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloperations4k-screen").should("be.visible");
  cy.getCy("clinicaloperations4k-title").should("be.visible");
  cy.getCy("clinicaloperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");
  });

  it("tests org role cx_director", () => {
    cy.loginAsRole("cx_director");

  cy.visitWithSemantics("/executive/cx-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");

  cy.visitWithSemantics("/executive/cx-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectoranalytics-screen").should("be.visible");
  cy.getCy("cxdirectoranalytics-title").should("be.visible");
  cy.getCy("cxdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_analytics");

  cy.visitWithSemantics("/executive/cx-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorcompliance-screen").should("be.visible");
  cy.getCy("cxdirectorcompliance-title").should("be.visible");
  cy.getCy("cxdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_compliance");

  cy.visitWithSemantics("/executive/cx-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorworkflow-screen").should("be.visible");
  cy.getCy("cxdirectorworkflow-title").should("be.visible");
  cy.getCy("cxdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_workflow");
  });

  it("tests org role finance_director", () => {
    cy.loginAsRole("finance_director");

  cy.visitWithSemantics("/executive/finance-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectordashboard-screen").should("be.visible");
  cy.getCy("financedirectordashboard-title").should("be.visible");
  cy.getCy("financedirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_dashboard");

  cy.visitWithSemantics("/executive/finance-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectoranalytics-screen").should("be.visible");
  cy.getCy("financedirectoranalytics-title").should("be.visible");
  cy.getCy("financedirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_analytics");

  cy.visitWithSemantics("/executive/finance-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcompliance-screen").should("be.visible");
  cy.getCy("financedirectorcompliance-title").should("be.visible");
  cy.getCy("financedirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_compliance");

  cy.visitWithSemantics("/executive/finance-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorworkflow-screen").should("be.visible");
  cy.getCy("financedirectorworkflow-title").should("be.visible");
  cy.getCy("financedirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_workflow");
  });

  it("tests org role hr_director", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/executive/hr-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");

  cy.visitWithSemantics("/staff/hr-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");

  cy.visitWithSemantics("/executive/hr-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoranalytics-screen").should("be.visible");
  cy.getCy("hrdirectoranalytics-title").should("be.visible");
  cy.getCy("hrdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_analytics");

  cy.visitWithSemantics("/executive/hr-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcompliance-screen").should("be.visible");
  cy.getCy("hrdirectorcompliance-title").should("be.visible");
  cy.getCy("hrdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_compliance");

  cy.visitWithSemantics("/executive/hr-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorworkflow-screen").should("be.visible");
  cy.getCy("hrdirectorworkflow-title").should("be.visible");
  cy.getCy("hrdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_workflow");

  cy.visitWithSemantics("/staff/hr-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanageranalytics-screen").should("be.visible");
  cy.getCy("hrmanageranalytics-title").should("be.visible");
  cy.getCy("hrmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_analytics");

  cy.visitWithSemantics("/staff/hr-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagercompliance-screen").should("be.visible");
  cy.getCy("hrmanagercompliance-title").should("be.visible");
  cy.getCy("hrmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_compliance");

  cy.visitWithSemantics("/staff/hr-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerworkflow-screen").should("be.visible");
  cy.getCy("hrmanagerworkflow-title").should("be.visible");
  cy.getCy("hrmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_workflow");

  cy.visitWithSemantics("/executive/hr-director-hiring-pipeline");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorhiringpipeline-screen").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-title").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_hiring_pipeline");

  cy.visitWithSemantics("/executive/hr-director-staff-files");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
  cy.getCy("hrdirectorstafffiles-title").should("be.visible");
  cy.getCy("hrdirectorstafffiles-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_staff_files");

  cy.visitWithSemantics("/executive/hr-director-training");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectortraining-screen").should("be.visible");
  cy.getCy("hrdirectortraining-title").should("be.visible");
  cy.getCy("hrdirectortraining-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_training");

  cy.visitWithSemantics("/executive/hr-director-credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_credential_expiry");

  cy.visitWithSemantics("/executive/hr-director-onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoronboarding-screen").should("be.visible");
  cy.getCy("hrdirectoronboarding-title").should("be.visible");
  cy.getCy("hrdirectoronboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_onboarding");

  cy.visitWithSemantics("/management/hiring-pipeline");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hiringpipeline-screen").should("be.visible");
  cy.getCy("hiringpipeline-title").should("be.visible");
  cy.getCy("hiringpipeline-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hiring_pipeline");

  cy.visitWithSemantics("/management/employee-records");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeerecords-screen").should("be.visible");
  cy.getCy("employeerecords-title").should("be.visible");
  cy.getCy("employeerecords-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_records");

  cy.visitWithSemantics("/management/credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialexpiry-screen").should("be.visible");
  cy.getCy("credentialexpiry-title").should("be.visible");
  cy.getCy("credentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("credential_expiry");

  cy.visitWithSemantics("/management/training-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingmanagement-screen").should("be.visible");
  cy.getCy("trainingmanagement-title").should("be.visible");
  cy.getCy("trainingmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_management");

  cy.visitWithSemantics("/management/onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboarding-screen").should("be.visible");
  cy.getCy("onboarding-title").should("be.visible");
  cy.getCy("onboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("onboarding");
  });

  it("tests org role legal", () => {
    cy.loginAsRole("legal");

  cy.visitWithSemantics("/executive/legal-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legaldashboard-screen").should("be.visible");
  cy.getCy("legaldashboard-title").should("be.visible");
  cy.getCy("legaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_dashboard");

  cy.visitWithSemantics("/executive/legal-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalanalytics-screen").should("be.visible");
  cy.getCy("legalanalytics-title").should("be.visible");
  cy.getCy("legalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_analytics");

  cy.visitWithSemantics("/executive/legal-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalcompliance-screen").should("be.visible");
  cy.getCy("legalcompliance-title").should("be.visible");
  cy.getCy("legalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_compliance");

  cy.visitWithSemantics("/executive/legal-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalworkflow-screen").should("be.visible");
  cy.getCy("legalworkflow-title").should("be.visible");
  cy.getCy("legalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_workflow");
  });

  it("tests org role owner", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/common/franchise-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");

  cy.visitWithSemantics("/executive/owner-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_dashboard");

  cy.visitWithSemantics("/common/franchise-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseanalytics-screen").should("be.visible");
  cy.getCy("franchiseanalytics-title").should("be.visible");
  cy.getCy("franchiseanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_analytics");

  cy.visitWithSemantics("/common/franchise-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecompliance-screen").should("be.visible");
  cy.getCy("franchisecompliance-title").should("be.visible");
  cy.getCy("franchisecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_compliance");

  cy.visitWithSemantics("/common/franchise-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseworkflow-screen").should("be.visible");
  cy.getCy("franchiseworkflow-title").should("be.visible");
  cy.getCy("franchiseworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_workflow");

  cy.visitWithSemantics("/executive/owner-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("owneranalytics-screen").should("be.visible");
  cy.getCy("owneranalytics-title").should("be.visible");
  cy.getCy("owneranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_analytics");

  cy.visitWithSemantics("/executive/owner-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownercompliance-screen").should("be.visible");
  cy.getCy("ownercompliance-title").should("be.visible");
  cy.getCy("ownercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_compliance");

  cy.visitWithSemantics("/executive/owner-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerworkflow-screen").should("be.visible");
  cy.getCy("ownerworkflow-title").should("be.visible");
  cy.getCy("ownerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_workflow");

  cy.visitWithSemantics("/management/franchise-sales-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanageranalytics-screen").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-title").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_analytics");

  cy.visitWithSemantics("/management/franchise-sales-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercompliance-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-title").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_compliance");

  cy.visitWithSemantics("/management/franchise-sales-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-title").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_workflow");

  cy.visitWithSemantics("/executive/franchise-owner-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
  cy.getCy("franchiseownercommandcenter-title").should("be.visible");
  cy.getCy("franchiseownercommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_command_center");

  cy.visitWithSemantics("/executive/franchise-owner-branch-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_branch_overview");

  cy.visitWithSemantics("/executive/franchise-owner-staff");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerstaff-screen").should("be.visible");
  cy.getCy("franchiseownerstaff-title").should("be.visible");
  cy.getCy("franchiseownerstaff-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_staff");

  cy.visitWithSemantics("/executive/franchise-owner-clients");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerclients-screen").should("be.visible");
  cy.getCy("franchiseownerclients-title").should("be.visible");
  cy.getCy("franchiseownerclients-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_clients");

  cy.visitWithSemantics("/executive/franchise-owner-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerappointments-screen").should("be.visible");
  cy.getCy("franchiseownerappointments-title").should("be.visible");
  cy.getCy("franchiseownerappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_appointments");

  cy.visitWithSemantics("/executive/franchise-owner-finance-snapshot");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerfinancesnapshot-screen").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-title").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_finance_snapshot");

  cy.visitWithSemantics("/executive/franchise-owner-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercompliance-screen").should("be.visible");
  cy.getCy("franchiseownercompliance-title").should("be.visible");
  cy.getCy("franchiseownercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_compliance");

  cy.visitWithSemantics("/executive/franchise-owner-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerreports-screen").should("be.visible");
  cy.getCy("franchiseownerreports-title").should("be.visible");
  cy.getCy("franchiseownerreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_reports");

  cy.visitWithSemantics("/executive/franchise-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter-screen").should("be.visible");
  cy.getCy("franchisecommandcenter-title").should("be.visible");
  cy.getCy("franchisecommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_command_center");

  cy.visitWithSemantics("/executive/revenue-snapshot");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenuesnapshot-screen").should("be.visible");
  cy.getCy("revenuesnapshot-title").should("be.visible");
  cy.getCy("revenuesnapshot-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue_snapshot");

  cy.visitWithSemantics("/executive/staff-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffmanagement-screen").should("be.visible");
  cy.getCy("staffmanagement-title").should("be.visible");
  cy.getCy("staffmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_management");

  cy.visitWithSemantics("/executive/appointment-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointmentoverview-screen").should("be.visible");
  cy.getCy("appointmentoverview-title").should("be.visible");
  cy.getCy("appointmentoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("appointment_overview");

  cy.visitWithSemantics("/executive/compliance-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("complianceoverview-screen").should("be.visible");
  cy.getCy("complianceoverview-title").should("be.visible");
  cy.getCy("complianceoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_overview");

  cy.visitWithSemantics("/executive/franchise-command-center4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
  cy.getCy("franchisecommandcenter4k-title").should("be.visible");
  cy.getCy("franchisecommandcenter4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_command_center4_k");
  });

  it("tests org role shareholder", () => {
    cy.loginAsRole("shareholder");

  cy.visitWithSemantics("/executive/shareholder-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderdashboard-screen").should("be.visible");
  cy.getCy("shareholderdashboard-title").should("be.visible");
  cy.getCy("shareholderdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_dashboard");

  cy.visitWithSemantics("/executive/shareholder-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderanalytics-screen").should("be.visible");
  cy.getCy("shareholderanalytics-title").should("be.visible");
  cy.getCy("shareholderanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_analytics");

  cy.visitWithSemantics("/executive/shareholder-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholdercompliance-screen").should("be.visible");
  cy.getCy("shareholdercompliance-title").should("be.visible");
  cy.getCy("shareholdercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_compliance");

  cy.visitWithSemantics("/executive/shareholder-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderworkflow-screen").should("be.visible");
  cy.getCy("shareholderworkflow-title").should("be.visible");
  cy.getCy("shareholderworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_workflow");
  });

  it("tests org role training_director", () => {
    cy.loginAsRole("training_director");

  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");

  cy.visitWithSemantics("/executive/training-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");

  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");

  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");

  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");
  });

  it("tests org role community_outreach", () => {
    cy.loginAsRole("community_outreach");

  cy.visitWithSemantics("/management/community-outreach-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");

  cy.visitWithSemantics("/management/community-outreach-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachanalytics-screen").should("be.visible");
  cy.getCy("communityoutreachanalytics-title").should("be.visible");
  cy.getCy("communityoutreachanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_analytics");

  cy.visitWithSemantics("/management/community-outreach-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachcompliance-screen").should("be.visible");
  cy.getCy("communityoutreachcompliance-title").should("be.visible");
  cy.getCy("communityoutreachcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_compliance");

  cy.visitWithSemantics("/management/community-outreach-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachworkflow-screen").should("be.visible");
  cy.getCy("communityoutreachworkflow-title").should("be.visible");
  cy.getCy("communityoutreachworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_workflow");
  });

  it("tests org role compliance", () => {
    cy.loginAsRole("compliance");

  cy.visitWithSemantics("/management/compliance-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerdashboard-screen").should("be.visible");
  cy.getCy("compliancemanagerdashboard-title").should("be.visible");
  cy.getCy("compliancemanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_dashboard");

  cy.visitWithSemantics("/management/compliance-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanageranalytics-screen").should("be.visible");
  cy.getCy("compliancemanageranalytics-title").should("be.visible");
  cy.getCy("compliancemanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_analytics");

  cy.visitWithSemantics("/management/compliance-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagercompliance-screen").should("be.visible");
  cy.getCy("compliancemanagercompliance-title").should("be.visible");
  cy.getCy("compliancemanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_compliance");

  cy.visitWithSemantics("/management/compliance-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerworkflow-screen").should("be.visible");
  cy.getCy("compliancemanagerworkflow-title").should("be.visible");
  cy.getCy("compliancemanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_workflow");

  cy.visitWithSemantics("/management/compliance-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancedashboard-screen").should("be.visible");
  cy.getCy("compliancedashboard-title").should("be.visible");
  cy.getCy("compliancedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_dashboard");

  cy.visitWithSemantics("/management/audit-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditreview-screen").should("be.visible");
  cy.getCy("auditreview-title").should("be.visible");
  cy.getCy("auditreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit_review");

  cy.visitWithSemantics("/management/incident-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentmanagement-screen").should("be.visible");
  cy.getCy("incidentmanagement-title").should("be.visible");
  cy.getCy("incidentmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_management");

  cy.visitWithSemantics("/management/policy-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policymanagement-screen").should("be.visible");
  cy.getCy("policymanagement-title").should("be.visible");
  cy.getCy("policymanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("policy_management");

  cy.visitWithSemantics("/management/corrective-action");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("correctiveaction-screen").should("be.visible");
  cy.getCy("correctiveaction-title").should("be.visible");
  cy.getCy("correctiveaction-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("corrective_action");
  });

  it("tests org role franchise_sales", () => {
    cy.loginAsRole("franchise_sales");

  cy.visitWithSemantics("/management/franchise-sales-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");

  cy.visitWithSemantics("/executive/franchise-sales-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager analytics-screen").should("be.visible");
  cy.getCy("franchise sales manager analytics-title").should("be.visible");
  cy.getCy("franchise sales manager analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_analytics");

  cy.visitWithSemantics("/executive/franchise-sales-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager compliance workflow-screen").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-title").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_workflow");
  });

  it("tests org role gm", () => {
    cy.loginAsRole("gm");

  cy.visitWithSemantics("/management/general-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerdashboard-screen").should("be.visible");
  cy.getCy("generalmanagerdashboard-title").should("be.visible");
  cy.getCy("generalmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_dashboard");

  cy.visitWithSemantics("/management/general-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanageranalytics-screen").should("be.visible");
  cy.getCy("generalmanageranalytics-title").should("be.visible");
  cy.getCy("generalmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_analytics");

  cy.visitWithSemantics("/management/general-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagercompliance-screen").should("be.visible");
  cy.getCy("generalmanagercompliance-title").should("be.visible");
  cy.getCy("generalmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_compliance");

  cy.visitWithSemantics("/management/general-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerworkflow-screen").should("be.visible");
  cy.getCy("generalmanagerworkflow-title").should("be.visible");
  cy.getCy("generalmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_workflow");
  });

  it("tests org role governance", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/common/system-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_dashboard");

  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");

  cy.visitWithSemantics("/management/governance-officer-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");

  cy.visitWithSemantics("/management/governance-officer-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");

  cy.visitWithSemantics("/management/governance-officer-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");

  cy.visitWithSemantics("/common/governance-control-room");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancecontrolroom-screen").should("be.visible");
  cy.getCy("governancecontrolroom-title").should("be.visible");
  cy.getCy("governancecontrolroom-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_control_room");

  cy.visitWithSemantics("/common/runtime-verification");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("runtimeverification-screen").should("be.visible");
  cy.getCy("runtimeverification-title").should("be.visible");
  cy.getCy("runtimeverification-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("runtime_verification");

  cy.visitWithSemantics("/common/drift-findings");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("drift_findings");

  cy.visitWithSemantics("/common/pending-task-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pending_task_queue");

  cy.visitWithSemantics("/common/agent-dispatch");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("agent_dispatch");

  cy.visitWithSemantics("/common/audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit");

  cy.visitWithSemantics("/common/api-health-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");

  cy.visitWithSemantics("/common/release-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releaseoperations-screen").should("be.visible");
  cy.getCy("releaseoperations-title").should("be.visible");
  cy.getCy("releaseoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("release_operations");

  cy.visitWithSemantics("/common/file-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");

  cy.visitWithSemantics("/common/role-coverage-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");

  cy.visitWithSemantics("/common/responsive-preview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("responsive_preview");

  cy.visitWithSemantics("/common/workflow-execution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_execution");

  cy.visitWithSemantics("/common/governance-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceoperations4k-screen").should("be.visible");
  cy.getCy("governanceoperations4k-title").should("be.visible");
  cy.getCy("governanceoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_operations4_k");
  });

  it("tests org role bus_dev", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/common/business-development-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_dashboard");

  cy.visitWithSemantics("/management/head-of-bus-dev-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevdashboard-screen").should("be.visible");
  cy.getCy("headofbusdevdashboard-title").should("be.visible");
  cy.getCy("headofbusdevdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_dashboard");

  cy.visitWithSemantics("/common/business-development-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentanalytics-screen").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-title").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_analytics");

  cy.visitWithSemantics("/common/business-development-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentcompliance-screen").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-title").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_compliance");

  cy.visitWithSemantics("/common/business-development-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentworkflow-screen").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-title").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_workflow");

  cy.visitWithSemantics("/management/head-of-bus-dev-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevanalytics-screen").should("be.visible");
  cy.getCy("headofbusdevanalytics-title").should("be.visible");
  cy.getCy("headofbusdevanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_analytics");

  cy.visitWithSemantics("/management/head-of-bus-dev-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevcompliance-screen").should("be.visible");
  cy.getCy("headofbusdevcompliance-title").should("be.visible");
  cy.getCy("headofbusdevcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_compliance");

  cy.visitWithSemantics("/management/head-of-bus-dev-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevworkflow-screen").should("be.visible");
  cy.getCy("headofbusdevworkflow-title").should("be.visible");
  cy.getCy("headofbusdevworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_workflow");

  cy.visitWithSemantics("/management/franchise-lead");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiselead-screen").should("be.visible");
  cy.getCy("franchiselead-title").should("be.visible");
  cy.getCy("franchiselead-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_lead");

  cy.visitWithSemantics("/management/partnership-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagement-screen").should("be.visible");
  cy.getCy("partnershipmanagement-title").should("be.visible");
  cy.getCy("partnershipmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_management");

  cy.visitWithSemantics("/management/growth-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("growthanalytics-screen").should("be.visible");
  cy.getCy("growthanalytics-title").should("be.visible");
  cy.getCy("growthanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("growth_analytics");

  cy.visitWithSemantics("/management/outreach-campaign");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("outreachcampaign-screen").should("be.visible");
  cy.getCy("outreachcampaign-title").should("be.visible");
  cy.getCy("outreachcampaign-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("outreach_campaign");
  });

  it("tests org role marketing", () => {
    cy.loginAsRole("marketing");

  cy.visitWithSemantics("/management/head-of-marketing-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingdashboard-screen").should("be.visible");
  cy.getCy("headofmarketingdashboard-title").should("be.visible");
  cy.getCy("headofmarketingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_dashboard");

  cy.visitWithSemantics("/management/local-marketing-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");

  cy.visitWithSemantics("/management/head-of-marketing-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketinganalytics-screen").should("be.visible");
  cy.getCy("headofmarketinganalytics-title").should("be.visible");
  cy.getCy("headofmarketinganalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_analytics");

  cy.visitWithSemantics("/management/head-of-marketing-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcompliance-screen").should("be.visible");
  cy.getCy("headofmarketingcompliance-title").should("be.visible");
  cy.getCy("headofmarketingcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_compliance");

  cy.visitWithSemantics("/management/head-of-marketing-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingworkflow-screen").should("be.visible");
  cy.getCy("headofmarketingworkflow-title").should("be.visible");
  cy.getCy("headofmarketingworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_workflow");

  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");

  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");

  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");

  cy.visitWithSemantics("/management/campaign-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaigndashboard-screen").should("be.visible");
  cy.getCy("campaigndashboard-title").should("be.visible");
  cy.getCy("campaigndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("campaign_dashboard");

  cy.visitWithSemantics("/management/lead-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadanalytics-screen").should("be.visible");
  cy.getCy("leadanalytics-title").should("be.visible");
  cy.getCy("leadanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lead_analytics");

  cy.visitWithSemantics("/management/social-media");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialmedia-screen").should("be.visible");
  cy.getCy("socialmedia-title").should("be.visible");
  cy.getCy("socialmedia-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_media");

  cy.visitWithSemantics("/management/brand-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("brandmanagement-screen").should("be.visible");
  cy.getCy("brandmanagement-title").should("be.visible");
  cy.getCy("brandmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("brand_management");
  });

  it("tests org role local_marketing", () => {
    cy.loginAsRole("local_marketing");

  cy.visitWithSemantics("/management/local-marketing-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");

  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");

  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");

  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");
  });

  it("tests org role ops_manager", () => {
    cy.loginAsRole("ops_manager");

  cy.visitWithSemantics("/management/operations-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
  cy.getCy("operationsmanagerdashboard-title").should("be.visible");
  cy.getCy("operationsmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_dashboard");

  cy.visitWithSemantics("/management/operations-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanageranalytics-screen").should("be.visible");
  cy.getCy("operationsmanageranalytics-title").should("be.visible");
  cy.getCy("operationsmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_analytics");

  cy.visitWithSemantics("/management/operations-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagercompliance-screen").should("be.visible");
  cy.getCy("operationsmanagercompliance-title").should("be.visible");
  cy.getCy("operationsmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_compliance");

  cy.visitWithSemantics("/management/operations-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerworkflow-screen").should("be.visible");
  cy.getCy("operationsmanagerworkflow-title").should("be.visible");
  cy.getCy("operationsmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_workflow");

  cy.visitWithSemantics("/management/daily-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dailyoperations-screen").should("be.visible");
  cy.getCy("dailyoperations-title").should("be.visible");
  cy.getCy("dailyoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("daily_operations");

  cy.visitWithSemantics("/management/attendance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("attendance-screen").should("be.visible");
  cy.getCy("attendance-title").should("be.visible");
  cy.getCy("attendance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("attendance");

  cy.visitWithSemantics("/management/scheduling-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulinghealth-screen").should("be.visible");
  cy.getCy("schedulinghealth-title").should("be.visible");
  cy.getCy("schedulinghealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_health");

  cy.visitWithSemantics("/management/service-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("serviceissue-screen").should("be.visible");
  cy.getCy("serviceissue-title").should("be.visible");
  cy.getCy("serviceissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("service_issue");
  });

  it("tests org role partnership", () => {
    cy.loginAsRole("partnership");

  cy.visitWithSemantics("/management/partnership-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_dashboard");

  cy.visitWithSemantics("/management/partnership-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageranalytics-screen").should("be.visible");
  cy.getCy("partnershipmanageranalytics-title").should("be.visible");
  cy.getCy("partnershipmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_analytics");

  cy.visitWithSemantics("/management/partnership-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagercompliance-screen").should("be.visible");
  cy.getCy("partnershipmanagercompliance-title").should("be.visible");
  cy.getCy("partnershipmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_compliance");

  cy.visitWithSemantics("/management/partnership-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerworkflow-screen").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-title").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_workflow");
  });

  it("tests org role regional_bdm", () => {
    cy.loginAsRole("regional_bdm");

  cy.visitWithSemantics("/management/regional-bdm-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmdashboard-screen").should("be.visible");
  cy.getCy("regionalbdmdashboard-title").should("be.visible");
  cy.getCy("regionalbdmdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_dashboard");

  cy.visitWithSemantics("/management/regional-bdm-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmanalytics-screen").should("be.visible");
  cy.getCy("regionalbdmanalytics-title").should("be.visible");
  cy.getCy("regionalbdmanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_analytics");

  cy.visitWithSemantics("/management/regional-bdm-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmcompliance-screen").should("be.visible");
  cy.getCy("regionalbdmcompliance-title").should("be.visible");
  cy.getCy("regionalbdmcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_compliance");

  cy.visitWithSemantics("/management/regional-bdm-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmworkflow-screen").should("be.visible");
  cy.getCy("regionalbdmworkflow-title").should("be.visible");
  cy.getCy("regionalbdmworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_workflow");
  });

  it("tests org role regional_manager_usa", () => {
    cy.loginAsRole("regional_manager_usa");

  cy.visitWithSemantics("/management/regional-manager-usa-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_dashboard");

  cy.visitWithSemantics("/management/regional-manager-usa-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaanalytics-screen").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-title").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_analytics");

  cy.visitWithSemantics("/management/regional-manager-usa-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusacompliance-screen").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-title").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_compliance");

  cy.visitWithSemantics("/management/regional-manager-usa-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaworkflow-screen").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-title").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_workflow");
  });

  it("tests org role scrum_master", () => {
    cy.loginAsRole("scrum_master");

  cy.visitWithSemantics("/management/scrum-master-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterdashboard-screen").should("be.visible");
  cy.getCy("scrummasterdashboard-title").should("be.visible");
  cy.getCy("scrummasterdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_dashboard");

  cy.visitWithSemantics("/management/scrum-master-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasteranalytics-screen").should("be.visible");
  cy.getCy("scrummasteranalytics-title").should("be.visible");
  cy.getCy("scrummasteranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_analytics");

  cy.visitWithSemantics("/management/scrum-master-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummastercompliance-screen").should("be.visible");
  cy.getCy("scrummastercompliance-title").should("be.visible");
  cy.getCy("scrummastercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_compliance");

  cy.visitWithSemantics("/management/scrum-master-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterworkflow-screen").should("be.visible");
  cy.getCy("scrummasterworkflow-title").should("be.visible");
  cy.getCy("scrummasterworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_workflow");
  });

  it("tests org role hr_hiring", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/hr-hiring-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringdashboard-screen").should("be.visible");
  cy.getCy("hrhiringdashboard-title").should("be.visible");
  cy.getCy("hrhiringdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");

  cy.visitWithSemantics("/staff/hr-hiring-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringanalytics-screen").should("be.visible");
  cy.getCy("hrhiringanalytics-title").should("be.visible");
  cy.getCy("hrhiringanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_analytics");

  cy.visitWithSemantics("/staff/hr-hiring-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcompliance-screen").should("be.visible");
  cy.getCy("hrhiringcompliance-title").should("be.visible");
  cy.getCy("hrhiringcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_compliance");

  cy.visitWithSemantics("/staff/hr-hiring-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringworkflow-screen").should("be.visible");
  cy.getCy("hrhiringworkflow-title").should("be.visible");
  cy.getCy("hrhiringworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_workflow");

  cy.visitWithSemantics("/staff/hr-hiring-applicants");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringapplicants-screen").should("be.visible");
  cy.getCy("hrhiringapplicants-title").should("be.visible");
  cy.getCy("hrhiringapplicants-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_applicants");

  cy.visitWithSemantics("/staff/hr-hiring-interviews");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringinterviews-screen").should("be.visible");
  cy.getCy("hrhiringinterviews-title").should("be.visible");
  cy.getCy("hrhiringinterviews-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_interviews");

  cy.visitWithSemantics("/staff/hr-hiring-offers");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringoffers-screen").should("be.visible");
  cy.getCy("hrhiringoffers-title").should("be.visible");
  cy.getCy("hrhiringoffers-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_offers");

  cy.visitWithSemantics("/staff/hr-hiring-onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringonboarding-screen").should("be.visible");
  cy.getCy("hrhiringonboarding-title").should("be.visible");
  cy.getCy("hrhiringonboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_onboarding");

  cy.visitWithSemantics("/staff/hr-hiring-credentials");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcredentials-screen").should("be.visible");
  cy.getCy("hrhiringcredentials-title").should("be.visible");
  cy.getCy("hrhiringcredentials-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_credentials");

  cy.visitWithSemantics("/staff/applicant-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("applicanttracking-screen").should("be.visible");
  cy.getCy("applicanttracking-title").should("be.visible");
  cy.getCy("applicanttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("applicant_tracking");

  cy.visitWithSemantics("/staff/interview-scheduling");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("interviewscheduling-screen").should("be.visible");
  cy.getCy("interviewscheduling-title").should("be.visible");
  cy.getCy("interviewscheduling-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("interview_scheduling");

  cy.visitWithSemantics("/staff/offer-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("offermanagement-screen").should("be.visible");
  cy.getCy("offermanagement-title").should("be.visible");
  cy.getCy("offermanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("offer_management");

  cy.visitWithSemantics("/staff/onboarding-checklist");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboardingchecklist-screen").should("be.visible");
  cy.getCy("onboardingchecklist-title").should("be.visible");
  cy.getCy("onboardingchecklist-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("onboarding_checklist");
  });

  it("tests org role territory_expansion", () => {
    cy.loginAsRole("territory_expansion");

  cy.visitWithSemantics("/management/territory-expansion-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_dashboard");

  cy.visitWithSemantics("/management/territory-expansion-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanageranalytics-screen").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-title").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_analytics");

  cy.visitWithSemantics("/management/territory-expansion-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagercompliance-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-title").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_compliance");

  cy.visitWithSemantics("/management/territory-expansion-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerworkflow-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_workflow");
  });

  it("tests org role territory_sales", () => {
    cy.loginAsRole("territory_sales");

  cy.visitWithSemantics("/management/territory-sales-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");

  cy.visitWithSemantics("/management/territory-sales-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanageranalytics-screen").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-title").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_analytics");

  cy.visitWithSemantics("/management/territory-sales-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagercompliance-screen").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-title").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_compliance");

  cy.visitWithSemantics("/management/territory-sales-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-title").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_workflow");
  });

  it("tests org role volunteer_coordinator", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.visitWithSemantics("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");

  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");

  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");

  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");
  });

  it("tests org role premium_concierge", () => {
    cy.loginAsRole("premium_concierge");

  cy.visitWithSemantics("/management/premium-concierge-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergedashboard-screen").should("be.visible");
  cy.getCy("premiumconciergedashboard-title").should("be.visible");
  cy.getCy("premiumconciergedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_dashboard");

  cy.visitWithSemantics("/premium/premium-concierge-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premium concierge care coordinator analytics-screen").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-title").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_analytics");

  cy.visitWithSemantics("/premium/premium-concierge-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premium concierge care coordinator compliance workflow-screen").should("be.visible");
  cy.getCy("premium concierge care coordinator compliance workflow-title").should("be.visible");
  cy.getCy("premium concierge care coordinator compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_workflow");
  });

  it("tests org role vip_manager", () => {
    cy.loginAsRole("vip_manager");

  cy.visitWithSemantics("/management/vip-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerdashboard-screen").should("be.visible");
  cy.getCy("vipmanagerdashboard-title").should("be.visible");
  cy.getCy("vipmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_dashboard");

  cy.visitWithSemantics("/executive/vip-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vip client manager analytics-screen").should("be.visible");
  cy.getCy("vip client manager analytics-title").should("be.visible");
  cy.getCy("vip client manager analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_analytics");

  cy.visitWithSemantics("/executive/vip-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vip client manager compliance workflow-screen").should("be.visible");
  cy.getCy("vip client manager compliance workflow-title").should("be.visible");
  cy.getCy("vip client manager compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_workflow");
  });

  it("tests org role psw", () => {
    cy.loginAsRole("psw");

  cy.visitWithSemantics("/psw/psw-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  cy.getCy("pswdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_dashboard");

  cy.visitWithSemantics("/psw/psw-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswanalytics-screen").should("be.visible");
  cy.getCy("pswanalytics-title").should("be.visible");
  cy.getCy("pswanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_analytics");

  cy.visitWithSemantics("/psw/psw-clients");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclients-screen").should("be.visible");
  cy.getCy("pswclients-title").should("be.visible");
  cy.getCy("pswclients-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_clients");

  cy.visitWithSemantics("/psw/psw-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcompliance-screen").should("be.visible");
  cy.getCy("pswcompliance-title").should("be.visible");
  cy.getCy("pswcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_compliance");

  cy.visitWithSemantics("/psw/psw-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_messages");

  cy.visitWithSemantics("/psw/psw-shift-tracker");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswshifttracker-screen").should("be.visible");
  cy.getCy("pswshifttracker-title").should("be.visible");
  cy.getCy("pswshifttracker-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");

  cy.visitWithSemantics("/psw/psw-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasks-screen").should("be.visible");
  cy.getCy("pswtasks-title").should("be.visible");
  cy.getCy("pswtasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_tasks");

  cy.visitWithSemantics("/psw/psw-visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");

  cy.visitWithSemantics("/psw/psw-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswworkflow-screen").should("be.visible");
  cy.getCy("pswworkflow-title").should("be.visible");
  cy.getCy("pswworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_workflow");

  cy.visitWithSemantics("/psw/psw-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcommandcenter-screen").should("be.visible");
  cy.getCy("pswcommandcenter-title").should("be.visible");
  cy.getCy("pswcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_command_center");

  cy.visitWithSemantics("/psw/psw-my-shifts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyshifts-screen").should("be.visible");
  cy.getCy("pswmyshifts-title").should("be.visible");
  cy.getCy("pswmyshifts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");

  cy.visitWithSemantics("/psw/psw-client-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclientprofile-screen").should("be.visible");
  cy.getCy("pswclientprofile-title").should("be.visible");
  cy.getCy("pswclientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_client_profile");

  cy.visitWithSemantics("/psw/psw-visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");

  cy.visitWithSemantics("/psw/psw-vitals-log");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvitalslog-screen").should("be.visible");
  cy.getCy("pswvitalslog-title").should("be.visible");
  cy.getCy("pswvitalslog-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");

  cy.visitWithSemantics("/psw/psw-incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswincidentreport-screen").should("be.visible");
  cy.getCy("pswincidentreport-title").should("be.visible");
  cy.getCy("pswincidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_incident_report");

  cy.visitWithSemantics("/psw/psw-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcareplan-screen").should("be.visible");
  cy.getCy("pswcareplan-title").should("be.visible");
  cy.getCy("pswcareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_care_plan");

  cy.visitWithSemantics("/psw/psw-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_messages");

  cy.visitWithSemantics("/psw/psw-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdocuments-screen").should("be.visible");
  cy.getCy("pswdocuments-title").should("be.visible");
  cy.getCy("pswdocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_documents");

  cy.visitWithSemantics("/psw/shift-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shifttasks-screen").should("be.visible");
  cy.getCy("shifttasks-title").should("be.visible");
  cy.getCy("shifttasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shift_tasks");

  cy.visitWithSemantics("/psw/visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("visitnotes-screen").should("be.visible");
  cy.getCy("visitnotes-title").should("be.visible");
  cy.getCy("visitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("visit_notes");

  cy.visitWithSemantics("/psw/vitals-entry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalsentry-screen").should("be.visible");
  cy.getCy("vitalsentry-title").should("be.visible");
  cy.getCy("vitalsentry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vitals_entry");

  cy.visitWithSemantics("/psw/incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreport-screen").should("be.visible");
  cy.getCy("incidentreport-title").should("be.visible");
  cy.getCy("incidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_report");
  });

  it("tests org role hsw", () => {
    cy.loginAsRole("hsw");

  cy.visitWithSemantics("/clinical/hsw-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswdashboard-screen").should("be.visible");
  cy.getCy("hswdashboard-title").should("be.visible");
  cy.getCy("hswdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_dashboard");

  cy.visitWithSemantics("/clinical/hsw-adl-logger");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswadllogger-screen").should("be.visible");
  cy.getCy("hswadllogger-title").should("be.visible");
  cy.getCy("hswadllogger-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_adl_logger");

  cy.visitWithSemantics("/clinical/hsw-care-plans");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswcareplans-screen").should("be.visible");
  cy.getCy("hswcareplans-title").should("be.visible");
  cy.getCy("hswcareplans-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_care_plans");

  cy.visitWithSemantics("/clinical/hsw-incident-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswincidentreports-screen").should("be.visible");
  cy.getCy("hswincidentreports-title").should("be.visible");
  cy.getCy("hswincidentreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_incident_reports");

  cy.visitWithSemantics("/clinical/hsw-schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswschedule-screen").should("be.visible");
  cy.getCy("hswschedule-title").should("be.visible");
  cy.getCy("hswschedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_schedule");
  });

  it("tests org role rn_field_supervisor", () => {
    cy.loginAsRole("rn_field_supervisor");

  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");

  cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor analytics-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");

  cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor compliance workflow-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");
  });

  it("tests org role np", () => {
    cy.loginAsRole("np");

  cy.visitWithSemantics("/clinical/np-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npdashboard-screen").should("be.visible");
  cy.getCy("npdashboard-title").should("be.visible");
  cy.getCy("npdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_dashboard");

  cy.visitWithSemantics("/rn/np-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nurse practitioner (np) analytics-screen").should("be.visible");
  cy.getCy("nurse practitioner (np) analytics-title").should("be.visible");
  cy.getCy("nurse practitioner (np) analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_analytics");

  cy.visitWithSemantics("/rn/np-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nurse practitioner (np) compliance workflow-screen").should("be.visible");
  cy.getCy("nurse practitioner (np) compliance workflow-title").should("be.visible");
  cy.getCy("nurse practitioner (np) compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_workflow");
  });

  it("tests org role rpn", () => {
    cy.loginAsRole("rpn");

  cy.visitWithSemantics("/rpn/rpn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpndashboard-screen").should("be.visible");
  cy.getCy("rpndashboard-title").should("be.visible");
  cy.getCy("rpndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_dashboard");

  cy.visitWithSemantics("/rpn/rpn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnanalytics-screen").should("be.visible");
  cy.getCy("rpnanalytics-title").should("be.visible");
  cy.getCy("rpnanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_analytics");

  cy.visitWithSemantics("/rpn/rpn-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncompliance-screen").should("be.visible");
  cy.getCy("rpncompliance-title").should("be.visible");
  cy.getCy("rpncompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_compliance");

  cy.visitWithSemantics("/rpn/rpn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnworkflow-screen").should("be.visible");
  cy.getCy("rpnworkflow-title").should("be.visible");
  cy.getCy("rpnworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_workflow");

  cy.visitWithSemantics("/rpn/rpn-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncommandcenter-screen").should("be.visible");
  cy.getCy("rpncommandcenter-title").should("be.visible");
  cy.getCy("rpncommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_command_center");

  cy.visitWithSemantics("/rpn/rpn-patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnpatientcharting-screen").should("be.visible");
  cy.getCy("rpnpatientcharting-title").should("be.visible");
  cy.getCy("rpnpatientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_patient_charting");

  cy.visitWithSemantics("/rpn/rpn-medications");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnmedications-screen").should("be.visible");
  cy.getCy("rpnmedications-title").should("be.visible");
  cy.getCy("rpnmedications-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_medications");

  cy.visitWithSemantics("/rpn/rpn-vitals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnvitals-screen").should("be.visible");
  cy.getCy("rpnvitals-title").should("be.visible");
  cy.getCy("rpnvitals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_vitals");

  cy.visitWithSemantics("/rpn/rpn-care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncareplanreview-screen").should("be.visible");
  cy.getCy("rpncareplanreview-title").should("be.visible");
  cy.getCy("rpncareplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_care_plan_review");

  cy.visitWithSemantics("/rpn/rpn-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnincidentreview-screen").should("be.visible");
  cy.getCy("rpnincidentreview-title").should("be.visible");
  cy.getCy("rpnincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_incident_review");

  cy.visitWithSemantics("/rpn/rpn-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpntasks-screen").should("be.visible");
  cy.getCy("rpntasks-title").should("be.visible");
  cy.getCy("rpntasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_tasks");

  cy.visitWithSemantics("/rpn/rpn-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnreports-screen").should("be.visible");
  cy.getCy("rpnreports-title").should("be.visible");
  cy.getCy("rpnreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_reports");

  cy.visitWithSemantics("/clinical/nursing-task");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nursingtask-screen").should("be.visible");
  cy.getCy("nursingtask-title").should("be.visible");
  cy.getCy("nursingtask-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("nursing_task");

  cy.visitWithSemantics("/clinical/vitals-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalstracking-screen").should("be.visible");
  cy.getCy("vitalstracking-title").should("be.visible");
  cy.getCy("vitalstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vitals_tracking");

  cy.visitWithSemantics("/clinical/medication");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medication-screen").should("be.visible");
  cy.getCy("medication-title").should("be.visible");
  cy.getCy("medication-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("medication");

  cy.visitWithSemantics("/clinical/patient-observation");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientobservation-screen").should("be.visible");
  cy.getCy("patientobservation-title").should("be.visible");
  cy.getCy("patientobservation-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_observation");
  });

  it("tests org role lpn", () => {
    cy.loginAsRole("lpn");

  cy.visitWithSemantics("/clinical/lpn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpndashboard-screen").should("be.visible");
  cy.getCy("lpndashboard-title").should("be.visible");
  cy.getCy("lpndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_dashboard");

  cy.visitWithSemantics("/rpn/lpn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("licensed practical nurse (lpn) analytics-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_analytics");

  cy.visitWithSemantics("/rpn/lpn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("licensed practical nurse (lpn) compliance workflow-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_workflow");
  });

  it("tests org role employee", () => {
    cy.loginAsRole("employee");

  cy.visitWithSemantics("/staff/employee-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeedashboard-screen").should("be.visible");
  cy.getCy("employeedashboard-title").should("be.visible");
  cy.getCy("employeedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_dashboard");

  cy.visitWithSemantics("/staff/employee-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employee analytics-screen").should("be.visible");
  cy.getCy("employee analytics-title").should("be.visible");
  cy.getCy("employee analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_analytics");

  cy.visitWithSemantics("/staff/employee-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employee compliance workflow-screen").should("be.visible");
  cy.getCy("employee compliance workflow-title").should("be.visible");
  cy.getCy("employee compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_workflow");
  });

  it("tests org role volunteer", () => {
    cy.loginAsRole("volunteer");

  cy.visitWithSemantics("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visitWithSemantics("/staff/volunteer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteerdashboard-screen").should("be.visible");
  cy.getCy("volunteerdashboard-title").should("be.visible");
  cy.getCy("volunteerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_dashboard");

  cy.visitWithSemantics("/staff/volunteer-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatoranalytics-screen").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-title").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_analytics");

  cy.visitWithSemantics("/staff/volunteer-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorcompliance-screen").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-title").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_compliance");

  cy.visitWithSemantics("/staff/volunteer-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorworkflow-screen").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-title").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_workflow");

  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");

  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");

  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");

  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");
  });

  it("tests org role admin", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/common/office-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officedashboard-screen").should("be.visible");
  cy.getCy("officedashboard-title").should("be.visible");
  cy.getCy("officedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_dashboard");

  cy.visitWithSemantics("/staff/billing-admin-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmindashboard-screen").should("be.visible");
  cy.getCy("billingadmindashboard-title").should("be.visible");
  cy.getCy("billingadmindashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_dashboard");

  cy.visitWithSemantics("/staff/receptionist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistdashboard-screen").should("be.visible");
  cy.getCy("receptionistdashboard-title").should("be.visible");
  cy.getCy("receptionistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_dashboard");

  cy.visitWithSemantics("/common/office-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeanalytics-screen").should("be.visible");
  cy.getCy("officeanalytics-title").should("be.visible");
  cy.getCy("officeanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_analytics");

  cy.visitWithSemantics("/common/office-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officecompliance-screen").should("be.visible");
  cy.getCy("officecompliance-title").should("be.visible");
  cy.getCy("officecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_compliance");

  cy.visitWithSemantics("/common/office-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeworkflow-screen").should("be.visible");
  cy.getCy("officeworkflow-title").should("be.visible");
  cy.getCy("officeworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_workflow");

  cy.visitWithSemantics("/staff/billing-admin-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminanalytics-screen").should("be.visible");
  cy.getCy("billingadminanalytics-title").should("be.visible");
  cy.getCy("billingadminanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_analytics");

  cy.visitWithSemantics("/staff/billing-admin-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmincompliance-screen").should("be.visible");
  cy.getCy("billingadmincompliance-title").should("be.visible");
  cy.getCy("billingadmincompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_compliance");

  cy.visitWithSemantics("/staff/billing-admin-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminworkflow-screen").should("be.visible");
  cy.getCy("billingadminworkflow-title").should("be.visible");
  cy.getCy("billingadminworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_workflow");

  cy.visitWithSemantics("/staff/receptionist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistanalytics-screen").should("be.visible");
  cy.getCy("receptionistanalytics-title").should("be.visible");
  cy.getCy("receptionistanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_analytics");

  cy.visitWithSemantics("/staff/receptionist-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcompliance-screen").should("be.visible");
  cy.getCy("receptionistcompliance-title").should("be.visible");
  cy.getCy("receptionistcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_compliance");

  cy.visitWithSemantics("/staff/receptionist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistworkflow-screen").should("be.visible");
  cy.getCy("receptionistworkflow-title").should("be.visible");
  cy.getCy("receptionistworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_workflow");

  cy.visitWithSemantics("/staff/invoice-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("invoicemanagement-screen").should("be.visible");
  cy.getCy("invoicemanagement-title").should("be.visible");
  cy.getCy("invoicemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("invoice_management");

  cy.visitWithSemantics("/staff/claims-processing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("claimsprocessing-screen").should("be.visible");
  cy.getCy("claimsprocessing-title").should("be.visible");
  cy.getCy("claimsprocessing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("claims_processing");

  cy.visitWithSemantics("/staff/payment-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("paymenttracking-screen").should("be.visible");
  cy.getCy("paymenttracking-title").should("be.visible");
  cy.getCy("paymenttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("payment_tracking");

  cy.visitWithSemantics("/staff/refund-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("refundmanagement-screen").should("be.visible");
  cy.getCy("refundmanagement-title").should("be.visible");
  cy.getCy("refundmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("refund_management");
  });

  it("tests org role scheduler", () => {
    cy.loginAsRole("scheduler");

  cy.visitWithSemantics("/staff/scheduler-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerdashboard-screen").should("be.visible");
  cy.getCy("schedulerdashboard-title").should("be.visible");
  cy.getCy("schedulerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_dashboard");

  cy.visitWithSemantics("/staff/coordinator-dispatch-map");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatordispatchmap-screen").should("be.visible");
  cy.getCy("coordinatordispatchmap-title").should("be.visible");
  cy.getCy("coordinatordispatchmap-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_dispatch_map");

  cy.visitWithSemantics("/staff/coordinator-hub");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorhub-screen").should("be.visible");
  cy.getCy("coordinatorhub-title").should("be.visible");
  cy.getCy("coordinatorhub-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_hub");

  cy.visitWithSemantics("/staff/coordinator-sos");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorsos-screen").should("be.visible");
  cy.getCy("coordinatorsos-title").should("be.visible");
  cy.getCy("coordinatorsos-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_sos");

  cy.visitWithSemantics("/staff/coordinator-waitlist");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorwaitlist-screen").should("be.visible");
  cy.getCy("coordinatorwaitlist-title").should("be.visible");
  cy.getCy("coordinatorwaitlist-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_waitlist");

  cy.visitWithSemantics("/staff/scheduler-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleranalytics-screen").should("be.visible");
  cy.getCy("scheduleranalytics-title").should("be.visible");
  cy.getCy("scheduleranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_analytics");

  cy.visitWithSemantics("/staff/scheduler-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercompliance-screen").should("be.visible");
  cy.getCy("schedulercompliance-title").should("be.visible");
  cy.getCy("schedulercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_compliance");

  cy.visitWithSemantics("/staff/scheduler-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerworkflow-screen").should("be.visible");
  cy.getCy("schedulerworkflow-title").should("be.visible");
  cy.getCy("schedulerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_workflow");

  cy.visitWithSemantics("/staff/scheduler-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercommandcenter-screen").should("be.visible");
  cy.getCy("schedulercommandcenter-title").should("be.visible");
  cy.getCy("schedulercommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_command_center");

  cy.visitWithSemantics("/staff/scheduler-calendar");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercalendar-screen").should("be.visible");
  cy.getCy("schedulercalendar-title").should("be.visible");
  cy.getCy("schedulercalendar-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_calendar");

  cy.visitWithSemantics("/staff/scheduler-booking-requests");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerbookingrequests-screen").should("be.visible");
  cy.getCy("schedulerbookingrequests-title").should("be.visible");
  cy.getCy("schedulerbookingrequests-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_booking_requests");

  cy.visitWithSemantics("/staff/scheduler-conflicts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerconflicts-screen").should("be.visible");
  cy.getCy("schedulerconflicts-title").should("be.visible");
  cy.getCy("schedulerconflicts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_conflicts");

  cy.visitWithSemantics("/staff/scheduler-open-shifts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleropenshifts-screen").should("be.visible");
  cy.getCy("scheduleropenshifts-title").should("be.visible");
  cy.getCy("scheduleropenshifts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_open_shifts");

  cy.visitWithSemantics("/staff/scheduler-provider-availability");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerprovideravailability-screen").should("be.visible");
  cy.getCy("schedulerprovideravailability-title").should("be.visible");
  cy.getCy("schedulerprovideravailability-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_provider_availability");

  cy.visitWithSemantics("/staff/scheduling-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingdashboard-screen").should("be.visible");
  cy.getCy("schedulingdashboard-title").should("be.visible");
  cy.getCy("schedulingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_dashboard");

  cy.visitWithSemantics("/staff/calendar-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("calendarmanagement-screen").should("be.visible");
  cy.getCy("calendarmanagement-title").should("be.visible");
  cy.getCy("calendarmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("calendar_management");

  cy.visitWithSemantics("/staff/conflict-resolution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("conflictresolution-screen").should("be.visible");
  cy.getCy("conflictresolution-title").should("be.visible");
  cy.getCy("conflictresolution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("conflict_resolution");

  cy.visitWithSemantics("/staff/open-shift");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("openshift-screen").should("be.visible");
  cy.getCy("openshift-title").should("be.visible");
  cy.getCy("openshift-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("open_shift");

  cy.visitWithSemantics("/staff/scheduling-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingoperations4k-screen").should("be.visible");
  cy.getCy("schedulingoperations4k-title").should("be.visible");
  cy.getCy("schedulingoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_operations4_k");
  });

  it("tests org role customer_support", () => {
    cy.loginAsRole("customer_support");

  cy.visitWithSemantics("/common/customer-support-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportanalytics-screen").should("be.visible");
  cy.getCy("customersupportanalytics-title").should("be.visible");
  cy.getCy("customersupportanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_analytics");

  cy.visitWithSemantics("/common/customer-support-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportcompliance-screen").should("be.visible");
  cy.getCy("customersupportcompliance-title").should("be.visible");
  cy.getCy("customersupportcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_compliance");

  cy.visitWithSemantics("/common/customer-support-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportworkflow-screen").should("be.visible");
  cy.getCy("customersupportworkflow-title").should("be.visible");
  cy.getCy("customersupportworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_workflow");

  cy.visitWithSemantics("/common/support-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportanalytics-screen").should("be.visible");
  cy.getCy("supportanalytics-title").should("be.visible");
  cy.getCy("supportanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_analytics");

  cy.visitWithSemantics("/common/support-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportcompliance-screen").should("be.visible");
  cy.getCy("supportcompliance-title").should("be.visible");
  cy.getCy("supportcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_compliance");

  cy.visitWithSemantics("/common/support-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportworkflow-screen").should("be.visible");
  cy.getCy("supportworkflow-title").should("be.visible");
  cy.getCy("supportworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_workflow");

  cy.visitWithSemantics("/staff/ticket-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ticketmanagement-screen").should("be.visible");
  cy.getCy("ticketmanagement-title").should("be.visible");
  cy.getCy("ticketmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ticket_management");

  cy.visitWithSemantics("/staff/client-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientissue-screen").should("be.visible");
  cy.getCy("clientissue-title").should("be.visible");
  cy.getCy("clientissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_issue");

  cy.visitWithSemantics("/staff/communication");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communication-screen").should("be.visible");
  cy.getCy("communication-title").should("be.visible");
  cy.getCy("communication-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("communication");

  cy.visitWithSemantics("/staff/resolution-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("resolutiontracking-screen").should("be.visible");
  cy.getCy("resolutiontracking-title").should("be.visible");
  cy.getCy("resolutiontracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("resolution_tracking");
  });

  it("tests org role training_coordinator", () => {
    cy.loginAsRole("training_coordinator");

  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_dashboard");

  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_assignment");

  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("certification_tracking");

  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_progress");
  });

  it("tests org role qa_specialist", () => {
    cy.loginAsRole("qa_specialist");

  cy.visitWithSemantics("/common/qa-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaanalytics-screen").should("be.visible");
  cy.getCy("qaanalytics-title").should("be.visible");
  cy.getCy("qaanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_analytics");

  cy.visitWithSemantics("/common/qa-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qacompliance-screen").should("be.visible");
  cy.getCy("qacompliance-title").should("be.visible");
  cy.getCy("qacompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_compliance");

  cy.visitWithSemantics("/common/qa-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaworkflow-screen").should("be.visible");
  cy.getCy("qaworkflow-title").should("be.visible");
  cy.getCy("qaworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_workflow");

  cy.visitWithSemantics("/staff/quality-assurance-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceanalytics-screen").should("be.visible");
  cy.getCy("qualityassuranceanalytics-title").should("be.visible");
  cy.getCy("qualityassuranceanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_analytics");

  cy.visitWithSemantics("/staff/quality-assurance-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecompliance-screen").should("be.visible");
  cy.getCy("qualityassurancecompliance-title").should("be.visible");
  cy.getCy("qualityassurancecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance");

  cy.visitWithSemantics("/staff/quality-assurance-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceworkflow-screen").should("be.visible");
  cy.getCy("qualityassuranceworkflow-title").should("be.visible");
  cy.getCy("qualityassuranceworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_workflow");

  cy.visitWithSemantics("/staff/quality-audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityaudit-screen").should("be.visible");
  cy.getCy("qualityaudit-title").should("be.visible");
  cy.getCy("qualityaudit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_audit");

  cy.visitWithSemantics("/staff/failed-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("failedworkflow-screen").should("be.visible");
  cy.getCy("failedworkflow-title").should("be.visible");
  cy.getCy("failedworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("failed_workflow");

  cy.visitWithSemantics("/staff/testing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("testingoverview-screen").should("be.visible");
  cy.getCy("testingoverview-title").should("be.visible");
  cy.getCy("testingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("testing_overview");

  cy.visitWithSemantics("/staff/defect-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("defecttracking-screen").should("be.visible");
  cy.getCy("defecttracking-title").should("be.visible");
  cy.getCy("defecttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("defect_tracking");
  });

  it("tests org role family", () => {
    cy.loginAsRole("family");

  cy.visitWithSemantics("/common/family-member-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberanalytics-screen").should("be.visible");
  cy.getCy("familymemberanalytics-title").should("be.visible");
  cy.getCy("familymemberanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_analytics");

  cy.visitWithSemantics("/common/family-member-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercompliance-screen").should("be.visible");
  cy.getCy("familymembercompliance-title").should("be.visible");
  cy.getCy("familymembercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_compliance");

  cy.visitWithSemantics("/common/family-member-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberworkflow-screen").should("be.visible");
  cy.getCy("familymemberworkflow-title").should("be.visible");
  cy.getCy("familymemberworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_workflow");

  cy.visitWithSemantics("/common/family-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyoverview-screen").should("be.visible");
  cy.getCy("familyoverview-title").should("be.visible");
  cy.getCy("familyoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_overview");

  cy.visitWithSemantics("/common/care-updates");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careupdates-screen").should("be.visible");
  cy.getCy("careupdates-title").should("be.visible");
  cy.getCy("careupdates-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_updates");

  cy.visitWithSemantics("/common/billing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingoverview-screen").should("be.visible");
  cy.getCy("billingoverview-title").should("be.visible");
  cy.getCy("billingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_overview");

  cy.visitWithSemantics("/common/emergency-contacts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emergencycontacts-screen").should("be.visible");
  cy.getCy("emergencycontacts-title").should("be.visible");
  cy.getCy("emergencycontacts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("emergency_contacts");
  });

});
