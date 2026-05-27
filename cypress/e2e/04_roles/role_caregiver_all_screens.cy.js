// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - caregiver", () => {
  it("tests all screens for role caregiver", () => {
    cy.loginAsRole("caregiver");


  cy.visit("/common/caregiver-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverdashboard-screen").should("be.visible");
  cy.getCy("caregiverdashboard-title").should("be.visible");
  cy.getCy("caregiverdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_dashboard");

  cy.visit("/psw/caregiver-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivertasks-screen").should("be.visible");
  cy.getCy("caregivertasks-title").should("be.visible");
  cy.getCy("caregivertasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_tasks");

  cy.visit("/psw/caregiver-client-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverclientprofile-screen").should("be.visible");
  cy.getCy("caregiverclientprofile-title").should("be.visible");
  cy.getCy("caregiverclientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_client_profile");

  cy.visit("/psw/caregiver-visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivervisitnotes-screen").should("be.visible");
  cy.getCy("caregivervisitnotes-title").should("be.visible");
  cy.getCy("caregivervisitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_visit_notes");

  cy.visit("/psw/caregiver-schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverschedule-screen").should("be.visible");
  cy.getCy("caregiverschedule-title").should("be.visible");
  cy.getCy("caregiverschedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_schedule");

  cy.visit("/psw/caregiver-incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverincidentreport-screen").should("be.visible");
  cy.getCy("caregiverincidentreport-title").should("be.visible");
  cy.getCy("caregiverincidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_incident_report");

  cy.visit("/psw/schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedule-screen").should("be.visible");
  cy.getCy("schedule-title").should("be.visible");
  cy.getCy("schedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("schedule");

  cy.visit("/psw/messaging");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("messaging-screen").should("be.visible");
  cy.getCy("messaging-title").should("be.visible");
  cy.getCy("messaging-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("messaging");

  });
});
