describe('Partnership Manager Active Deals E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/business_development/roles/partnership_manager/active-deals');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="partnership_manager_active_deals-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
