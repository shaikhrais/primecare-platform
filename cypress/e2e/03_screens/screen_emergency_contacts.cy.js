// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - emergency_contacts", () => {
  it("opens and verifies screen emergency_contacts", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/emergency-contacts (EmergencyContactsScreen)...");
  cy.visitWithSemantics("/common/emergency-contacts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for EmergencyContactsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emergencycontacts-screen").should("be.visible");
  cy.getCy("emergencycontacts-title").should("be.visible");
  cy.getCy("emergencycontacts-content").should("be.visible");
  cy.getCy("emergency-contacts-list").should("be.visible");
  cy.getCy("compliance-scan-results").should("be.visible");
  cy.getCy("audit-log-viewer").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for EmergencyContactsScreen...");
  cy.waitAndSee();
  cy.screenshot("emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: - Verified EmergencyContactsScreen successfully!\n");

  });
});
