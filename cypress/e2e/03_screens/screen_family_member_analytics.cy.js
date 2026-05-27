// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_analytics", () => {
  it("opens and verifies screen family_member_analytics", () => {
    cy.loginAsRole("family");

  cy.visit("/common/family-member-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberanalytics-screen").should("be.visible");
  cy.getCy("familymemberanalytics-title").should("be.visible");
  cy.getCy("familymemberanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_analytics");

  });
});
