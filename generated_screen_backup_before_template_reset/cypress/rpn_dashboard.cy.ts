describe('RpnDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/rpn/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="rpn_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
