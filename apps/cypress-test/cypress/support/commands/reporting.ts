export { };

declare global {
    namespace Cypress {
        interface Chainable {
            step(title: string): Chainable<void>;
            attachJson(name: string, data: any): Chainable<void>;
        }
    }
}

Cypress.Commands.add("step", (title: string) => {
    cy.log(`🧭 STEP: ${title}`);
});

Cypress.Commands.add("attachJson", (name: string, data: any) => {
    cy.log(`📎 ${name}: ${JSON.stringify(data)}`);
});
