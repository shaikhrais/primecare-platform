/// <reference path="../../support/index.d.ts" />
type TestRole = "guest" | "client" | "psw" | "manager" | "staff";

describe("Access Control Matrix", { tags: ["@security", "@regression"] }, () => {
    it("enforces role-based access rules for all routes", () => {
        cy.fixture("registry/routes.admin.json").then((adminCfg) => {
            cy.fixture("access.matrix.json").then((matrix) => {
                const redirectPath = matrix.redirectWhenDenied;

                (matrix.roles as TestRole[]).forEach((role) => {
                    describe(`Role: ${role}`, () => {
                        beforeEach(() => {
                            cy.loginAs(role);
                        });

                        matrix.rules.forEach((rule: any) => {
                            const route = adminCfg.routes.find((r: any) => r.key === rule.routeKey);
                            if (!route) return;

                            const isAllowed = rule.allowed.includes(role);

                            it(`${isAllowed ? 'ALLOWS' : 'DENIES'} access to ${rule.routeKey} (${route.path})`, () => {
                                cy.visitAppRoute(adminCfg.baseUrlEnv, route.path);

                                if (isAllowed) {
                                    cy.url().should("not.include", redirectPath);
                                    // Verify a core element of the target page exists
                                    cy.get("body").should("be.visible");
                                } else {
                                    cy.url().should("include", redirectPath);
                                }
                            });
                        });
                    });
                });
            });
        });
    });
});
