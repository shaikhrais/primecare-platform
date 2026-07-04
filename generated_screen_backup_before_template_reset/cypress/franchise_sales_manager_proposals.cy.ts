describe('Franchise Sales Manager Proposals E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/business_development/roles/franchise_sales_manager/proposals');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="franchise_sales_manager_proposals-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
