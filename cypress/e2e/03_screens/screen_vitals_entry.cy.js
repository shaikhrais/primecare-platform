// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vitals_entry", () => {
  it("opens and verifies screen vitals_entry", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/vitals-entry (VitalsEntryScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/vitals-entry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VitalsEntryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalsentry-screen").should("be.visible");
  cy.getCy("vitalsentry-title").should("be.visible");
  cy.getCy("vitalsentry-content").should("be.visible");
  cy.getCy("pswdashboard-btn-logvitals").should("be.visible");
  cy.getCy("pswdashboard-btn-addcarenote").should("be.visible");
  cy.getCy("pswdashboard-btn-sendmessage").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VitalsEntryScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_entry");
  
  cy.task("log", "✅ PROGRESS: - Verified VitalsEntryScreen successfully!\n");

  });
});
