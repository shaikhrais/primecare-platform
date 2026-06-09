// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - access_review_certifier", () => {
  it("opens and verifies screen access_review_certifier", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Access Review Certifier)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Access Review Certifier...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("accessreviewcertifier-screen").should("be.visible");
  cy.getCy("accessreviewcertifier-title").should("be.visible");
  cy.getCy("accessreviewcertifier-content").should("be.visible");
  cy.getCy("accessreview-btn-review").should("be.visible");
  cy.getCy("accessreview-btn-certify").should("be.visible");
  cy.getCy("accessreview-btn-revoke").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Access Review Certifier...");
  cy.waitAndSee();
  cy.screenshot("access_review_certifier");
  
  cy.task("log", "✅ PROGRESS: - Verified Access Review Certifier successfully!\n");

  });
});
