describe('Intake Coordinator New Intakes E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/intake-coordinator-new-intakes');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="intake_coordinator_new_intakes-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
