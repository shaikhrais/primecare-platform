describe('Ceo Franchise Overview E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/ceo/franchise-overview');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="ceo_franchise_overview-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
