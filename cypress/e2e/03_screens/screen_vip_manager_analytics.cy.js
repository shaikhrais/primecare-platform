// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vip_manager_analytics", () => {
  it("opens and verifies screen vip_manager_analytics", () => {
    cy.loginAsRole("vip_manager");

  cy.visitWithSemantics("/executive/vip-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vip client manager analytics-screen").should("be.visible");
  cy.getCy("vip client manager analytics-title").should("be.visible");
  cy.getCy("vip client manager analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_analytics");

  });
});
