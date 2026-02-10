describe("Page Contracts (data-cy Verification)", { tags: ["@contract", "@smoke"] }, () => {
    it("verifies that all contracted pages have their required UI elements", () => {
        cy.fixture("routes.admin.json").then((adminCfg) => {
            cy.fixture("contracts.json").then((contracts) => {
                // Run contract checks as 'staff' to ensure most pages are accessible
                cy.loginAs("staff");

                Object.entries(contracts).forEach(([routeKey, requiredSelectors]) => {
                    const route = adminCfg.routes.find((r: any) => r.key === routeKey);
                    if (!route) return;

                    it(`Contract Check: ${routeKey} (${route.path})`, () => {
                        cy.visitAppRoute(adminCfg.baseUrlEnv, route.path);

                        // Wait for page to stabilize
                        cy.get("body").should("be.visible");

                        (requiredSelectors as string[]).forEach((selector) => {
                            cy.log(`Checking for selector: ${selector}`);
                            cy.getByCy(selector, { timeout: 10000 }).should("exist");
                        });
                    });
                });
            });
        });
    });
});
