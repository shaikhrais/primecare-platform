// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_vitals", () => {
  it("opens and verifies screen rn_vitals", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/vitals (RnVitalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/vitals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnVitalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnvitals-screen").should("be.visible");
  cy.getCy("rnvitals-title").should("be.visible");
  cy.getCy("rnvitals-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnVitalsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_vitals");
  
  cy.task("log", "✅ PROGRESS: - Verified RnVitalsScreen successfully!\n");

  });
});
