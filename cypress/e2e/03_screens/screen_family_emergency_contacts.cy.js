// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_emergency_contacts", () => {
  it("opens and verifies screen family_emergency_contacts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/family_member/emergency-contacts (Family Emergency Contacts)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/emergency-contacts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Emergency Contacts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyemergencycontacts-screen").should("be.visible");
  cy.getCy("familyemergencycontacts-title").should("be.visible");
  cy.getCy("familyemergencycontacts-content").should("be.visible");
  cy.getCy("family-emergency-contacts-list").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Emergency Contacts...");
  cy.waitAndSee();
  cy.screenshot("family_emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Emergency Contacts successfully!\n");

  });
});
