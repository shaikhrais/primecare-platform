// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_performance_reports", () => {
  it("opens and verifies screen head_of_marketing_performance_reports via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "marketing");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_head_of_marketing_performance_reports");

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
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: None...");
      cy.visitWithSemantics(targetBaseUrl + "None");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("head of marketing performance reports-screen").should("be.visible");
      cy.getCy("head of marketing performance reports-title").should("be.visible");
      cy.getCy("head of marketing performance reports-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("head_of_marketing_performance_reports");

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
      cy.screenshot("logout_screen_head_of_marketing_performance_reports");
      cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Performance Reports successfully!\n");
    });
  });
});
