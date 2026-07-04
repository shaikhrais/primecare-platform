describe('Cfo Financial Overview E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/cfo/financial-overview');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="cfo_financial_overview-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
