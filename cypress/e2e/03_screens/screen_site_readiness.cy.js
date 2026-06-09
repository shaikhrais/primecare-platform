// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - site_readiness", () => {
  it("opens and verifies screen site_readiness", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Site Readiness)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Site Readiness...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("sitereadiness-screen").should("be.visible");
  cy.getCy("sitereadiness-title").should("be.visible");
  cy.getCy("sitereadiness-content").should("be.visible");
  cy.getCy("site-readiness-btn-schedule-audit").should("be.visible");
  cy.getCy("site-readiness-btn-update-status").should("be.visible");
  cy.getCy("site-readiness-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Site Readiness...");
  cy.waitAndSee();
  cy.screenshot("site_readiness");
  
  cy.task("log", "✅ PROGRESS: - Verified Site Readiness successfully!\n");

  });
});
