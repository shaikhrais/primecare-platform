// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - hr_director", () => {
  it("tests all screens for role hr_director", () => {
    cy.loginAsRole("hr_director");


  cy.visit("/executive/hr-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");

  cy.visit("/staff/hr-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");

  cy.visit("/executive/hr-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoranalytics-screen").should("be.visible");
  cy.getCy("hrdirectoranalytics-title").should("be.visible");
  cy.getCy("hrdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_analytics");

  cy.visit("/executive/hr-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcompliance-screen").should("be.visible");
  cy.getCy("hrdirectorcompliance-title").should("be.visible");
  cy.getCy("hrdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_compliance");

  cy.visit("/executive/hr-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorworkflow-screen").should("be.visible");
  cy.getCy("hrdirectorworkflow-title").should("be.visible");
  cy.getCy("hrdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_workflow");

  cy.visit("/staff/hr-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanageranalytics-screen").should("be.visible");
  cy.getCy("hrmanageranalytics-title").should("be.visible");
  cy.getCy("hrmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_analytics");

  cy.visit("/staff/hr-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagercompliance-screen").should("be.visible");
  cy.getCy("hrmanagercompliance-title").should("be.visible");
  cy.getCy("hrmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_compliance");

  cy.visit("/staff/hr-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerworkflow-screen").should("be.visible");
  cy.getCy("hrmanagerworkflow-title").should("be.visible");
  cy.getCy("hrmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_workflow");

  cy.visit("/executive/hr-director-hiring-pipeline");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorhiringpipeline-screen").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-title").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_hiring_pipeline");

  cy.visit("/executive/hr-director-staff-files");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
  cy.getCy("hrdirectorstafffiles-title").should("be.visible");
  cy.getCy("hrdirectorstafffiles-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_staff_files");

  cy.visit("/executive/hr-director-training");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectortraining-screen").should("be.visible");
  cy.getCy("hrdirectortraining-title").should("be.visible");
  cy.getCy("hrdirectortraining-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_training");

  cy.visit("/executive/hr-director-credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_credential_expiry");

  cy.visit("/executive/hr-director-onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoronboarding-screen").should("be.visible");
  cy.getCy("hrdirectoronboarding-title").should("be.visible");
  cy.getCy("hrdirectoronboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_onboarding");

  cy.visit("/management/hiring-pipeline");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hiringpipeline-screen").should("be.visible");
  cy.getCy("hiringpipeline-title").should("be.visible");
  cy.getCy("hiringpipeline-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hiring_pipeline");

  cy.visit("/management/employee-records");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeerecords-screen").should("be.visible");
  cy.getCy("employeerecords-title").should("be.visible");
  cy.getCy("employeerecords-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_records");

  cy.visit("/management/credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialexpiry-screen").should("be.visible");
  cy.getCy("credentialexpiry-title").should("be.visible");
  cy.getCy("credentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("credential_expiry");

  cy.visit("/management/training-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingmanagement-screen").should("be.visible");
  cy.getCy("trainingmanagement-title").should("be.visible");
  cy.getCy("trainingmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_management");

  cy.visit("/management/onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboarding-screen").should("be.visible");
  cy.getCy("onboarding-title").should("be.visible");
  cy.getCy("onboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("onboarding");

  });
});
