// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - treatment_notes", () => {
  it("opens and verifies screen treatment_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Treatment Notes)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Treatment Notes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentnotes-screen").should("be.visible");
  cy.getCy("treatmentnotes-title").should("be.visible");
  cy.getCy("treatmentnotes-content").should("be.visible");
  cy.getCy("treatment-notes-monitor").should("be.visible");
  cy.getCy("compliance-scan-trigger").should("be.visible");
  cy.getCy("telemetry-data-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Treatment Notes...");
  cy.waitAndSee();
  cy.screenshot("treatment_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified Treatment Notes successfully!\n");

  });
});
