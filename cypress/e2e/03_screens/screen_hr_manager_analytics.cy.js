// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_manager_analytics", () => {
  it("opens and verifies screen hr_manager_analytics", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/staff/hr-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanageranalytics-screen").should("be.visible");
  cy.getCy("hrmanageranalytics-title").should("be.visible");
  cy.getCy("hrmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_analytics");

  });
});
