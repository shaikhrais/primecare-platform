/// <reference types="cypress" />

Cypress.Commands.add("visitAppRoute", (baseUrlEnv: string, path: string) => {
    const baseUrl = Cypress.env(baseUrlEnv);
    if (!baseUrl) {
        throw new Error(`Environment variable ${baseUrlEnv} is not defined. Check your cypress.config.ts or env vars.`);
    }
    const url = new URL(path, baseUrl).toString();
    cy.visit(url, { failOnStatusCode: false });
});

declare global {
    namespace Cypress {
        interface Chainable {
            visitAppRoute(baseUrlEnv: string, path: string): Chainable<void>;
        }
    }
}

export { };
