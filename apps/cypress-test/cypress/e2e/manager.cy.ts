describe('Manager Role E2E', () => {
    beforeEach(() => {
        cy.loginAs('manager');
    });

    it('should view the operations home', () => {
        cy.visit('/tenancy/manager/home');
        cy.contains('Operations Overview').should('be.visible');
    });

    it('should monitor compliance', () => {
        cy.visit('/tenancy/manager/compliance');
        cy.contains('Compliance Hub').should('be.visible');
    });

    it('should view finance hub', () => {
        cy.visit('/tenancy/manager/finance');
        cy.contains('Finance & Payroll').should('be.visible');
    });

    it('should manage the team', () => {
        cy.visit('/tenancy/manager/team');
        cy.contains('User Management').should('be.visible');
    });
});
