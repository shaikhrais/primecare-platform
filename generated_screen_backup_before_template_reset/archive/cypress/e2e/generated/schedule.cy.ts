describe('ScheduleScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/caregiver/psw-schedule');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="schedule-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
