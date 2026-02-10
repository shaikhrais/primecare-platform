/// <reference path="../../support/index.d.ts" />

describe("Form Validation Micro-tests", { tags: ["@auth", "@smoke"] }, () => {

    beforeEach(() => {
        cy.clearCookies();
        cy.clearLocalStorage();
    });

    it("Login Form: Required fields and email format", () => {
        cy.visitAppRoute("ADMIN_BASE_URL", "/login");

        // 1. Submit empty form
        cy.getByCy("btn-login").click();

        // Check for browser validation or custom error
        // Since it's using standard HTML5 input required in most cases
        cy.get('input[type="email"]:invalid').should('exist');

        // 2. Invalid email format
        cy.getByCy("inp-email").type("not-an-email");
        cy.getByCy("inp-password").type("password");
        cy.getByCy("btn-login").click();
        cy.get('input[type="email"]:invalid').should('exist');

        // 3. Valid but incorrect credentials (401 handled)
        cy.intercept("POST", "**/api/auth/login", {
            statusCode: 401,
            body: { message: "Invalid credentials" }
        }).as("loginAttempt");

        cy.getByCy("inp-email").clear().type("test@example.com");
        cy.getByCy("btn-login").click();
        cy.wait("@loginAttempt");

        cy.getByCy("toast").should("be.visible").and("contain", "Invalid credentials");
    });

    it("Register Form: Password mismatch validation", () => {
        cy.visitAppRoute("ADMIN_BASE_URL", "/register");

        cy.getByCy("inp-email").type("newuser@test.com");
        cy.getByCy("inp-password").type("Password123!");
        cy.getByCy("inp-confirm-password").type("MismatchingPassword!");

        cy.getByCy("btn-register").click();

        // Should show error toast or field error
        cy.getByCy("toast").should("be.visible").and("contain", "Passwords do not match");
    });
});
