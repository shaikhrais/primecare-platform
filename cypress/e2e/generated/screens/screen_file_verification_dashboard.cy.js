// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - file_verification_dashboard", () => {
  it("opens and verifies screen file_verification_dashboard", () => {
    cy.loginAsRole("governance");

  cy.visit("/common/file-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");

  });
});
