describe('Admin Notifications', () => {
    beforeEach(() => {
        // Mock login or direct access if supported
        cy.visit(Cypress.env('ADMIN_BASE_URL') + '/admin/dashboard');
        // Basic auth bypass or login steps would go here
        // For now assuming public or mock auth
    });

    it('should display notifications and allow drill-down', () => {
        // 1. Check Bell Icon
        cy.get('button[aria-label="Notifications"]').should('exist');
        // Mock data usually starts with 3 unread
        cy.get('button[aria-label="Notifications"] span').should('contain', '3');

        // 2. Open Hub
        cy.get('button[aria-label="Notifications"]').click();
        cy.contains('Notifications').should('be.visible');

        // 3. Check for specific notification
        cy.contains('New Incident Reported').should('be.visible');

        // 4. Click and Drill Down
        cy.contains('New Incident Reported').click();

        // 5. Verify URL
        cy.url().should('include', '/admin/incidents');

        // 6. Verify Read Status (badge count should decrease)
        cy.get('button[aria-label="Notifications"] span').should('contain', '2');
    });
});
