// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - asynchronous_consultation_inbox", () => {
  it("opens and verifies screen asynchronous_consultation_inbox", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Asynchronous Consultation Inbox)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Asynchronous Consultation Inbox...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("asynchronousconsultationinbox-screen").should("be.visible");
  cy.getCy("asynchronousconsultationinbox-title").should("be.visible");
  cy.getCy("asynchronousconsultationinbox-content").should("be.visible");
  cy.getCy("consultation-inbox").should("be.visible");
  cy.getCy("consultation-respond-btn").should("be.visible");
  cy.getCy("consultation-archive-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Asynchronous Consultation Inbox...");
  cy.waitAndSee();
  cy.screenshot("asynchronous_consultation_inbox");
  
  cy.task("log", "✅ PROGRESS: - Verified Asynchronous Consultation Inbox successfully!\n");

  });
});
