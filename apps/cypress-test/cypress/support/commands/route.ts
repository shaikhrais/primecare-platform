export { };

declare global {
    namespace Cypress {
        interface Chainable {
            visitRoute(baseUrlEnv: string, path: string): Chainable<void>;
            assertRedirectToLogin(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("visitRoute", (baseUrlEnv: string, path: string) => {
    const baseUrl = Cypress.env(baseUrlEnv) || Cypress.config("baseUrl");
    const url = new URL(path, baseUrl).toString();
    cy.log(`Visiting: ${url}`);
    cy.visit(url, { failOnStatusCode: false });
});

Cypress.Commands.add("visitAppRoute", (baseUrlEnv: string, path: string) => {
    cy.visitRoute(baseUrlEnv, path);
});

Cypress.Commands.add("assertRedirectToLogin", () => {
    cy.url().should("include", "/login");
});
