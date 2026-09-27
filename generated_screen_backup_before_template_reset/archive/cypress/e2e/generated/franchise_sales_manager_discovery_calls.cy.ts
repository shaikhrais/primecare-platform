describe('Franchise Sales Manager Discovery Calls E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/business_development/roles/franchise_sales_manager/discovery-calls');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="franchise_sales_manager_discovery_calls-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
