export { };

declare global {
    namespace Cypress {
        interface Chainable {
            assertContract(selectors: string[]): Chainable<void>;
        }
    }
}

Cypress.Commands.add("assertContract", (selectors: string[]) => {
    selectors.forEach((s) => {
        cy.log(`Checking contract element: [data-cy="${s}"]`);
        cy.get(`[data-cy="${s}"]`, { timeout: 10000 }).should("exist").and("be.visible");
    });
});
