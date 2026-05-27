// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - patient", () => {
  it("tests all screens for role patient", () => {
    cy.loginAsRole("patient");


  cy.visit("/common/family-member-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");

  cy.visit("/common/patient-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdashboard-screen").should("be.visible");
  cy.getCy("patientdashboard-title").should("be.visible");
  cy.getCy("patientdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_dashboard");

  cy.visit("/common/patient-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientanalytics-screen").should("be.visible");
  cy.getCy("patientanalytics-title").should("be.visible");
  cy.getCy("patientanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_analytics");

  cy.visit("/common/patient-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcompliance-screen").should("be.visible");
  cy.getCy("patientcompliance-title").should("be.visible");
  cy.getCy("patientcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_compliance");

  cy.visit("/common/patient-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientworkflow-screen").should("be.visible");
  cy.getCy("patientworkflow-title").should("be.visible");
  cy.getCy("patientworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_workflow");

  cy.visit("/common/patient-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcommandcenter-screen").should("be.visible");
  cy.getCy("patientcommandcenter-title").should("be.visible");
  cy.getCy("patientcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_command_center");

  cy.visit("/common/patient-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientappointments-screen").should("be.visible");
  cy.getCy("patientappointments-title").should("be.visible");
  cy.getCy("patientappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_appointments");

  cy.visit("/common/patient-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcareplan-screen").should("be.visible");
  cy.getCy("patientcareplan-title").should("be.visible");
  cy.getCy("patientcareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_care_plan");

  cy.visit("/common/patient-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientmessages-screen").should("be.visible");
  cy.getCy("patientmessages-title").should("be.visible");
  cy.getCy("patientmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_messages");

  cy.visit("/common/patient-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdocuments-screen").should("be.visible");
  cy.getCy("patientdocuments-title").should("be.visible");
  cy.getCy("patientdocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_documents");

  cy.visit("/common/patient-billing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientbilling-screen").should("be.visible");
  cy.getCy("patientbilling-title").should("be.visible");
  cy.getCy("patientbilling-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_billing");

  cy.visit("/common/patient-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientprofile-screen").should("be.visible");
  cy.getCy("patientprofile-title").should("be.visible");
  cy.getCy("patientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_profile");

  cy.visit("/common/appointment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointment-screen").should("be.visible");
  cy.getCy("appointment-title").should("be.visible");
  cy.getCy("appointment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("appointment");

  cy.visit("/common/care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplan-screen").should("be.visible");
  cy.getCy("careplan-title").should("be.visible");
  cy.getCy("careplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_plan");

  cy.visit("/common/billing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billing-screen").should("be.visible");
  cy.getCy("billing-title").should("be.visible");
  cy.getCy("billing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing");

  cy.visit("/common/documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("documents-screen").should("be.visible");
  cy.getCy("documents-title").should("be.visible");
  cy.getCy("documents-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("documents");

  });
});
