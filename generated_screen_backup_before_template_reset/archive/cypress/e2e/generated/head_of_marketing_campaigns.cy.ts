describe('Head Of Marketing Campaigns E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/head-of-marketing-campaigns');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="head_of_marketing_campaigns-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
