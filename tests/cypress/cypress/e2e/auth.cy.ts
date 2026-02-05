describe('Authentication Flow', () => {
    const roles = [
        { name: 'Admin', email: 'admin@primecare.com', role: 'admin' },
        { name: 'Staff', email: 'staff@primecare.com', role: 'staff' },
        { name: 'Client', email: 'client@primecare.com', role: 'client' },
        { name: 'PSW', email: 'psw@primecare.com', role: 'psw' }
    ];

    roles.forEach((user) => {
        it(`should successfully login as ${user.name}`, () => {
            cy.login(user.email, user.role);
            cy.contains('Dashboard').should('be.visible');

            // Verify role-specific title in sidebar
            const portalTitle = user.role === 'admin' ? 'Admin' :
                user.role === 'psw' ? 'Caregiver' :
                    user.role === 'staff' ? 'Staff' : 'Family';

            cy.get('aside').should('contain', portalTitle);
        });
    });

    it('should logout successfully', () => {
        cy.login('admin@primecare.com', 'admin');
        cy.get('button').contains('admin@').click();
        cy.contains('Log out').click();
        cy.url().should('include', '/login');
    });
});
