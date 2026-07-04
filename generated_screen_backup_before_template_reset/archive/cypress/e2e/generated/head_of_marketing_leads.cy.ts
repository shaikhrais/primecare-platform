describe('Head Of Marketing Leads E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/head-of-marketing-leads');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="head_of_marketing_leads-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
