// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_approvals", () => {
  it("opens and verifies screen clinical_director_approvals", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/clinical-director-approvals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorapprovals-screen").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-title").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_approvals");

  });
});
