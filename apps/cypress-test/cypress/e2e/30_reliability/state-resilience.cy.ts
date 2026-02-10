/// <reference path="../../support/index.d.ts" />

/**
 * State Resilience & Routing Suite
 * Verifies how the app handles empty data, server errors, and invalid routes.
 */

describe("State Resilience & Routing", { tags: ["@reliability", "@regression"] }, () => {

    beforeEach(() => {
        cy.loginAs("staff");
    });

    const DASHBOARD_API = "**/api/admin/dashboard";

    it("State: Dashboard handles 500 server error gracefully", () => {
        cy.intercept("GET", DASHBOARD_API, {
            statusCode: 500,
            body: { message: "Internal Server Error" }
        }).as("getDashError");

        cy.visitRoute("ADMIN_BASE_URL", "/dashboard");
        cy.wait("@getDashError");

        // Should show error fallback UI
        cy.getByCy("toast").should("be.visible").and("contain", "Failed to load dashboard");
        cy.get("body").should("contain", "Try again");
    });

    it("State: Dashboard handles empty data state", () => {
        cy.intercept("GET", DASHBOARD_API, {
            fixture: "stubs/dashboard.empty.json"
        }).as("getDashEmpty");

        cy.visitRoute("ADMIN_BASE_URL", "/dashboard");
        cy.wait("@getDashEmpty");

        // Should show empty state message
        cy.get("body").should("contain", "No recent activity to display");
    });

    it("Routing: Unknown route displays Not Found UI", () => {
        cy.visitRoute("ADMIN_BASE_URL", "/this-page-does-not-exist");

        // Should see NotFound content
        cy.url().should("include", "/this-page-does-not-exist");
        cy.get("h1, h2").should("contain", "404");
        cy.get("body").should("contain", "Page Not Found");
    });
});
