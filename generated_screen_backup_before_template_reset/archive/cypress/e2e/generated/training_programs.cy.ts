describe('Training Programs E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/training-programs');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="training_programs-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
