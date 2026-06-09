// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_compliance_checks", () => {
  it("opens and verifies screen quality_assurance_compliance_checks", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Compliance Checks)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Compliance Checks...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecompliancechecks-screen").should("be.visible");
  cy.getCy("qualityassurancecompliancechecks-title").should("be.visible");
  cy.getCy("qualityassurancecompliancechecks-content").should("be.visible");
  cy.getCy("compliance-check-summary").should("be.visible");
  cy.getCy("compliance-status-indicator").should("be.visible");
  cy.getCy("compliance-report-access").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Compliance Checks...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance_checks");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Compliance Checks successfully!\n");

  });
});
