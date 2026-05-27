// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_compliance", () => {
  it("opens and verifies screen clinical_director_compliance", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/clinical-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");

  });
});
