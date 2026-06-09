// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - biospecimen_inventory_tracker", () => {
  it("opens and verifies screen biospecimen_inventory_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Biospecimen Inventory Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Biospecimen Inventory Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("biospecimeninventorytracker-screen").should("be.visible");
  cy.getCy("biospecimeninventorytracker-title").should("be.visible");
  cy.getCy("biospecimeninventorytracker-content").should("be.visible");
  cy.getCy("biospecimen-inventory-card").should("be.visible");
  cy.getCy("biospecimen-search-filter").should("be.visible");
  cy.getCy("biospecimen-report-generator").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Biospecimen Inventory Tracker...");
  cy.waitAndSee();
  cy.screenshot("biospecimen_inventory_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Biospecimen Inventory Tracker successfully!\n");

  });
});
