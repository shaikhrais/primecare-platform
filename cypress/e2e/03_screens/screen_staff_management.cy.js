// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_management", () => {
  it("opens and verifies screen staff_management", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/staff-management (StaffManagementScreen)...");
  cy.visitWithSemantics("/executive/staff-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for StaffManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffmanagement-screen").should("be.visible");
  cy.getCy("staffmanagement-title").should("be.visible");
  cy.getCy("staffmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for StaffManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_management");
  
  cy.task("log", "✅ PROGRESS: - Verified StaffManagementScreen successfully!\n");

  });
});
