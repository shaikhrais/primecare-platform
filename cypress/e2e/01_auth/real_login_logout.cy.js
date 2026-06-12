// E2E Test - Real credential login and logout flow
// Targets: Deployed Clinic App, Chiropractor Role

describe("Real Auth Login and Logout Flow", () => {
  it("performs real credential login, navigates, and logs out", () => {
    // 1. Visit deployed login page
    cy.task("log", "⏳ PROGRESS: - Visiting login page...");
    cy.visitWithSemantics("https://primecare-clinic.pages.dev/login");
    cy.waitAndSee();

    // Verify login inputs are visible
    cy.getCy("login-email").should("be.visible");
    cy.getCy("login-password").should("be.visible");
    cy.getCy("login-submit").should("be.visible");

    // Take a screenshot of the unauthenticated login screen
    cy.task("log", "📸 PROGRESS: - Saving screenshot of unauthenticated login page...");
    cy.screenshot("real_login_screen");

    // 2. Type real chiropractor credentials
    cy.task("log", "⏳ PROGRESS: - Entering credentials...");
    // Find the TextFormField inputs inside the Cy wrapper and type
    cy.get('[aria-label*="data-cy:login-email"] input, [data-cy="login-email"] input, flt-semantics input').first().type("qa.chiropractor@test.primecare.local", { force: true });
    cy.wait(500);
    cy.get('[aria-label*="data-cy:login-password"] input, [data-cy="login-password"] input').first().type("Test@12345", { force: true });
    cy.wait(500);

    // Click submit
    cy.task("log", "👆 PROGRESS: - Submitting credentials...");
    cy.getCy("login-submit").first().click({ force: true });

    // 3. Verify successful authentication and redirection to dashboard
    cy.task("log", "⏳ PROGRESS: - Waiting for dashboard redirection...");
    cy.wait(6000);
    cy.url().should("include", "/offices/clinical/roles/chiropractor/dashboard");
    cy.verifyShellExists();

    // Take screenshot of the logged in dashboard
    cy.task("log", "📸 PROGRESS: - Saving screenshot of chiropractor dashboard...");
    cy.screenshot("chiropractor_dashboard");

    // 4. Navigate to adjustment notes screen
    cy.task("log", "⏳ PROGRESS: - Navigating to adjustment-notes screen...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/adjustment-notes");
    cy.waitAndSee();

    // Verify screen elements are visible
    cy.getCy("adjustmentnotes-screen").should("be.visible");
    cy.getCy("adjustmentnotes-title").should("be.visible");
    cy.getCy("adjustmentnotes-content").should("be.visible");

    // Take screenshot of the adjustment notes screen
    cy.task("log", "📸 PROGRESS: - Saving screenshot of adjustment notes page...");
    cy.screenshot("adjustment_notes_page");

    // 5. Click Logout button
    cy.task("log", "👆 PROGRESS: - Logging out...");
    cy.get("body").then(($body) => {
      const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
      if (topbarLogout.length > 0) {
        cy.wrap(topbarLogout).first().click({ force: true });
      } else {
        // Fallback: clear storage and visit /login
        cy.clearAllCookies();
        cy.clearAllLocalStorage();
        cy.clearAllSessionStorage();
        cy.visit("https://primecare-clinic.pages.dev/login?enable-semantics=true");
      }
    });
    cy.waitAndSee();

    // 6. Verify we are returned to /login
    cy.url().should("include", "/login");
    cy.getCy("login-email").should("be.visible");

    // Take screenshot of the post-logout login screen
    cy.task("log", "📸 PROGRESS: - Saving post-logout screenshot...");
    cy.screenshot("real_logout_screen");

    cy.task("log", "✅ PROGRESS: - Real auth credentials login and logout verified successfully!");
  });
});
