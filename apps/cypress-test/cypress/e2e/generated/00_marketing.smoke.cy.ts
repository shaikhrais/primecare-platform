
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});

describe("Generated: Marketing Smoke", { tags: ["@smoke","@marketing"] }, () => {
  it("loads all marketing routes", () => {
    cy.fixture("registry/routes.marketing.json").then((cfg) => {
      const baseUrl = Cypress.env(cfg.baseUrlEnv);
      expect(baseUrl).to.exist;

      cfg.routes.forEach((r: any) => {
        cy.log(`${r.key} -> ${r.path}`);
        cy.visit(new URL(r.path, baseUrl).toString(), { failOnStatusCode: false });
        cy.assertNoAppCrash();
      });
    });
  });
});
