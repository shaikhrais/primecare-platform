// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_clients", () => {
  it("opens and verifies screen franchise_owner_clients", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-owner-clients (FranchiseOwnerClientsScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-clients");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseOwnerClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerclients-screen").should("be.visible");
  cy.getCy("franchiseownerclients-title").should("be.visible");
  cy.getCy("franchiseownerclients-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseOwnerClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_clients");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseOwnerClientsScreen successfully!\n");

  });
});
