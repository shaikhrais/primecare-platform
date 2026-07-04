describe('Regional Bdm Franchise Pipeline E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/business_development/roles/regional_bdm/franchise-pipeline');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="regional_bdm_franchise_pipeline-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
