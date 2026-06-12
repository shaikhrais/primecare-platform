// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - api_health_dashboard", () => {
  it("opens and verifies screen api_health_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_api_health_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /common/api-health-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/common/api-health-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("apihealthdashboard-screen").should("be.visible");
      cy.getCy("apihealthdashboard-title").should("be.visible");
      cy.getCy("apihealthdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("api_health_dashboard");

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
      cy.screenshot("logout_screen_api_health_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ApiHealthDashboardScreen successfully!\n");
    });
  });
});
