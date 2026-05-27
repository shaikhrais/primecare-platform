// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vip_manager_dashboard", () => {
  it("opens and verifies screen vip_manager_dashboard", () => {
    cy.loginAsRole("vip_manager");

  cy.visit("/management/vip-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerdashboard-screen").should("be.visible");
  cy.getCy("vipmanagerdashboard-title").should("be.visible");
  cy.getCy("vipmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_dashboard");

  });
});
