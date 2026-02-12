export function managerSession() {
    cy.session("manager", () => {
        cy.loginAs("manager");
    });
}
