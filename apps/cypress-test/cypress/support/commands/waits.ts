export { };

declare global {
    namespace Cypress {
        interface Chainable {
            waitForByCy(value: string): Chainable<JQuery<HTMLElement>>;
            waitUntilGoneByCy(value: string): Chainable<void>;
            waitForPageReady(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("waitForByCy", (value: string) => {
    return cy.getByCy(value, { timeout: 20000 }).should("be.visible");
});

Cypress.Commands.add("waitUntilGoneByCy", (value: string) => {
    cy.get(`[data-cy="${value}"]`, { timeout: 20000 }).should("not.exist");
});

Cypress.Commands.add("waitForPageReady", () => {
    cy.document().its("readyState").should("eq", "complete");
});
