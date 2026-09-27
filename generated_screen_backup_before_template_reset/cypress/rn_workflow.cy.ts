describe('RnWorkflowScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/rn/rn-workflow');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="rn_workflow-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
