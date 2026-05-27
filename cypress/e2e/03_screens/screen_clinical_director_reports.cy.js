// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_reports", () => {
  it("opens and verifies screen clinical_director_reports", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/clinical-director-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorreports-screen").should("be.visible");
  cy.getCy("clinicaldirectorreports-title").should("be.visible");
  cy.getCy("clinicaldirectorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");

  });
});
