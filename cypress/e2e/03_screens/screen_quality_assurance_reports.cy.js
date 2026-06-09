// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_reports", () => {
  it("opens and verifies screen quality_assurance_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancereports-screen").should("be.visible");
  cy.getCy("qualityassurancereports-title").should("be.visible");
  cy.getCy("qualityassurancereports-content").should("be.visible");
  cy.getCy("qa-reports-btn-submit").should("be.visible");
  cy.getCy("qa-reports-btn-generate").should("be.visible");
  cy.getCy("qa-reports-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Reports...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Reports successfully!\n");

  });
});
