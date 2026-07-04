describe('PhysiotherapistBillingLinkScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/billing-link');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="physiotherapist_billing_link-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
