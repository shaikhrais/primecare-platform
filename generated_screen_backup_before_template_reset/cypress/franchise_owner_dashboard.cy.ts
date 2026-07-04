describe('Franchise Owner Dashboard E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/franchise/roles/franchise_owner/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="franchise_owner_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
