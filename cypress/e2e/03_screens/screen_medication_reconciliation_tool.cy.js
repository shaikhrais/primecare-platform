// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medication_reconciliation_tool", () => {
  it("opens and verifies screen medication_reconciliation_tool", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Medication Reconciliation Tool)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Medication Reconciliation Tool...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medicationreconciliationtool-screen").should("be.visible");
  cy.getCy("medicationreconciliationtool-title").should("be.visible");
  cy.getCy("medicationreconciliationtool-content").should("be.visible");
  cy.getCy("medication-history-input").should("be.visible");
  cy.getCy("current-medications-review").should("be.visible");
  cy.getCy("discrepancy-identifier").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Medication Reconciliation Tool...");
  cy.waitAndSee();
  cy.screenshot("medication_reconciliation_tool");
  
  cy.task("log", "✅ PROGRESS: - Verified Medication Reconciliation Tool successfully!\n");

  });
});
