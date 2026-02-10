import { SELECTORS } from "../selectors";
const { MANAGER: MGR, ADMIN: ADM } = SELECTORS;

export { };

type Role = "guest" | "client" | "psw" | "manager" | "staff";

declare global {
    namespace Cypress {
        interface Chainable {
            loginAs(role: Role): Chainable<void>;
            loginAsAdmin(): Chainable<void>;
            loginAsManager(): Chainable<void>;
        }
    }
}

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

        cy.getByCy("inp-email").clear().type(u.email);
        cy.getByCy("inp-password").clear().type(u.password, { log: false });
        cy.getByCy("btn-login").click();

        cy.url().should("not.include", "/login");
    });
});

Cypress.Commands.add("loginAsAdmin", () => {
    cy.loginAs("staff");
});

Cypress.Commands.add("loginAsManager", () => {
    cy.loginAs("manager");
});
