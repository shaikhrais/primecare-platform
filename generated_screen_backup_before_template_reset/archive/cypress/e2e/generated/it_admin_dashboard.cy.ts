describe('It Admin Dashboard E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/it_admin/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="it_admin_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
