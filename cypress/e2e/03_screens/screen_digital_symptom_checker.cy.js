// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - digital_symptom_checker", () => {
  it("opens and verifies screen digital_symptom_checker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Digital Symptom Checker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Digital Symptom Checker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("digitalsymptomchecker-screen").should("be.visible");
  cy.getCy("digitalsymptomchecker-title").should("be.visible");
  cy.getCy("digitalsymptomchecker-content").should("be.visible");
  cy.getCy("symptom-input").should("be.visible");
  cy.getCy("submit-button").should("be.visible");
  cy.getCy("save-button").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Digital Symptom Checker...");
  cy.waitAndSee();
  cy.screenshot("digital_symptom_checker");
  
  cy.task("log", "✅ PROGRESS: - Verified Digital Symptom Checker successfully!\n");

  });
});
