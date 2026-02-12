export function adminSession() {
    cy.session("admin", () => {
        cy.loginAs("staff"); // Admin UI usually uses staff role in this project
    });
}
