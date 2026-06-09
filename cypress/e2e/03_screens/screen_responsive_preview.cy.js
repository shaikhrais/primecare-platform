// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - responsive_preview", () => {
  it("opens and verifies screen responsive_preview", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/responsive-preview (ResponsivePreviewScreen)...");
  cy.visitWithSemantics("/common/responsive-preview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ResponsivePreviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-compliance").should("be.visible");
  cy.getCy("gov-dashboard-btn-export-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-assess-risk").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ResponsivePreviewScreen...");
  cy.waitAndSee();
  cy.screenshot("responsive_preview");
  
  cy.task("log", "✅ PROGRESS: - Verified ResponsivePreviewScreen successfully!\n");

  });
});
