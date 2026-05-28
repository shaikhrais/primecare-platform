// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_compliance", () => {
  it("opens and verifies screen clinic_compliance", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/common/clinic-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cliniccompliance-screen").should("be.visible");
  cy.getCy("cliniccompliance-title").should("be.visible");
  cy.getCy("cliniccompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_compliance");

  });
});
