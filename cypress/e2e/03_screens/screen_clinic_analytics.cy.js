// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_analytics", () => {
  it("opens and verifies screen clinic_analytics", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/common/clinic-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicanalytics-screen").should("be.visible");
  cy.getCy("clinicanalytics-title").should("be.visible");
  cy.getCy("clinicanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_analytics");

  });
});
