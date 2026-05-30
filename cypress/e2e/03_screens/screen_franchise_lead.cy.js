// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_lead", () => {
  it("opens and verifies screen franchise_lead", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/franchise-lead (FranchiseLeadScreen)...");
  cy.visitWithSemantics("/management/franchise-lead");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseLeadScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiselead-screen").should("be.visible");
  cy.getCy("franchiselead-title").should("be.visible");
  cy.getCy("franchiselead-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseLeadScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_lead");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseLeadScreen successfully!\n");

  });
});
