describe('Coordinator Role E2E', () => {
    beforeEach(() => {
        cy.loginAs('coordinator');
    });

    it('should view the dispatch center', () => {
        cy.visit('/tenancy/coordinator/dispatch');
        cy.contains('Dispatch Hub').should('be.visible');
    });

    it('should respond to SOS alerts', () => {
        cy.visit('/tenancy/coordinator/sos');
        cy.contains('SOS Emergency Center').should('be.visible');
    });

    it('should view the master schedule', () => {
        cy.visit('/tenancy/coordinator/schedule');
        cy.contains('Master Schedule').should('be.visible');
    });
});
