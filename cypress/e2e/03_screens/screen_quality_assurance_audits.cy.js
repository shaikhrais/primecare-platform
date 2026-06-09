// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_audits", () => {
  it("opens and verifies screen quality_assurance_audits", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Audits)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Audits...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceaudits-screen").should("be.visible");
  cy.getCy("qualityassuranceaudits-title").should("be.visible");
  cy.getCy("qualityassuranceaudits-content").should("be.visible");
  cy.getCy("audit-reports-list").should("be.visible");
  cy.getCy("conduct-audit-btn").should("be.visible");
  cy.getCy("submit-findings-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Audits...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_audits");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Audits successfully!\n");

  });
});
