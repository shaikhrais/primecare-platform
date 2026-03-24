describe('PSW Role E2E', () => {
    beforeEach(() => {
        cy.loginAs('psw');
    });

    it('should view the home and wellness pulse', () => {
        cy.visit('/tenancy/psw/home');
        cy.contains('Wellness Pulse').should('be.visible');
        cy.contains('My Schedule').should('be.visible');
    });

    it('should view the schedule', () => {
        cy.visit('/tenancy/psw/schedule');
        cy.contains('Daily Schedule').should('be.visible');
    });

    it('should enter a live visit', () => {
        cy.visit('/tenancy/psw/schedule/live');
        cy.contains('Live Visit').should('be.visible');
        cy.contains('Clock In').should('be.visible');
    });

    it('should submit a handover', () => {
        cy.visit('/tenancy/psw/handover');
        cy.contains('Handover Report').should('be.visible');
    });
});
