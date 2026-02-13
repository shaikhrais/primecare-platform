
import { SELECTORS } from "../selectors";

type Role = "guest" | "client" | "psw" | "manager" | "staff" | "rn";

export { };

declare global {
    namespace Cypress {
        interface Chainable {
            loginAs(role: Role): Chainable<void>;
            loginAsAdmin(): Chainable<void>;
            loginAsManager(): Chainable<void>;
            logout(): Chainable<void>;
        }
    }
}

/**
 * Standard UI-based login for end-to-end reliability.
 */
Cypress.Commands.add("loginAs", (role: Role) => {
    if (role === "guest") {
        cy.log("Continuing as guest (skipping login)");
        return;
    }

    cy.fixture("users.json").then((users) => {
        const u = users[role];
        if (!u) throw new Error(`Missing credentials for role: ${role}`);

        const baseUrl = Cypress.env("ADMIN_BASE_URL") || Cypress.config("baseUrl");
        cy.visit(`${baseUrl}/login`);

        cy.handleCookieConsent();

        // Select the role in the dropdown to avoid "Not registered as X" error
        cy.getByCy("sel-role").select(role);

        cy.getByCy("inp-email").clear().type(u.email);
        cy.getByCy("inp-password").clear().type(u.password, { log: false });
        cy.getByCy("btn-login").click({ force: true });

        // Wait for transition out of login or appearance of dashboard-grade element
        cy.url({ timeout: 15000 }).should("not.include", "/login");

        // Final guard to ensure app is interactive
        cy.get("body").should("be.visible");
    });
});

Cypress.Commands.add("loginAsAdmin", () => {
    cy.loginAs("staff");
});

Cypress.Commands.add("loginAsManager", () => {
    cy.loginAs("manager");
});

Cypress.Commands.add("logout", () => {
    cy.clearCookies();
    cy.clearLocalStorage();
    cy.log("Session cleared");
});
