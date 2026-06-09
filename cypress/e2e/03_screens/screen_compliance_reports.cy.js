// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_reports", () => {
  it("opens and verifies screen compliance_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereports-screen").should("be.visible");
  cy.getCy("compliancereports-title").should("be.visible");
  cy.getCy("compliancereports-content").should("be.visible");
  cy.getCy("compliance-reports-summary").should("be.visible");
  cy.getCy("compliance-notifications").should("be.visible");
  cy.getCy("recent-reports-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Reports...");
  cy.waitAndSee();
  cy.screenshot("compliance_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Reports successfully!\n");

  });
});
