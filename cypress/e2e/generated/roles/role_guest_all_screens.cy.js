// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - guest", () => {
  it("tests all screens for role guest", () => {
    cy.loginAsRole("guest");


  cy.visit("/common/dynamic-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicdashboard-screen").should("be.visible");
  cy.getCy("dynamicdashboard-title").should("be.visible");
  cy.getCy("dynamicdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_screen_dashboard");

  cy.visit("/common/guest-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestdashboard-screen").should("be.visible");
  cy.getCy("guestdashboard-title").should("be.visible");
  cy.getCy("guestdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_dashboard");

  cy.visit("/common/guest-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestanalytics-screen").should("be.visible");
  cy.getCy("guestanalytics-title").should("be.visible");
  cy.getCy("guestanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_analytics");

  cy.visit("/common/guest-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestcompliance-screen").should("be.visible");
  cy.getCy("guestcompliance-title").should("be.visible");
  cy.getCy("guestcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_compliance");

  cy.visit("/common/guest-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestworkflow-screen").should("be.visible");
  cy.getCy("guestworkflow-title").should("be.visible");
  cy.getCy("guestworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_workflow");

  });
});
