export { };

declare global {
    namespace Cypress {
        interface Chainable {
            assertNoAppCrash(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("assertNoAppCrash", () => {
    cy.get("body").should("not.contain", "Application error");
    cy.get("body").should("not.contain", "Uncaught");
    cy.get("body").should("not.contain", "TypeError");
});
