export function pswSession() {
    cy.session("psw", () => {
        cy.loginAs("psw");
    });
}
