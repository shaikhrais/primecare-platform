describe('IntakeCoordinatorWorkflowScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/intake_coordinator/coordinator-workflow');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="intake_coordinator_workflow-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
