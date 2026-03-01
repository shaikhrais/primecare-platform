describe('Knowledge Base - Role Playbooks', () => {
    const roles = [
        "super-admin", "admin", "regional-manager", "operations-manager",
        "hr-manager", "clinical-manager", "finance-manager", "marketing-manager",
        "recruiting-manager", "manager", "coordinator", "staff", "finance",
        "client", "rn", "psw", "rmt", "rpt", "rch"
    ];

    beforeEach(() => {
        // Intercept API calls to simulate a logged-in session, assuming JWT auth in local storage
        window.localStorage.setItem('auth_token', 'fake-jwt-token');

        // We stub out the user profile response so we bypass the login screen entirely
        cy.intercept('GET', '**/api/v1/auth/me', {
            statusCode: 200,
            body: {
                id: '1',
                email: 'test@primecare.com',
                roles: ['super_admin'] // Super admin has access to everything
            }
        }).as('getMe');
    });

    it('successfully loads the Knowledge Base Index', () => {
        cy.visit('/knowledge-base');
        cy.wait('@getMe');

        cy.get('h1').contains('Business Knowledge Base');
        cy.contains('Role-Based Deep Dives & Gap Analysis');

        // Verify 19 links exist
        roles.forEach(role => {
            cy.get(`a[href="/knowledge-base/role-${role}"]`).should('exist');
        });
    });

    roles.forEach((role) => {
        it(`successfully navigates to and renders the playbook for: ${role.replace(/-/g, '_').toUpperCase()}`, () => {
            cy.visit(`/knowledge-base/role-${role}`);
            cy.wait('@getMe');

            // The markdown renderer should fetch the md file and render it
            cy.get('.markdown-content', { timeout: 10000 }).should('be.visible');
            cy.get('.markdown-content h1').contains(`Role Playbook: ${role.replace(/-/g, '_').toUpperCase()}`);
            cy.get('.markdown-content').contains('1. The Persona & Purpose');
            cy.get('.markdown-content').contains('4. ⚠️ Gap Analysis: What is Missing?');
        });
    });
});
