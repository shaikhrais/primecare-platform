// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cto", () => {
  it("tests all screens for role cto", () => {
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
});
