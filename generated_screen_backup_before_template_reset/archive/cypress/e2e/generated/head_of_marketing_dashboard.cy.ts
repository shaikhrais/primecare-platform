describe('HeadOfMarketingDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/head_of_marketing/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="head_of_marketing_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
