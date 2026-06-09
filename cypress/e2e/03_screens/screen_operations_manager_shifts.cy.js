// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_shifts", () => {
  it("opens and verifies screen operations_manager_shifts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/shifts (Operations Manager Shifts)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Shifts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagershifts-screen").should("be.visible");
  cy.getCy("operationsmanagershifts-title").should("be.visible");
  cy.getCy("operationsmanagershifts-content").should("be.visible");
  cy.getCy("operationsmanager-btn-generate-report").should("be.visible");
  cy.getCy("operationsmanager-btn-update-shift").should("be.visible");
  cy.getCy("operationsmanager-btn-address-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Shifts...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_shifts");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Shifts successfully!\n");

  });
});
