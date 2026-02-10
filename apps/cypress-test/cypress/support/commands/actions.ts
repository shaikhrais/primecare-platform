export { };

declare global {
    namespace Cypress {
        interface Chainable {
            clickByCy(value: string): Chainable<void>;
            typeByCy(value: string, text: string): Chainable<void>;
            clearAndTypeByCy(value: string, text: string): Chainable<void>;
            checkByCy(value: string): Chainable<void>;
        }
    }
}

Cypress.Commands.add("clickByCy", (value: string) => {
    cy.getByCy(value).should("be.visible").and("not.be.disabled").click();
});

Cypress.Commands.add("typeByCy", (value: string, text: string) => {
    cy.getByCy(value).should("be.visible").type(text, { delay: 0 });
});

Cypress.Commands.add("clearAndTypeByCy", (value: string, text: string) => {
    cy.getByCy(value).should("be.visible").clear().type(text, { delay: 0 });
});

Cypress.Commands.add("checkByCy", (value: string) => {
    cy.getByCy(value).should("be.visible").check({ force: true });
});
