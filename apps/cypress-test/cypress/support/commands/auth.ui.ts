import { MGR } from "../selectors/manager.cy";
import { ADM } from "../selectors/admin.cy";

export { };

declare global {
    namespace Cypress {
        interface Chainable {
            loginAsAdmin(): Chainable<void>;
            loginAsManager(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("loginAsAdmin", () => {
    const baseUrl = Cypress.config("baseUrl");
    cy.visit(`${baseUrl}/admin/login`);
    cy.waitForPageReady();

    cy.step("Login as Admin");
    cy.clearAndTypeByCy(ADM.loginEmail, Cypress.env("ADMIN_EMAIL") || "admin@example.com");
    cy.clearAndTypeByCy(ADM.loginPassword, Cypress.env("ADMIN_PASSWORD") || "password");
    cy.clickByCy(ADM.loginSubmit);

    cy.waitForByCy(ADM.dashboard);
});

Cypress.Commands.add("loginAsManager", () => {
    const baseUrl = Cypress.config("baseUrl");
    cy.visit(`${baseUrl}/manager/login`);
    cy.waitForPageReady();

    cy.step("Login as Manager");
    cy.clearAndTypeByCy(MGR.loginEmail, Cypress.env("MANAGER_EMAIL") || "manager@example.com");
    cy.clearAndTypeByCy(MGR.loginPassword, Cypress.env("MANAGER_PASSWORD") || "password");
    cy.clickByCy(MGR.loginSubmit);

    cy.waitForByCy(MGR.dashboard);
});
