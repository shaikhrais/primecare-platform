describe('OfficeComplianceScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/common/office-compliance');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="office_compliance-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
