// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_appointments", () => {
  it("opens and verifies screen franchise_owner_appointments", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-owner-appointments (FranchiseOwnerAppointmentsScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseOwnerAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerappointments-screen").should("be.visible");
  cy.getCy("franchiseownerappointments-title").should("be.visible");
  cy.getCy("franchiseownerappointments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseOwnerAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseOwnerAppointmentsScreen successfully!\n");

  });
});
