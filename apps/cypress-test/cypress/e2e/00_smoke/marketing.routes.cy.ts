/// <reference path="../../support/index.d.ts" />
describe("Marketing Routes Smoke", { tags: ["@smoke", "@marketing"] }, () => {
    it("loads every marketing page without blank screen", () => {
        cy.fixture("registry/routes.marketing.json").then((cfg) => {
            cfg.routes.forEach((r: any) => {
                cy.log(`Testing Route: ${r.key} -> ${r.path}`);
                cy.visitAppRoute(cfg.baseUrlEnv, r.path);

                // Professional health check
                cy.get("body").should("be.visible");
                cy.get("body").should("not.contain", "Application error");
                cy.get("body").should("not.contain", "404");

                // Ensure layout elements are present
                cy.getByCy("logo-link").should("exist");
            });
        });
    });
});
