
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});

type Role = "guest"|"client"|"psw"|"manager"|"staff";

describe("Generated: Access Matrix", { tags: ["@security","@rbac"] }, () => {
  it("enforces route permissions", () => {
    cy.fixture("registry/routes.admin.json").then((routesCfg) => {
      cy.fixture("registry/access.matrix.json").then((m) => {
        const baseUrl = Cypress.env(routesCfg.baseUrlEnv);
        const redirect = m.redirectWhenDenied || "/login";

        const routeByKey = new Map<string, any>();
        routesCfg.routes.forEach((r:any) => routeByKey.set(r.key, r));

        (m.roles as Role[]).forEach((role) => {
          cy.log(`Testing as role: ${role}`);
          
          m.rules.forEach((rule:any) => {
            const route = routeByKey.get(rule.routeKey);
            if (!route) return;

            const allowed = rule.allowed.includes(role);
            
            cy.log(`Testing access to ${route.key} (${route.path}) - Expected Allowed: ${allowed}`);
            
            // Clean state before each check
            cy.logout();
            if (role !== "guest") cy.loginAs(role);

            cy.visitRoute(routesCfg.baseUrlEnv, route.path);

            if (!allowed) {
                cy.url().should("include", redirect);
            } else {
                cy.url().should("not.include", redirect);
                cy.assertNoAppCrash();
            }
          });
        });
      });
    });
  });
});
