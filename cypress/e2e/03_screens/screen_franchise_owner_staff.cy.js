// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_staff", () => {
  it("opens and verifies screen franchise_owner_staff", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-owner-staff (FranchiseOwnerStaffScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-staff");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseOwnerStaffScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerstaff-screen").should("be.visible");
  cy.getCy("franchiseownerstaff-title").should("be.visible");
  cy.getCy("franchiseownerstaff-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseOwnerStaffScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_staff");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseOwnerStaffScreen successfully!\n");

  });
});
