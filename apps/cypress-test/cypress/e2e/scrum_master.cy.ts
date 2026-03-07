describe('Scrum Master Role E2E', () => {
    beforeEach(() => {
        cy.loginAs('scrum_master');
    });

    it('should view system health monitor', () => {
        cy.visit('/platform/scrum-master/monitoring');
        cy.contains('System Health Monitor').should('be.visible');
    });

    it('should run registry integrity check', () => {
        cy.visit('/platform/scrum-master/registry-check');
        cy.contains('Registry Integrity').should('be.visible');
    });

    it('should access the response bot', () => {
        cy.visit('/platform/scrum-master/response-bot');
        cy.contains('Response Bot').should('be.visible');
    });
});
