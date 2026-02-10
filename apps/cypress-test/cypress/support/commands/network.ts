export { };

declare global {
    namespace Cypress {
        interface Chainable {
            interceptManagerCore(): Chainable<void>;
            interceptAdminCore(): Chainable<void>;
            waitForNetworkIdle(aliasList?: string[]): Chainable<void>;
        }
    }
}

Cypress.Commands.add("interceptManagerCore", () => {
    cy.intercept("GET", "**/manager/dashboard/**").as("getDashboard");
    cy.intercept("GET", "**/manager/dashboard/today").as("getShifts");
    cy.intercept("POST", "**/daily-entry**").as("postDailyEntry");
});

Cypress.Commands.add("interceptAdminCore", () => {
    cy.intercept("GET", "**/api/admin/users**").as("getUsers");
    cy.intercept("POST", "**/api/admin/users**").as("createUser");
});

Cypress.Commands.add("waitForNetworkIdle", (aliasList: string[] = []) => {
    aliasList.forEach((a) => cy.wait(a));
});
