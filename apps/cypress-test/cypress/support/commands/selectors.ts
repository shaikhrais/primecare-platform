export { };

declare global {
    namespace Cypress {
        interface Chainable {
            getByCy(value: string, options?: Partial<Cypress.Timeoutable>): Chainable<JQuery<HTMLElement>>;
            withinByCy(value: string, fn: () => void): Chainable<void>;
        }
    }
}

Cypress.Commands.add("getByCy", (value: string, options = {}) => {
    return cy.get(`[data-cy="${value}"]`, { timeout: 10000, ...options });
});

Cypress.Commands.add("withinByCy", (value: string, fn: () => void) => {
    cy.getByCy(value).within(fn);
});
