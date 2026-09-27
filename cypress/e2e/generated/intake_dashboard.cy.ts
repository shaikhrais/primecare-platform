describe('IntakeDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/intake_coordinator/dashboard-dup-1');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="intake_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
