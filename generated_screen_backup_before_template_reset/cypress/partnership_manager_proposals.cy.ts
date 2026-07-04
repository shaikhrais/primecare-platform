describe('Partnership Manager Proposals E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/business_development/roles/partnership_manager/proposals');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="partnership_manager_proposals-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
