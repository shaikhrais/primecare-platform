// Protocol B: Lightweight Clinical Router & Code Presence Sweep Spec.
// Automatically validates that all high-priority clinical routes load cleanly,
// mounting dynamic shells and preventing 404 redirection errors.

describe("Protocol B: Clinical Router & Code Presence Sweep", () => {
  const testFlows = [
    {
      role: "psw",
      screens: [
        { name: "PSW Dashboard", route: "/offices/clinical/roles/psw/dashboard" },
        { name: "PSW Workflow", route: "/offices/clinical/roles/psw/psw-workflow" }
      ]
    },
    {
      role: "rn",
      screens: [
        { name: "RN Workflow", route: "/offices/clinical/roles/rn/rn-workflow" },
        { name: "RN Analytics", route: "/offices/clinical/roles/rn/rn-analytics" }
      ]
    },
    {
      role: "rpn",
      screens: [
        { name: "RPN Workflow", route: "/offices/clinical/roles/rpn/rpn-workflow" }
      ]
    },
    {
      role: "clinical_director",
      screens: [
        { name: "Clinical Dashboard", route: "/offices/clinical/roles/clinical_director/dashboard" }
      ]
    }
  ];

  testFlows.forEach(({ role, screens }) => {
    describe(`Clinical route sweep for role: ${role}`, () => {
      beforeEach(() => {
        // Authenticate session for clinical role
        cy.task("log", `🔑 Authenticating session for role: ${role}`);
        cy.loginAsRole(role);
      });

      screens.forEach(({ name, route }) => {
        it(`verifies code presence and mounts route: ${name} (${route})`, () => {
          cy.task("log", `🚀 Navigating to ${name} route: ${route}`);
          cy.visitWithSemantics(route);
          cy.waitAndSee();

          cy.task("log", `🔍 Asserting App Shell mounts cleanly`);
          cy.verifyShellExists();
          cy.verifyNotBlank();

          // Ensure it doesn't show 404 or redirection boundaries
          cy.contains("Page Not Found").should("not.exist");
          cy.contains("404").should("not.exist");
          
          cy.task("log", `✅ Route '${name}' loaded successfully!`);
        });
      });
    });
  });
});
