/// <reference path="../../support/index.d.ts" />
describe("Admin/Portal Routes Smoke", { tags: ["@smoke", "@admin"] }, () => {
    const rolesToCheck = ["guest", "staff"] as const;

    rolesToCheck.forEach((role) => {
        it(`loads core routes as ${role}`, () => {
            cy.fixture("registry/routes.admin.json").then((cfg) => {
                cy.loginAs(role);

                // For smoke test, we only check a representative subset of routes per role
                // to keep the suite fast. Full matrix is in 10_security.
                const smokeRoutes = role === "guest"
                    ? cfg.routes.filter((r: any) => r.auth === "guest")
                    : cfg.routes.filter((r: any) => ["staff", "any"].includes(r.auth));

                smokeRoutes.forEach((r: any) => {
                    cy.log(`[${role}] Testing Route: ${r.key} -> ${r.path}`);
                    cy.visitAppRoute(cfg.baseUrlEnv, r.path);

                    cy.get("body").should("be.visible");
                    cy.get("body").should("not.contain", "404");

                    if (role !== "guest") {
                        cy.getByCy("sidebar").should("be.visible");
                    }
                });
            });
        });
    });
});
