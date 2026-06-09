// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_financial_snapshot", () => {
  it("opens and verifies screen franchise_owner_financial_snapshot", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/franchise_owner/financial-snapshot (Franchise Owner Financial Snapshot)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/financial-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Owner Financial Snapshot...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerfinancialsnapshot-screen").should("be.visible");
  cy.getCy("franchiseownerfinancialsnapshot-title").should("be.visible");
  cy.getCy("franchiseownerfinancialsnapshot-content").should("be.visible");
  cy.getCy("franchise-financial-snapshot-refresh").should("be.visible");
  cy.getCy("franchise-report-discrepancy").should("be.visible");
  cy.getCy("franchise-view-historical-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Owner Financial Snapshot...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_financial_snapshot");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Owner Financial Snapshot successfully!\n");

  });
});
