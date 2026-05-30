// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - messaging", () => {
  it("opens and verifies screen messaging", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/caregiver/messaging (MessagingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/messaging");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for MessagingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("messaging-screen").should("be.visible");
  cy.getCy("messaging-title").should("be.visible");
  cy.getCy("messaging-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for MessagingScreen...");
  cy.waitAndSee();
  cy.screenshot("messaging");
  
  cy.task("log", "✅ PROGRESS: - Verified MessagingScreen successfully!\n");

  });
});
