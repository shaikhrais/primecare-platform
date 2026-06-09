// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_competitor_notes", () => {
  it("opens and verifies screen regional_bdm_competitor_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/competitor-notes (Regional Bdm Competitor Notes)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/competitor-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Competitor Notes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmcompetitornotes-screen").should("be.visible");
  cy.getCy("regionalbdmcompetitornotes-title").should("be.visible");
  cy.getCy("regionalbdmcompetitornotes-content").should("be.visible");
  cy.getCy("competitor-notes-list").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Competitor Notes...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_competitor_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Competitor Notes successfully!\n");

  });
});
