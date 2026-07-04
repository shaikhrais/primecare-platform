describe('ClinicalDirectorPerformanceScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/clinical_director/performance');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="clinical_director_performance-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
