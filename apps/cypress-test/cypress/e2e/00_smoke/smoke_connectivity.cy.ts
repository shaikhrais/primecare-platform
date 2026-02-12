/// <reference path="../../support/index.d.ts" />

describe("Global Connectivity Verification", { tags: ["@smoke", "@connectivity"] }, () => {

    describe("Marketing Application Connectivity", () => {
        beforeEach(() => {
            cy.fixture("registry/routes.marketing.json").as("marketingRoutes");
        });

        it("verifies all marketing routes load successfully without errors", function () {
            this.marketingRoutes.routes.forEach((route: any) => {
                cy.log(`Testing Marketing Route: ${route.key} -> ${route.path}`);

                // Visit the marketing route
                cy.visitRoute("MARKETING_BASE_URL", route.path);

                // Critical Connectivity Assertions
                cy.get("body").should("be.visible");
                cy.get("body").should("not.contain", "Application error");
                cy.get("body").should("not.contain", "404");

                // Ensure page is not empty (contains at least some content)
                cy.get("#root").should("not.be.empty");
            });
        });
    });

    describe("Admin Application Connectivity", () => {
        beforeEach(() => {
            cy.fixture("registry/routes.admin.json").as("adminRoutes");
        });

        const rolesToVerify = ["staff", "psw", "client", "rn"] as const;

        rolesToVerify.forEach((role) => {
            it(`verifies authorized admin routes for role: ${role}`, function () {
                cy.loginAs(role);

                const authorizedRoutes = this.adminRoutes.routes.filter((r: any) =>
                    r.auth === role || r.auth === "any" || (role === "staff" && ["staff", "any"].includes(r.auth))
                );

                authorizedRoutes.forEach((route: any) => {
                    cy.log(`Testing Admin Route [${role}]: ${route.key} -> ${route.path}`);

                    // Visit the admin route (using absolute path as registered in RouteRegistry)
                    cy.visitAppRoute("ADMIN_BASE_URL", route.path);

                    // Critical Connectivity Assertions
                    cy.get("body").should("be.visible");
                    cy.get("body").should("not.contain", "Application error");
                    cy.get("body").should("not.contain", "404");

                    // Verify sidebar presence for authenticated sessions (indicator of successful layout load)
                    cy.getByCy("sidebar").should("exist");

                    // Ensure page body is not empty
                    cy.get("main").should("exist").and("not.be.empty");
                });

                // Clear session for next role
                cy.logout();
            });
        });

        it("verifies guest access to login/register in admin portal", function () {
            const guestRoutes = this.adminRoutes.routes.filter((r: any) => r.auth === "guest");

            guestRoutes.forEach((route: any) => {
                cy.log(`Testing Admin Guest Route: ${route.key} -> ${route.path}`);
                cy.visitAppRoute("ADMIN_BASE_URL", route.path);

                cy.get("body").should("be.visible");
                cy.get("body").should("not.contain", "404");

                // Login page should have the logo or email input
                if (route.key === "LOGIN") {
                    cy.getByCy("inp-email").should("be.visible");
                }
            });
        });
    });
});
