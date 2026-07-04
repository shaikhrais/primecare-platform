describe('PhysiotherapistWorkflowScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/workflow');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="physiotherapist_workflow-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
