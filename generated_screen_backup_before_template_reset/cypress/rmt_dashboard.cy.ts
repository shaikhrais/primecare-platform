describe('RmtDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/rmt/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="rmt_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
