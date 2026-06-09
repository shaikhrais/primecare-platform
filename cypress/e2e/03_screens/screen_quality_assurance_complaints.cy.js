// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_complaints", () => {
  it("opens and verifies screen quality_assurance_complaints", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Complaints)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Complaints...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecomplaints-screen").should("be.visible");
  cy.getCy("qualityassurancecomplaints-title").should("be.visible");
  cy.getCy("qualityassurancecomplaints-content").should("be.visible");
  cy.getCy("qa-complaints-overview").should("be.visible");
  cy.getCy("qa-complaints-category").should("be.visible");
  cy.getCy("qa-response-time").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Complaints...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_complaints");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Complaints successfully!\n");

  });
});
