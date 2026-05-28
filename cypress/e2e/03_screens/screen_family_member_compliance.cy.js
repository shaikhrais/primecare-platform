// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_compliance", () => {
  it("opens and verifies screen family_member_compliance", () => {
    cy.loginAsRole("family");

  cy.visitWithSemantics("/common/family-member-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercompliance-screen").should("be.visible");
  cy.getCy("familymembercompliance-title").should("be.visible");
  cy.getCy("familymembercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_compliance");

  });
});
