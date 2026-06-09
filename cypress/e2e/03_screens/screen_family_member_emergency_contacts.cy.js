// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_emergency_contacts", () => {
  it("opens and verifies screen family_member_emergency_contacts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Family Member Emergency Contacts)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Member Emergency Contacts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberemergencycontacts-screen").should("be.visible");
  cy.getCy("familymemberemergencycontacts-title").should("be.visible");
  cy.getCy("familymemberemergencycontacts-content").should("be.visible");
  cy.getCy("emergency-contact-list").should("be.visible");
  cy.getCy("add-contact-btn").should("be.visible");
  cy.getCy("edit-contact-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Member Emergency Contacts...");
  cy.waitAndSee();
  cy.screenshot("family_member_emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Member Emergency Contacts successfully!\n");

  });
});
