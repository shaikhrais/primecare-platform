// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ticket_center", () => {
  it("opens and verifies screen ticket_center", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/tickets (Ticket Center)...");
  cy.visitWithSemantics("/governance/tickets");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ticket Center...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ticketcenter-screen").should("be.visible");
  cy.getCy("ticketcenter-title").should("be.visible");
  cy.getCy("ticketcenter-content").should("be.visible");
  cy.getCy("ticketcenter-btn-create").should("be.visible");
  cy.getCy("ticketcenter-btn-respond").should("be.visible");
  cy.getCy("ticketcenter-btn-review").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ticket Center...");
  cy.waitAndSee();
  cy.screenshot("ticket_center");
  
  cy.task("log", "✅ PROGRESS: - Verified Ticket Center successfully!\n");

  });
});
