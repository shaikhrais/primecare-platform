describe('Client Role - Care Request Flow', () => {
    beforeEach(() => {
        cy.login('client@primecare.com', 'client');
    });

    it('should navigate to bookings and request care', () => {
        cy.contains('Bookings').click();
        cy.get('button').contains('Request Care').should('be.visible').click();

        // Fill the request modal
        cy.get('select').select(1); // Select the first available service
        cy.get('input[type="datetime-local"]').first().type('2026-03-01T10:00');
        cy.get('input[type="number"]').first().clear().type('120'); // 2 hours
        cy.get('textarea').type('Test instructions for the caregiver.');

        cy.get('button').contains('Submit Request').click();

        // Verify success message or modal closure
        cy.contains('Request submitted successfully').should('be.visible');

        // Verify it appears in the list
        cy.contains('requested').should('be.visible');
    });

    it('should view invoices in billing section', () => {
        cy.contains('Billing').click();
        cy.get('table').should('be.visible');
        cy.contains('CAD').should('exist');
    });

    it('should update profile preferences', () => {
        cy.contains('Profile').click();
        cy.get('textarea').clear().type('Allergic to cats. Prefers morning visits.');
        cy.get('button').contains('Save Changes').click();
        cy.contains('Profile updated').should('be.visible');
    });
});
