// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_profile", () => {
  it("opens and verifies screen client_profile", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinic/client-profile (Client Profile)...");
  cy.visitWithSemantics("/clinic/client-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Client Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientprofile-screen").should("be.visible");
  cy.getCy("clientprofile-title").should("be.visible");
  cy.getCy("clientprofile-content").should("be.visible");
  cy.getCy("clientprofile-btn-update").should("be.visible");
  cy.getCy("clientprofile-btn-viewfeedback").should("be.visible");
  cy.getCy("clientprofile-btn-edit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Client Profile...");
  cy.waitAndSee();
  cy.screenshot("client_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified Client Profile successfully!\n");

  });
});
