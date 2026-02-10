export { };

declare global {
    namespace Cypress {
        interface Chainable {
            stubDashboardOk(): Chainable<void>;
            stubDashboardEmpty(): Chainable<void>;
            stubDashboard500(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("stubDashboardOk", () => {
    cy.intercept("GET", "**/dashboard**", { fixture: "stubs/dashboard.ok.json" }).as("dashOk");
});

Cypress.Commands.add("stubDashboardEmpty", () => {
    cy.intercept("GET", "**/dashboard**", { fixture: "stubs/dashboard.empty.json" }).as("dashEmpty");
});

Cypress.Commands.add("stubDashboard500", () => {
    cy.intercept("GET", "**/dashboard**", { statusCode: 500, fixture: "stubs/dashboard.500.json" }).as("dashError");
});
