/// <reference path="../../support/index.d.ts" />

describe("Authentication Reliability Flows", { tags: ["@reliability", "@smoke"] }, () => {

    beforeEach(() => {
        // Ensure a clean state for each micro-test
        cy.clearCookies();
        cy.clearLocalStorage();
    });

    it("Redirection: Guest accessing protected route is sent to /login", () => {
        cy.fixture("registry/routes.admin.json").then((cfg) => {
            // Pick a staff-protected route
            const protectedRoute = cfg.routes.find((r: any) => r.auth === "staff");

            cy.visitAppRoute(cfg.baseUrlEnv, protectedRoute.path);

            // Should be redirected to login
            cy.url().should("include", "/login");
            cy.getByCy("inp-email").should("be.visible");
        });
    });

    it("Deep-Linking: Redirects back to intended page after login", () => {
        cy.fixture("registry/routes.admin.json").then((cfg) => {
            const intendedPath = "/users";

            // 1. Attempt to visit protected page as guest
            cy.visitAppRoute(cfg.baseUrlEnv, intendedPath);
            cy.url().should("include", "/login");

            // 2. Perform login
            cy.fixture("users.json").then((users) => {
                const u = users.staff;
                cy.getByCy("inp-email").type(u.email);
                cy.getByCy("inp-password").type(u.password, { log: false });
                cy.getByCy("btn-login").click();

                // 3. Should land on intended page, not just dashboard
                cy.url().should("include", intendedPath);
            });
        });
    });

    it("Security: Logout clears session and blocks access", () => {
        cy.fixture("registry/routes.admin.json").then((cfg) => {
            // 1. Login as staff
            cy.loginAs("staff");
            cy.visitAppRoute(cfg.baseUrlEnv, "/dashboard");
            cy.getByCy("sidebar").should("be.visible");

            // 2. Trigger logout
            // Logout is usually in topbar or sidebar, using the common selector
            cy.getByCy("btn-logout").click();

            // 3. Should be on login page
            cy.url().should("include", "/login");

            // 4. Attempt to go back to dashboard via URL
            cy.visitAppRoute(cfg.baseUrlEnv, "/dashboard");
            cy.url().should("include", "/login");
        });
    });
});
