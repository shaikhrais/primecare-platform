export { };

declare global {
    namespace Cypress {
        interface Chainable {
            visitRoute(baseUrlEnv: string, path: string): Chainable<void>;
            visitAppRoute(baseUrlEnv: string, path: string): Chainable<void>;
            handleCookieConsent(): Chainable<void>;
            assertRedirectToLogin(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("visitRoute", (baseUrlEnv: string, path: string) => {
    const baseUrl = Cypress.env(baseUrlEnv) || Cypress.config("baseUrl");
    if (!baseUrl) {
        throw new Error(`Environment variable ${baseUrlEnv} is not defined and no baseUrl config found.`);
    }
    const url = new URL(path, baseUrl).toString();
    cy.log(`Visiting: ${url}`);
    cy.visit(url, { failOnStatusCode: false });
    cy.handleCookieConsent();
});

Cypress.Commands.add("visitAppRoute", (baseUrlEnv: string, path: string) => {
    cy.visitRoute(baseUrlEnv, path);
});

Cypress.Commands.add("handleCookieConsent", () => {
    cy.get("body").then(($body) => {
        if ($body.find('button:contains("Accept All")').length > 0) {
            cy.contains("button", "Accept All").click({ force: true });
        }
    });
});

Cypress.Commands.add("assertRedirectToLogin", () => {
    cy.url().should("include", "/login");
});
