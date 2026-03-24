describe('Client Role E2E', () => {
    beforeEach(() => {
        cy.loginAs('client');
    });

    it('should view the family hub', () => {
        cy.visit('/tenancy/client/home');
        cy.contains('Family Care Feed').should('be.visible');
    });

    it('should manage bookings', () => {
        cy.visit('/tenancy/client/bookings');
        cy.contains('My Bookings').should('be.visible');
    });

    it('should view invoices', () => {
        cy.visit('/tenancy/client/invoices');
        cy.contains('Billing & Invoices').should('be.visible');
    });
});
