// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_staff_files", () => {
  it("opens and verifies screen hr_director_staff_files", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/executive/hr-director-staff-files");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
  cy.getCy("hrdirectorstafffiles-title").should("be.visible");
  cy.getCy("hrdirectorstafffiles-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_staff_files");

  });
});
