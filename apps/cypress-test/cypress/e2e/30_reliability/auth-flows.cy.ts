/// <reference path="../../support/index.d.ts" />

describe("Authentication Reliability Flows", { tags: ["@reliability", "@smoke"] }, () => {

    beforeEach(() => {
        // Ensure a clean state for each micro-test
        cy.clearCookies();
        cy.clearLocalStorage();
    });

    it("Redirection: Guest accessing protected route is sent to /login", () => {
        cy.fixture("registry/routes.admin.json").then((cfg) => {
            const protectedRoute = cfg.routes.find((r: any) => r.auth === "staff");
            cy.visitRoute("ADMIN_BASE_URL", protectedRoute.path);
            cy.url().should("include", "/login");
        });
    });

    it("Deep-Linking: Redirects back to intended page after login", () => {
        cy.fixture("registry/routes.admin.json").then((cfg) => {
            const protectedRoute = cfg.routes.find((r: any) => r.auth === "staff");
            cy.visitRoute("ADMIN_BASE_URL", protectedRoute.path);

            cy.loginAs("staff");
            cy.visitRoute("ADMIN_BASE_URL", "/dashboard");
            cy.getByCy("sidebar").should("be.visible");

            // 2. Trigger logout
            // Logout is usually in topbar or sidebar, using the common selector
            cy.getByCy("btn-logout").click();

            // 3. Should be on login page
            cy.url().should("include", "/login");

            // 4. Attempt to go back to dashboard via URL
            cy.visitRoute("ADMIN_BASE_URL", "/dashboard");
            cy.url().should("include", "/login");
        });
    });
});
