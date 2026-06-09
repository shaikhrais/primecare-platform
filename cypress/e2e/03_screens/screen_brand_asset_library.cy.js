// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - brand_asset_library", () => {
  it("opens and verifies screen brand_asset_library", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Brand Asset Library)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Brand Asset Library...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("brandassetlibrary-screen").should("be.visible");
  cy.getCy("brandassetlibrary-title").should("be.visible");
  cy.getCy("brandassetlibrary-content").should("be.visible");
  cy.getCy("asset-library-btn-refresh").should("be.visible");
  cy.getCy("asset-library-btn-upload").should("be.visible");
  cy.getCy("asset-library-btn-download").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Brand Asset Library...");
  cy.waitAndSee();
  cy.screenshot("brand_asset_library");
  
  cy.task("log", "✅ PROGRESS: - Verified Brand Asset Library successfully!\n");

  });
});
