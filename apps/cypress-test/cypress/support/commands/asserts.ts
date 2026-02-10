export { };

declare global {
    namespace Cypress {
        interface Chainable {
            shouldSeeByCy(value: string): Chainable<void>;
            shouldHaveTextByCy(value: string, text: string): Chainable<void>;
        }
    }
}

Cypress.Commands.add("shouldSeeByCy", (value: string) => {
    cy.getByCy(value).should("be.visible");
});

Cypress.Commands.add("shouldHaveTextByCy", (value: string, text: string) => {
    cy.getByCy(value).should("be.visible").and("contain.text", text);
});
