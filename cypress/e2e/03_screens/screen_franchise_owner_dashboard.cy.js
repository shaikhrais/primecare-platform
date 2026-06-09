// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_dashboard", () => {
  it("opens and verifies screen franchise_owner_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/franchise_owner/dashboard (Franchise Owner Dashboard)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Owner Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerdashboard-screen").should("be.visible");
  cy.getCy("franchiseownerdashboard-title").should("be.visible");
  cy.getCy("franchiseownerdashboard-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-review-sales").should("be.visible");
  cy.getCy("franchise-dashboard-btn-manage-communications").should("be.visible");
  cy.getCy("franchise-dashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Owner Dashboard...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Owner Dashboard successfully!\n");

  });
});
