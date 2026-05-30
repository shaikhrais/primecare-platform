// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_my_shifts", () => {
  it("opens and verifies screen psw_my_shifts", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/psw-my-shifts (PswMyShiftsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-my-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswMyShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyshifts-screen").should("be.visible");
  cy.getCy("pswmyshifts-title").should("be.visible");
  cy.getCy("pswmyshifts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswMyShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");
  
  cy.task("log", "✅ PROGRESS: - Verified PswMyShiftsScreen successfully!\n");

  });
});
