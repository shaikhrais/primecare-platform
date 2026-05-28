// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_dashboard", () => {
  it("opens and verifies screen head_of_marketing_dashboard", () => {
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

  });
});
