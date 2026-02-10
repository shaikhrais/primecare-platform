
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});

describe("Generated: Contracts", { tags: ["@contract"] }, () => {
  it("staff pages contain required data-cy elements", () => {
    cy.loginAs("staff");
    cy.fixture("registry/routes.admin.json").then((routesCfg) => {
      cy.fixture("registry/contracts.json").then((c) => {
        const baseUrl = Cypress.env(routesCfg.baseUrlEnv);

        Object.entries(c).forEach(([routeKey, selectors]) => {
          const route = routesCfg.routes.find((r:any) => r.key === routeKey);
          if (!route) return;

          cy.log(`Verifying contract for page: ${routeKey}`);
          cy.visitRoute(routesCfg.baseUrlEnv, route.path);
          cy.assertContract(selectors as string[]);
        });
      });
    });
  });
});
