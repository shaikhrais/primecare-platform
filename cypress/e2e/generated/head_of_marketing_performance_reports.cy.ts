describe('Head Of Marketing Performance Reports E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/head-of-marketing-performance-reports');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="head_of_marketing_performance_reports-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
