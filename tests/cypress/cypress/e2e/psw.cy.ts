describe('PSW Role - Visit Execution Flow', () => {
    beforeEach(() => {
        cy.login('psw@primecare.com', 'psw');
    });

    it('should view upcoming visits (shifts)', () => {
        cy.contains('Shifts').click();
        cy.get('.visit-card').should('exist'); // Assuming class exists or adjusting as per actual UI
    });

    it('should simulate visit check-in and check-out', () => {
        // Mock location for a successful check-in (near client)
        cy.mockGeolocation(43.6532, -79.3832);

        cy.contains('Shifts').click();
        cy.get('button').contains('Check In').first().click();

        cy.contains('In Progress').should('be.visible');

        // Submit note
        cy.get('textarea[placeholder="Add a visit note..."]').type('Client is doing well today.');
        cy.get('button').contains('Save Note').click();

        // Check out
        cy.get('button').contains('Check Out').click();
        cy.contains('Completed').should('be.visible');
    });

    it('should report an incident during visit', () => {
        cy.contains('Support').click();
        cy.get('button').contains('Report Incident').click();
        cy.get('select').select('fall_risk');
        cy.get('textarea').type('Client tripped on a rug. No injuries reported.');
        cy.get('button').contains('Submit Report').click();
        cy.contains('Incident reported').should('be.visible');
    });
});
