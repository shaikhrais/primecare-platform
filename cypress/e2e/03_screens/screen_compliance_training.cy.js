// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_training", () => {
  it("opens and verifies screen compliance_training", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Training)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Training...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancetraining-screen").should("be.visible");
  cy.getCy("compliancetraining-title").should("be.visible");
  cy.getCy("compliancetraining-content").should("be.visible");
  cy.getCy("compliance-training-btn-submit-assessment").should("be.visible");
  cy.getCy("compliance-training-btn-review-docs").should("be.visible");
  cy.getCy("compliance-training-btn-track-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Training...");
  cy.waitAndSee();
  cy.screenshot("compliance_training");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Training successfully!\n");

  });
});
