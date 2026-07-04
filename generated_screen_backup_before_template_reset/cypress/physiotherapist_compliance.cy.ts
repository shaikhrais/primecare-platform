describe('PhysiotherapistComplianceScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/compliance');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="physiotherapist_compliance-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
