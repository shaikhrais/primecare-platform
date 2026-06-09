// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_training_tracker", () => {
  it("opens and verifies screen compliance_training_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Training Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Training Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancetrainingtracker-screen").should("be.visible");
  cy.getCy("compliancetrainingtracker-title").should("be.visible");
  cy.getCy("compliancetrainingtracker-content").should("be.visible");
  cy.getCy("compliance-training-refresh").should("be.visible");
  cy.getCy("compliance-training-send-reminders").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Training Tracker...");
  cy.waitAndSee();
  cy.screenshot("compliance_training_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Training Tracker successfully!\n");

  });
});
