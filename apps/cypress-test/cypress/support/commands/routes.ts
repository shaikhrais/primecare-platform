/// <reference types="cypress" />

Cypress.Commands.add("visitAppRoute", (baseUrlEnv: string, path: string) => {
    const baseUrl = Cypress.env(baseUrlEnv);
    if (!baseUrl) {
        throw new Error(`Environment variable ${baseUrlEnv} is not defined. Check your cypress.config.ts or env vars.`);
    }
    const url = new URL(path, baseUrl).toString();
    cy.visit(url, { failOnStatusCode: false });
    cy.handleCookieConsent();
});

Cypress.Commands.add("handleCookieConsent", () => {
    cy.get("body").then(($body) => {
        if ($body.find('button:contains("Accept All")').length > 0) {
            cy.contains("button", "Accept All").click({ force: true });
        }
    });
});

declare global {
    namespace Cypress {
        interface Chainable {
            visitAppRoute(baseUrlEnv: string, path: string): Chainable<void>;
            handleCookieConsent(): Chainable<void>;
        }
    }
}

export { };
