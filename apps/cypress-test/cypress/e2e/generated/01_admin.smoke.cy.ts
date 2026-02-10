
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});

describe("Generated: Admin Smoke", { tags: ["@smoke","@admin"] }, () => {
  it("guest routes load and protected routes redirect", { tags: ["@security"] }, () => {
    cy.fixture("registry/routes.admin.json").then((cfg) => {
      const baseUrl = Cypress.env(cfg.baseUrlEnv);
      expect(baseUrl).to.exist;

      cfg.routes.forEach((r: any) => {
        cy.log(`Checking route as guest: ${r.key}`);
        
        // Ensure clean state for guest check
        cy.clearLocalStorage();
        cy.clearCookies();
        
        cy.visitRoute(cfg.baseUrlEnv, r.path);

        if (r.auth && r.auth !== "guest" && r.auth !== "any") {
          cy.assertRedirectToLogin();
        } else {
            cy.assertNoAppCrash();
        }
      });
    });
  });
});
