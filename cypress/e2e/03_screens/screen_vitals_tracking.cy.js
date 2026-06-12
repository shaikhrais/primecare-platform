// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vitals_tracking", () => {
  it("opens and verifies screen vitals_tracking via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "rpn");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_vitals_tracking");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.get('[aria-label*="data-cy:login-email"] input, [data-cy="login-email"] input, flt-semantics input').first().type(user.email, { force: true });
      cy.wait(500);
      cy.get('[aria-label*="data-cy:login-password"] input, [data-cy="login-password"] input').first().type(user.password, { force: true });
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/rpn/vitals-tracking...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/rpn/vitals-tracking");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("vitalstracking-screen").should("be.visible");
      cy.getCy("vitalstracking-title").should("be.visible");
      cy.getCy("vitalstracking-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("vitals_tracking");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_vitals_tracking");
      cy.task("log", "✅ PROGRESS: - Verified VitalsTrackingScreen successfully!\n");
    });
  });
});
