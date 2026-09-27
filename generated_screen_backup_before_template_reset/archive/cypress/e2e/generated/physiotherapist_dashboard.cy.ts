describe('PhysiotherapistDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="physiotherapist_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
