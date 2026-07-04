describe('CfoDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/cfo/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="cfo_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
