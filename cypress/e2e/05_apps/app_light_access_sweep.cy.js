// Protocol A: Lightweight Role Access & Zero-Trust Route Sweep Spec.
// Automatically validates login sanity, CanvasKit container loading, and boundary isolation.

describe("Protocol A: Lightweight Role Access & Zero-Trust Route Sweep", () => {
  const clinicRoles = [
    { role: "psw", titleId: "pswdashboard-title" },
    { role: "rn", titleId: "rndashboard-title" },
    { role: "clinical_director", titleId: "clinicaldirectordashboard-title" },
    { role: "chiropractor", titleId: "chiropractordashboard-title" },
    { role: "physio", titleId: "physiotherapistdashboard-title" },
    { role: "rmt", titleId: "rmtdashboard-title" }
  ];

  clinicRoles.forEach(({ role, titleId }) => {
    it(`performs login, shell verification, and access guard boundaries for role: ${role}`, () => {
      // 1. Authenticate via SSO dynamically
      cy.task("log", `🔑 Sanity: Authenticating session for role: ${role}`);
      cy.loginAsRole(role);

      // 2. Fetch target user profile from fixtures
      cy.fixture("governance/test_users.json").then((users) => {
        const user = users.find((u) => u.role_code === role);
        expect(user).to.exist;

        // 3. Visit and verify landing route
        cy.task("log", `🚀 Sanity: Navigating to landing page ${user.post_login_route}`);
        cy.visitWithSemantics(user.post_login_route);
        cy.waitAndSee();

        cy.task("log", `🔍 Sanity: Verifying App Shell elements`);
        cy.verifyShellExists();
        cy.verifyNotBlank();

        // 4. Verify landing screen-specific title selector
        cy.task("log", `🎯 Sanity: Verifying header title selector: ${titleId}`);
        cy.getCy(titleId).should("be.visible");

        // 5. Zero-Trust Access Boundary intrusion check: attempt to hit unauthorized role routes
        const unauthorizedRoute = role === "clinical_director" 
          ? "/offices/clinical/roles/psw/dashboard" 
          : "/offices/clinical/roles/clinical_director/dashboard";

        cy.task("log", `🛡️ Zero-Trust Check: Testing intrusion block on ${unauthorizedRoute}`);
        cy.visit(unauthorizedRoute, { failOnStatusCode: false });
        cy.wait(3000);
        
        // Assert that RouteGuard correctly blocked access and mounted the governed "Access Denied" view
        cy.contains("Access Denied", { timeout: 10000 }).should("be.visible");
      });
    });
  });
});
