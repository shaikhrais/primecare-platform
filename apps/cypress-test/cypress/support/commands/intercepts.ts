export { };

declare global {
    namespace Cypress {
        interface Chainable {
            stubHomeOk(): Chainable<void>;
            stubHomeEmpty(): Chainable<void>;
            stubHome500(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("stubHomeOk", () => {
    cy.intercept("GET", "**/home**", { fixture: "stubs/home.ok.json" }).as("dashOk");
});

Cypress.Commands.add("stubHomeEmpty", () => {
    cy.intercept("GET", "**/home**", { fixture: "stubs/home.empty.json" }).as("dashEmpty");
});

Cypress.Commands.add("stubHome500", () => {
    cy.intercept("GET", "**/home**", { statusCode: 500, fixture: "stubs/home.500.json" }).as("dashError");
});
