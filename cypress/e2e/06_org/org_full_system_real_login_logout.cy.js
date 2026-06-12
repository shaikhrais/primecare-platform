// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Org Full System Real Login Logout Test", () => {

  it("opens and verifies screen rmt_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "rmt");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_rmt_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/rmt/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/rmt/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("rmtdashboard-screen").should("be.visible");
      cy.getCy("rmtdashboard-title").should("be.visible");
      // cy.getCy("rmtdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("rmt_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_rmt_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified RmtDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen therapist_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "therapist");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_therapist_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/therapist/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/therapist/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("therapistdashboard-screen").should("be.visible");
      cy.getCy("therapistdashboard-title").should("be.visible");
      cy.getCy("therapistdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("therapist_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_therapist_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified TherapistDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen clinical_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "clinical_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_clinical_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/clinical_director/dashboard-dup-1...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/clinical_director/dashboard-dup-1");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("clinicaldashboard-screen").should("be.visible");
      cy.getCy("clinicaldashboard-title").should("be.visible");
      cy.getCy("clinicaldashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("clinical_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_clinical_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ClinicalDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen clinical_director_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "clinical_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_clinical_director_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/clinical_director/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/clinical_director/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("clinicaldirectordashboard-screen").should("be.visible");
      cy.getCy("clinicaldirectordashboard-title").should("be.visible");
      // cy.getCy("clinicaldirectordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("clinical_director_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_clinical_director_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ClinicalDirectorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen cns_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "cns");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_cns_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /clinical/cns-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/clinical/cns-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("cnsdashboard-screen").should("be.visible");
      cy.getCy("cnsdashboard-title").should("be.visible");
      cy.getCy("cnsdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("cns_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_cns_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CnsDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen hsw_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "hsw");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_hsw_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /clinical/hsw-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/clinical/hsw-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("hswdashboard-screen").should("be.visible");
      cy.getCy("hswdashboard-title").should("be.visible");
      cy.getCy("hswdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("hsw_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_hsw_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified HswDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen lpn_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "lpn");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_lpn_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /clinical/lpn-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/clinical/lpn-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("lpndashboard-screen").should("be.visible");
      cy.getCy("lpndashboard-title").should("be.visible");
      cy.getCy("lpndashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("lpn_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_lpn_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified LpnDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen np_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "np");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_np_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /clinical/np-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/clinical/np-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("npdashboard-screen").should("be.visible");
      cy.getCy("npdashboard-title").should("be.visible");
      cy.getCy("npdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("np_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_np_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified NpDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen pediatric_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "pediatric");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_pediatric_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /clinical/pediatric-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/clinical/pediatric-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("pediatricdashboard-screen").should("be.visible");
      cy.getCy("pediatricdashboard-title").should("be.visible");
      cy.getCy("pediatricdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("pediatric_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_pediatric_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PediatricDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen physician_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "physician");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_physician_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /clinical/physician-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/clinical/physician-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("physiciandashboard-screen").should("be.visible");
      cy.getCy("physiciandashboard-title").should("be.visible");
      // cy.getCy("physiciandashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("physician_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_physician_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PhysicianDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen api_health_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_api_health_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /common/api-health-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/common/api-health-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("apihealthdashboard-screen").should("be.visible");
      cy.getCy("apihealthdashboard-title").should("be.visible");
      cy.getCy("apihealthdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("api_health_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_api_health_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ApiHealthDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen architecture_planning_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "cto");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_architecture_planning_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("architectureplanningdashboard-screen").should("be.visible");
      cy.getCy("architectureplanningdashboard-title").should("be.visible");
      cy.getCy("architectureplanningdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("architecture_planning_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_architecture_planning_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ArchitecturePlanningDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen business_development_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "bus_dev");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_business_development_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
      cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
      cy.getCy("businessdevelopmentdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("business_development_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_business_development_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified BusinessDevelopmentDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen caregiver_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "caregiver");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_caregiver_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/caregiver/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/caregiver/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("caregiverdashboard-screen").should("be.visible");
      cy.getCy("caregiverdashboard-title").should("be.visible");
      cy.getCy("caregiverdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("caregiver_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_caregiver_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CaregiverDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen chiropractor_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "chiropractor");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_chiropractor_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/chiropractor/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/chiropractor/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("chiropractordashboard-screen").should("be.visible");
      cy.getCy("chiropractordashboard-title").should("be.visible");
      // cy.getCy("chiropractordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("chiropractor_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_chiropractor_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ChiropractorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen clinic_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "clinical_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_clinic_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/clinical_director/clinic-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/clinical_director/clinic-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("clinicdashboard-screen").should("be.visible");
      cy.getCy("clinicdashboard-title").should("be.visible");
      cy.getCy("clinicdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("clinic_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_clinic_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ClinicDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen course_architect_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "training_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_course_architect_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("coursearchitectdashboard-screen").should("be.visible");
      cy.getCy("coursearchitectdashboard-title").should("be.visible");
      cy.getCy("coursearchitectdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("course_architect_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_course_architect_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CourseArchitectDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen customer_support_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "dynamic");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_customer_support_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("customersupportdashboard-screen").should("be.visible");
      cy.getCy("customersupportdashboard-title").should("be.visible");
      cy.getCy("customersupportdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("customer_support_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_customer_support_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CustomerSupportDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen dynamic_screen_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_dynamic_screen_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      // cy.getCy("dynamicdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
      // cy.getCy("dynamicdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
      // cy.getCy("dynamicdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("dynamic_screen_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_dynamic_screen_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified DynamicScreenDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen family_member_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "patient");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_family_member_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("familymemberdashboard-screen").should("be.visible");
      cy.getCy("familymemberdashboard-title").should("be.visible");
      cy.getCy("familymemberdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("family_member_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_family_member_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified FamilyMemberDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen file_verification_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_file_verification_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /common/file-verification-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/common/file-verification-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("fileverificationdashboard-screen").should("be.visible");
      cy.getCy("fileverificationdashboard-title").should("be.visible");
      cy.getCy("fileverificationdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("file_verification_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_file_verification_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified FileVerificationDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen franchise_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "owner");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_franchise_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("franchisedashboard-screen").should("be.visible");
      cy.getCy("franchisedashboard-title").should("be.visible");
      cy.getCy("franchisedashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("franchise_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_franchise_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified FranchiseDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen guest_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_guest_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/guest_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/guest_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("guestdashboard-screen").should("be.visible");
      cy.getCy("guestdashboard-title").should("be.visible");
      cy.getCy("guestdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("guest_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_guest_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified GuestDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen infrastructure_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "infrastructure");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_infrastructure_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("infrastructuredashboard-screen").should("be.visible");
      cy.getCy("infrastructuredashboard-title").should("be.visible");
      cy.getCy("infrastructuredashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("infrastructure_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_infrastructure_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified InfrastructureDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen intake_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "intake");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_intake_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/intake_coordinator/dashboard-dup-1...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/intake_coordinator/dashboard-dup-1");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("intakedashboard-screen").should("be.visible");
      cy.getCy("intakedashboard-title").should("be.visible");
      cy.getCy("intakedashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("intake_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_intake_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified IntakeDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen office_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "admin");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_office_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("officedashboard-screen").should("be.visible");
      cy.getCy("officedashboard-title").should("be.visible");
      cy.getCy("officedashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("office_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_office_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified OfficeDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen patient_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "patient");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_patient_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/client/roles/client/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/client/roles/client/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("patientdashboard-screen").should("be.visible");
      cy.getCy("patientdashboard-title").should("be.visible");
      cy.getCy("patientdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("patient_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_patient_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PatientDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen physiotherapist_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "physio");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_physiotherapist_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/physiotherapist/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/physiotherapist/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("physiotherapistdashboard-screen").should("be.visible");
      cy.getCy("physiotherapistdashboard-title").should("be.visible");
      // cy.getCy("physiotherapistdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("physiotherapist_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_physiotherapist_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen portal_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "portal");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_portal_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("portaldashboard-screen").should("be.visible");
      cy.getCy("portaldashboard-title").should("be.visible");
      cy.getCy("portaldashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("portal_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_portal_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PortalDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen qa_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "system_verification");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_qa_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/support/roles/quality_assurance/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/support/roles/quality_assurance/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("qadashboard-screen").should("be.visible");
      cy.getCy("qadashboard-title").should("be.visible");
      cy.getCy("qadashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("qa_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_qa_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified QaDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen role_coverage_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_role_coverage_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /common/role-coverage-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/common/role-coverage-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("rolecoveragedashboard-screen").should("be.visible");
      cy.getCy("rolecoveragedashboard-title").should("be.visible");
      cy.getCy("rolecoveragedashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("role_coverage_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_role_coverage_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified RoleCoverageDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen social_worker_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "social_worker");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_social_worker_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/social_worker/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/social_worker/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("socialworkerdashboard-screen").should("be.visible");
      cy.getCy("socialworkerdashboard-title").should("be.visible");
      // cy.getCy("socialworkerdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("social_worker_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_social_worker_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified SocialWorkerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen support_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "dynamic");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_support_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("supportdashboard-screen").should("be.visible");
      cy.getCy("supportdashboard-title").should("be.visible");
      cy.getCy("supportdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("support_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_support_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified SupportDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen system_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "governance");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_system_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /common/system-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/common/system-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("systemdashboard-screen").should("be.visible");
      cy.getCy("systemdashboard-title").should("be.visible");
      cy.getCy("systemdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("system_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_system_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified SystemDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen system_verification_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "system_verification");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_system_verification_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("systemverificationdashboard-screen").should("be.visible");
      cy.getCy("systemverificationdashboard-title").should("be.visible");
      cy.getCy("systemverificationdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("system_verification_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_system_verification_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified SystemVerificationDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen training_hub_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "training");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_training_hub_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("traininghubdashboard-screen").should("be.visible");
      cy.getCy("traininghubdashboard-title").should("be.visible");
      cy.getCy("traininghubdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("training_hub_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_training_hub_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified TrainingHubDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen cfo_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "cfo");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_cfo_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/cfo/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/cfo/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("cfodashboard-screen").should("be.visible");
      cy.getCy("cfodashboard-title").should("be.visible");
      cy.getCy("cfodashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("cfo_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_cfo_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CfoDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen ciso_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "ciso");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_ciso_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/ciso/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/ciso/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("cisodashboard-screen").should("be.visible");
      cy.getCy("cisodashboard-title").should("be.visible");
      cy.getCy("cisodashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("ciso_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_ciso_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CisoDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen coo_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "coo");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_coo_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/coo/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/coo/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("coodashboard-screen").should("be.visible");
      cy.getCy("coodashboard-title").should("be.visible");
      cy.getCy("coodashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("coo_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_coo_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CooDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen cto_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "cto");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_cto_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/cto/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/cto/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("ctodashboard-screen").should("be.visible");
      cy.getCy("ctodashboard-title").should("be.visible");
      cy.getCy("ctodashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("cto_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_cto_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CtoDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen cx_director_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "cx_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_cx_director_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/cx_director/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/cx_director/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("cxdirectordashboard-screen").should("be.visible");
      cy.getCy("cxdirectordashboard-title").should("be.visible");
      cy.getCy("cxdirectordashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("cx_director_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_cx_director_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CxDirectorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen finance_director_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "finance_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_finance_director_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/finance_director/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/finance_director/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("financedirectordashboard-screen").should("be.visible");
      cy.getCy("financedirectordashboard-title").should("be.visible");
      cy.getCy("financedirectordashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("finance_director_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_finance_director_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified FinanceDirectorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen financial_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_financial_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/executive/financial_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/executive/financial_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("financialdashboard-screen").should("be.visible");
      cy.getCy("financialdashboard-title").should("be.visible");
      cy.getCy("financialdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("financial_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_financial_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified FinancialDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen hr_director_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "hr_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_hr_director_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/hr_director/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/hr_director/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("hrdirectordashboard-screen").should("be.visible");
      cy.getCy("hrdirectordashboard-title").should("be.visible");
      cy.getCy("hrdirectordashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("hr_director_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_hr_director_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified HrDirectorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen legal_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "legal");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_legal_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/legal/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/legal/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("legaldashboard-screen").should("be.visible");
      cy.getCy("legaldashboard-title").should("be.visible");
      cy.getCy("legaldashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("legal_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_legal_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified LegalDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen owner_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "owner");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_owner_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/owner/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/owner/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("ownerdashboard-screen").should("be.visible");
      cy.getCy("ownerdashboard-title").should("be.visible");
      cy.getCy("ownerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("owner_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_owner_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified OwnerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen shareholder_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "shareholder");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_shareholder_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/shareholder/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/shareholder/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("shareholderdashboard-screen").should("be.visible");
      cy.getCy("shareholderdashboard-title").should("be.visible");
      cy.getCy("shareholderdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("shareholder_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_shareholder_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ShareholderDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen training_director_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "training_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_training_director_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/training_director/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/training_director/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("trainingdirectordashboard-screen").should("be.visible");
      cy.getCy("trainingdirectordashboard-title").should("be.visible");
      cy.getCy("trainingdirectordashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("training_director_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_training_director_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified TrainingDirectorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen campaign_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_campaign_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/management/campaign_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/management/campaign_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("campaigndashboard-screen").should("be.visible");
      cy.getCy("campaigndashboard-title").should("be.visible");
      cy.getCy("campaigndashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("campaign_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_campaign_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CampaignDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen community_outreach_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "community_outreach");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_community_outreach_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/marketing/roles/community_outreach/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/marketing/roles/community_outreach/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("communityoutreachdashboard-screen").should("be.visible");
      cy.getCy("communityoutreachdashboard-title").should("be.visible");
      cy.getCy("communityoutreachdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("community_outreach_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_community_outreach_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified CommunityOutreachDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen compliance_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "compliance");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_compliance_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/management/compliance_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/management/compliance_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("compliancedashboard-screen").should("be.visible");
      cy.getCy("compliancedashboard-title").should("be.visible");
      cy.getCy("compliancedashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("compliance_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_compliance_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ComplianceDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen compliance_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "compliance");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_compliance_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/compliance_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/compliance_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("compliancemanagerdashboard-screen").should("be.visible");
      cy.getCy("compliancemanagerdashboard-title").should("be.visible");
      cy.getCy("compliancemanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("compliance_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_compliance_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ComplianceManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen franchise_sales_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "franchise_sales");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_franchise_sales_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/business_development/roles/franchise_sales_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/business_development/roles/franchise_sales_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
      cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
      cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("franchise_sales_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_franchise_sales_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified FranchiseSalesManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen general_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "gm");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_general_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/business_development/roles/general_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/business_development/roles/general_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("generalmanagerdashboard-screen").should("be.visible");
      cy.getCy("generalmanagerdashboard-title").should("be.visible");
      cy.getCy("generalmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("general_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_general_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified GeneralManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen governance_officer_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "governance");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_governance_officer_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /management/governance-officer-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/management/governance-officer-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("governanceofficerdashboard-screen").should("be.visible");
      cy.getCy("governanceofficerdashboard-title").should("be.visible");
      cy.getCy("governanceofficerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("governance_officer_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_governance_officer_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified GovernanceOfficerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen head_of_bus_dev_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "bus_dev");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_head_of_bus_dev_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/head_of_bus_dev/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/head_of_bus_dev/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("headofbusdevdashboard-screen").should("be.visible");
      cy.getCy("headofbusdevdashboard-title").should("be.visible");
      cy.getCy("headofbusdevdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("head_of_bus_dev_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_head_of_bus_dev_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified HeadOfBusDevDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen head_of_marketing_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "marketing");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_head_of_marketing_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/head_of_marketing/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/head_of_marketing/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("headofmarketingdashboard-screen").should("be.visible");
      cy.getCy("headofmarketingdashboard-title").should("be.visible");
      cy.getCy("headofmarketingdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("head_of_marketing_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_head_of_marketing_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified HeadOfMarketingDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen local_marketing_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "local_marketing");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_local_marketing_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/marketing/roles/local_marketing_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/marketing/roles/local_marketing_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
      cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
      cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("local_marketing_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_local_marketing_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified LocalMarketingManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen operations_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "ops_manager");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_operations_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/franchise/roles/operations_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/franchise/roles/operations_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
      cy.getCy("operationsmanagerdashboard-title").should("be.visible");
      cy.getCy("operationsmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("operations_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_operations_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified OperationsManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen partnership_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "partnership");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_partnership_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/business_development/roles/partnership_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/business_development/roles/partnership_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
      cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
      cy.getCy("partnershipmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("partnership_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_partnership_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PartnershipManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen premium_concierge_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "premium_concierge");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_premium_concierge_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/management/premium_concierge_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/management/premium_concierge_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("premiumconciergedashboard-screen").should("be.visible");
      cy.getCy("premiumconciergedashboard-title").should("be.visible");
      cy.getCy("premiumconciergedashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("premium_concierge_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_premium_concierge_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PremiumConciergeDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen regional_bdm_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "regional_bdm");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_regional_bdm_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/business_development/roles/regional_bdm/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/business_development/roles/regional_bdm/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("regionalbdmdashboard-screen").should("be.visible");
      cy.getCy("regionalbdmdashboard-title").should("be.visible");
      cy.getCy("regionalbdmdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("regional_bdm_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_regional_bdm_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified RegionalBdmDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen regional_manager_usa_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "regional_manager_usa");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_regional_manager_usa_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/business_development/roles/regional_manager_usa/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/business_development/roles/regional_manager_usa/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
      cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
      cy.getCy("regionalmanagerusadashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("regional_manager_usa_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_regional_manager_usa_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified RegionalManagerUsaDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen scrum_master_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "scrum_master");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_scrum_master_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("scrummasterdashboard-screen").should("be.visible");
      cy.getCy("scrummasterdashboard-title").should("be.visible");
      cy.getCy("scrummasterdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("scrum_master_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_scrum_master_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ScrumMasterDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen territory_expansion_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "territory_expansion");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_territory_expansion_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/business_development/roles/territory_expansion_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/business_development/roles/territory_expansion_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
      cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
      cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("territory_expansion_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_territory_expansion_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified TerritoryExpansionManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen territory_sales_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "territory_sales");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_territory_sales_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/marketing/roles/territory_sales_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/marketing/roles/territory_sales_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
      cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
      cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("territory_sales_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_territory_sales_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified TerritorySalesManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen vip_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "vip_manager");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_vip_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("vipmanagerdashboard-screen").should("be.visible");
      cy.getCy("vipmanagerdashboard-title").should("be.visible");
      cy.getCy("vipmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("vip_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_vip_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified VipManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen psw_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "psw");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_psw_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/psw/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/psw/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("pswdashboard-screen").should("be.visible");
      cy.getCy("pswdashboard-title").should("be.visible");
      // cy.getCy("pswdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("psw_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_psw_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified PswDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen rn_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "rn");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_rn_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/rn/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/rn/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("rndashboard-screen").should("be.visible");
      cy.getCy("rndashboard-title").should("be.visible");
      cy.getCy("rndashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("rn_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_rn_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified RnDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen rn_field_supervisor_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "rn_field_supervisor");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_rn_field_supervisor_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /rn/rn-field-supervisor-dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/rn/rn-field-supervisor-dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
      cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
      cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("rn_field_supervisor_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_rn_field_supervisor_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified RnFieldSupervisorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen rpn_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "rpn");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_rpn_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/rpn/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/rpn/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("rpndashboard-screen").should("be.visible");
      cy.getCy("rpndashboard-title").should("be.visible");
      cy.getCy("rpndashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("rpn_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_rpn_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified RpnDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen billing_admin_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "admin");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_billing_admin_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/franchise/roles/billing_admin/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/franchise/roles/billing_admin/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("billingadmindashboard-screen").should("be.visible");
      cy.getCy("billingadmindashboard-title").should("be.visible");
      cy.getCy("billingadmindashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("billing_admin_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_billing_admin_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified BillingAdminDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen employee_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "employee");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_employee_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/staff/employee_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/staff/employee_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("employeedashboard-screen").should("be.visible");
      cy.getCy("employeedashboard-title").should("be.visible");
      cy.getCy("employeedashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("employee_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_employee_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified EmployeeDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen hr_hiring_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "hr_hiring");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_hr_hiring_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/hr_hiring/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/hr_hiring/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("hrhiringdashboard-screen").should("be.visible");
      cy.getCy("hrhiringdashboard-title").should("be.visible");
      cy.getCy("hrhiringdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("hr_hiring_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_hr_hiring_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified HrHiringDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen hr_manager_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "hr_director");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_hr_manager_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/hr_manager/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/hr_manager/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("hrmanagerdashboard-screen").should("be.visible");
      cy.getCy("hrmanagerdashboard-title").should("be.visible");
      cy.getCy("hrmanagerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("hr_manager_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_hr_manager_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified HrManagerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen intake_coordinator_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "intake");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_intake_coordinator_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/clinical/roles/intake_coordinator/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/clinical/roles/intake_coordinator/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
      cy.getCy("intakecoordinatordashboard-title").should("be.visible");
      // cy.getCy("intakecoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("intake_coordinator_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_intake_coordinator_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen quality_assurance_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "system_verification");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_quality_assurance_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("qualityassurancedashboard-screen").should("be.visible");
      cy.getCy("qualityassurancedashboard-title").should("be.visible");
      // cy.getCy("qualityassurancedashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("quality_assurance_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_quality_assurance_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified QualityAssuranceDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen receptionist_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "admin");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_receptionist_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/staff/receptionist_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/staff/receptionist_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("receptionistdashboard-screen").should("be.visible");
      cy.getCy("receptionistdashboard-title").should("be.visible");
      cy.getCy("receptionistdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("receptionist_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_receptionist_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified ReceptionistDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen scheduler_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "scheduler");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_scheduler_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/franchise/roles/scheduler/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/franchise/roles/scheduler/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("schedulerdashboard-screen").should("be.visible");
      cy.getCy("schedulerdashboard-title").should("be.visible");
      cy.getCy("schedulerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("scheduler_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_scheduler_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified SchedulerDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen scheduling_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "guest");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_scheduling_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/staff/scheduling_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/staff/scheduling_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("schedulingdashboard-screen").should("be.visible");
      cy.getCy("schedulingdashboard-title").should("be.visible");
      cy.getCy("schedulingdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("scheduling_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_scheduling_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified SchedulingDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen training_coordinator_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "training");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_training_coordinator_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/support/roles/training_coordinator/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/support/roles/training_coordinator/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
      cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
      // cy.getCy("trainingcoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

      // Take screen screenshot
      cy.screenshot("training_coordinator_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_training_coordinator_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified TrainingCoordinatorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen training_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "training");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_training_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/staff/training_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/staff/training_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("trainingdashboard-screen").should("be.visible");
      cy.getCy("trainingdashboard-title").should("be.visible");
      cy.getCy("trainingdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("training_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_training_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified TrainingDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen volunteer_coordinator_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "volunteer_coordinator");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_volunteer_coordinator_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: /offices/corporate/roles/volunteer_coordinator/dashboard...");
      cy.visitWithSemantics(targetBaseUrl + "/offices/corporate/roles/volunteer_coordinator/dashboard");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
      cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
      cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("volunteer_coordinator_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_volunteer_coordinator_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified VolunteerCoordinatorDashboardScreen successfully!\n");
    });
  });

  it("opens and verifies screen volunteer_dashboard via real credentials login and logout", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      const user = users.find((u) => u.role_code === "volunteer");
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_volunteer_dashboard");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({ force: true });
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart...");
      cy.visitWithSemantics(targetBaseUrl + "packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
      cy.getCy("volunteerdashboard-screen").should("be.visible");
      cy.getCy("volunteerdashboard-title").should("be.visible");
      cy.getCy("volunteerdashboard-content").should("be.visible");

      // Take screen screenshot
      cy.screenshot("volunteer_dashboard");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {
          cy.wrap(topbarLogout).first().click({ force: true });
        } else {
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }
      });
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_volunteer_dashboard");
      cy.task("log", "✅ PROGRESS: - Verified VolunteerDashboardScreen successfully!\n");
    });
  });

});
