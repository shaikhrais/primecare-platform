// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_reviews", () => {
  it("opens and verifies screen compliance_reviews", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /generated/compliance-reviews (Compliance Reviews)...");
  cy.visitWithSemantics("/generated/compliance-reviews");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Reviews...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereviews-screen").should("be.visible");
  cy.getCy("compliancereviews-title").should("be.visible");
  cy.getCy("compliancereviews-content").should("be.visible");
  cy.getCy("compliance-dashboard-overview").should("be.visible");
  cy.getCy("compliance-kpi-alerts").should("be.visible");
  cy.getCy("compliance-reports-access").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Reviews...");
  cy.waitAndSee();
  cy.screenshot("compliance_reviews");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Reviews successfully!\n");

  });
});
