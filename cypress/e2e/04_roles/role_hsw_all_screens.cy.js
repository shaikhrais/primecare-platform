// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - hsw", () => {
  it("tests all screens for role hsw", () => {
    cy.loginAsRole("hsw");


  cy.visit("/clinical/hsw-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswdashboard-screen").should("be.visible");
  cy.getCy("hswdashboard-title").should("be.visible");
  cy.getCy("hswdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_dashboard");

  cy.visit("/clinical/hsw-adl-logger");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswadllogger-screen").should("be.visible");
  cy.getCy("hswadllogger-title").should("be.visible");
  cy.getCy("hswadllogger-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_adl_logger");

  cy.visit("/clinical/hsw-care-plans");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswcareplans-screen").should("be.visible");
  cy.getCy("hswcareplans-title").should("be.visible");
  cy.getCy("hswcareplans-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_care_plans");

  cy.visit("/clinical/hsw-incident-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswincidentreports-screen").should("be.visible");
  cy.getCy("hswincidentreports-title").should("be.visible");
  cy.getCy("hswincidentreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_incident_reports");

  cy.visit("/clinical/hsw-schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswschedule-screen").should("be.visible");
  cy.getCy("hswschedule-title").should("be.visible");
  cy.getCy("hswschedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_schedule");

  });
});
