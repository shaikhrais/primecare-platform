// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_dashboard", () => {
  it("opens and verifies screen family_member_dashboard", () => {
    cy.loginAsRole("patient");

  cy.visitWithSemantics("/common/family-member-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");

  });
});
