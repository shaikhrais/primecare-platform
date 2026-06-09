// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_hiring", () => {
  it("opens and verifies screen franchise_owner_hiring", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/franchise_owner/hiring (Franchise Owner Hiring)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/hiring");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Owner Hiring...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerhiring-screen").should("be.visible");
  cy.getCy("franchiseownerhiring-title").should("be.visible");
  cy.getCy("franchiseownerhiring-content").should("be.visible");
  cy.getCy("franchise-hiring-review").should("be.visible");
  cy.getCy("franchise-jobpostings-monitor").should("be.visible");
  cy.getCy("franchise-candidates-evaluate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Owner Hiring...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_hiring");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Owner Hiring successfully!\n");

  });
});
