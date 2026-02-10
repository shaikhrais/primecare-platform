/// <reference path="../../support/index.d.ts" />

describe("UI Resilience & Error Handling", { tags: ["@reliability", "@regression"] }, () => {

    // Using UserList as the representative component for micro-testing resilience
    const USERS_API = "**/api/admin/users";

    beforeEach(() => {
        cy.loginAs("staff");
    });

    it("Resilience: API 500 shows error toast", () => {
        // 1. Force 500 error
        cy.intercept("GET", USERS_API, {
            statusCode: 500,
            body: { message: "Internal Server Error" }
        }).as("getUsersError");

        cy.visitAppRoute("ADMIN_BASE_URL", "/users");
        cy.wait("@getUsersError");

        // 2. Verify professional error handling
        cy.getByCy("toast").should("be.visible").and("contain", "Failed to load user list");
    });

    it("UX: Slow API shows loader/spinner", () => {
        // 1. Intercept with 3-second delay
        cy.intercept("GET", USERS_API, {
            delay: 3000,
            fixture: "users.json" // using a dummy list
        }).as("getUsersSlow");

        // Use a role that would see this page
        cy.visitAppRoute("ADMIN_BASE_URL", "/users");

        // 2. Initial state: Loader should be visible
        // Based on UserList code, it shows "Loading users..."
        cy.get("body").should("contain", "Loading users...");

        // 3. Eventually it should finish
        cy.wait("@getUsersSlow");
        cy.get("body").should("not.contain", "Loading users...");
        cy.getByCy("tbl-users").should("be.visible");
    });

    it("UX: Empty data shows 'No results' state", () => {
        // 1. Force empty array response
        cy.intercept("GET", USERS_API, {
            statusCode: 200,
            body: []
        }).as("getUsersEmpty");

        cy.visitAppRoute("ADMIN_BASE_URL", "/users");
        cy.wait("@getUsersEmpty");

        // 2. Verify empty state message (from ContentRegistry in source)
        cy.get("body").should("contain", "No users found in the system");
    });
});
