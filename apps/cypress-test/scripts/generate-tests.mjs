import fs from "fs";
import path from "path";

// Simple path resolution based on process execution root (project root)
const root = process.cwd();
const registryDir = path.join(root, "cypress", "fixtures", "registry");
const outDir = path.join(root, "cypress", "e2e", "generated");

if (!fs.existsSync(outDir)) {
  fs.mkdirSync(outDir, { recursive: true });
}

function readJson(file) {
  const fullPath = path.join(registryDir, file);
  if (!fs.existsSync(fullPath)) {
    throw new Error(`Registry file missing: ${fullPath}`);
  }
  return JSON.parse(fs.readFileSync(fullPath, "utf8"));
}

console.log("Reading registries from:", registryDir);

const marketing = readJson("routes.marketing.json");
const admin = readJson("routes.admin.json");
const matrix = readJson("access.matrix.json");
const contracts = readJson("contracts.json");

function write(fileName, content) {
  const fullPath = path.join(outDir, fileName);
  fs.writeFileSync(fullPath, content, "utf8");
  console.log("Generated:", fileName);
}

const commonHeader = `
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});
`;

// 1) Marketing smoke
write(
  "00_marketing.smoke.cy.ts",
  commonHeader + `
describe("Generated: Marketing Smoke", { tags: ["@smoke","@marketing"] }, () => {
  it("loads all marketing routes", () => {
    cy.fixture("registry/routes.marketing.json").then((cfg) => {
      const baseUrl = Cypress.env(cfg.baseUrlEnv);
      expect(baseUrl).to.exist;

      cfg.routes.forEach((r: any) => {
        cy.log(\`\${r.key} -> \${r.path}\`);
        cy.visit(new URL(r.path, baseUrl).toString(), { failOnStatusCode: false });
        cy.assertNoAppCrash();
      });
    });
  });
});
`
);

// 2) Admin smoke (guest + protected check)
write(
  "01_admin.smoke.cy.ts",
  commonHeader + `
describe("Generated: Admin Smoke", { tags: ["@smoke","@admin"] }, () => {
  it("guest routes load and protected routes redirect", { tags: ["@security"] }, () => {
    cy.fixture("registry/routes.admin.json").then((cfg) => {
      const baseUrl = Cypress.env(cfg.baseUrlEnv);
      expect(baseUrl).to.exist;

      cfg.routes.forEach((r: any) => {
        cy.log(\`Checking route as guest: \${r.key}\`);
        
        // Ensure clean state for guest check
        cy.clearLocalStorage();
        cy.clearCookies();
        
        cy.visitRoute(cfg.baseUrlEnv, r.path);

        if (r.auth && r.auth !== "guest" && r.auth !== "any") {
          cy.assertRedirectToLogin();
        } else {
            cy.assertNoAppCrash();
        }
      });
    });
  });
});
`
);

// 3) Access matrix
write(
  "10_access.matrix.cy.ts",
  commonHeader + `
type Role = "guest"|"client"|"psw"|"manager"|"staff";

describe("Generated: Access Matrix", { tags: ["@security","@rbac"] }, () => {
  it("enforces route permissions", () => {
    cy.fixture("registry/routes.admin.json").then((routesCfg) => {
      cy.fixture("registry/access.matrix.json").then((m) => {
        const baseUrl = Cypress.env(routesCfg.baseUrlEnv);
        const redirect = m.redirectWhenDenied || "/login";

        const routeByKey = new Map<string, any>();
        routesCfg.routes.forEach((r:any) => routeByKey.set(r.key, r));

        (m.roles as Role[]).forEach((role) => {
          cy.log(\`Testing as role: \${role}\`);
          
          m.rules.forEach((rule:any) => {
            const route = routeByKey.get(rule.routeKey);
            if (!route) return;

            const allowed = rule.allowed.includes(role);
            
            cy.log(\`Testing access to \${route.key} (\${route.path}) - Expected Allowed: \${allowed}\`);
            
            // Clean state before each check
            cy.logout();
            if (role !== "guest") cy.loginAs(role);

            cy.visitRoute(routesCfg.baseUrlEnv, route.path);

            if (!allowed) {
                cy.url().should("include", redirect);
            } else {
                cy.url().should("not.include", redirect);
                cy.assertNoAppCrash();
            }
          });
        });
      });
    });
  });
});
`
);

// 4) Contract tests (staff/admin role)
write(
  "20_contracts.cy.ts",
  commonHeader + `
describe("Generated: Contracts", { tags: ["@contract"] }, () => {
  it("staff pages contain required data-cy elements", () => {
    cy.loginAs("staff");
    cy.fixture("registry/routes.admin.json").then((routesCfg) => {
      cy.fixture("registry/contracts.json").then((c) => {
        const baseUrl = Cypress.env(routesCfg.baseUrlEnv);

        Object.entries(c).forEach(([routeKey, selectors]) => {
          const route = routesCfg.routes.find((r:any) => r.key === routeKey);
          if (!route) return;

          cy.log(\`Verifying contract for page: \${routeKey}\`);
          cy.visitRoute(routesCfg.baseUrlEnv, route.path);
          cy.assertContract(selectors as string[]);
        });
      });
    });
  });
});
`
);
// 5) Integrity Suite
const integrity = readJson("primecare.integrity.json");

write(
  "30_integrity.contracts.cy.ts",
  commonHeader + `
describe("Generated: Structural Integrity", { tags: ["@integrity", "@contracts"] }, () => {
    const cfg = ${JSON.stringify(integrity)};
    
    cfg.pages.forEach((page: any) => {
        it(\`[\${page.key}] contains all required structural components\`, () => {
            const baseUrlEnv = page.baseUrlEnv || "ADMIN_BASE_URL";
            cy.loginAs(page.allowedRoles.includes("guest") ? "guest" : page.allowedRoles[0]);
            cy.visitRoute(baseUrlEnv, page.path);
            
            // Check mandatory global components
            cfg.global.mandatory.forEach((comp: string) => {
                cy.log(\`Checking mandatory component: \${comp}\`);
                cy.getByCy(comp).should("exist");
            });

            // Check page-specific components
            page.components.forEach((selector: string) => {
                cy.log(\`Checking page component: \${selector}\`);
                cy.getByCy(selector).should("exist");
            });
        });
    });
});
`
);

write(
  "31_integrity.rbac.cy.ts",
  commonHeader + `
describe("Generated: RBAC Action Visibility", { tags: ["@integrity", "@security"] }, () => {
    const cfg = ${JSON.stringify(integrity)};
    const roles = cfg.roles;

    cfg.pages.forEach((page: any) => {
        roles.forEach((role: string) => {
            it(\`[\${page.key}] verifies visibility for role: \${role}\`, () => {
                const allowed = page.allowedRoles.includes(role) || page.allowedRoles.includes("any");
                
                cy.logout();
                if (role !== "guest") cy.loginAs(role as any);
                
                const baseUrlEnv = page.baseUrlEnv || "ADMIN_BASE_URL";
                cy.visitRoute(baseUrlEnv, page.path, { failOnStatusCode: false });

                if (!allowed) {
                    if (role === "guest") {
                        cy.assertRedirectToLogin();
                    } else {
                        // Authenticated user but not allowed on this specific page
                        // They should be redirected away from the page.path
                        cy.url().should("not.include", page.path);
                    }
                } else {
                    page.actions.forEach((action: any) => {
                        cy.log(\`Verifying action visibility: \${action.key}\`);
                        cy.getByCy(action.selector).should("be.visible");
                    });
                }
            });
        });
    });
});
`
);

write(
  "32_integrity.actions.cy.ts",
  commonHeader + `
describe("Generated: Action Integrity", { tags: ["@integrity", "@functional"] }, () => {
    const cfg = ${JSON.stringify(integrity)};

    cfg.pages.filter(p => p.actions.length > 0).forEach((page: any) => {
        describe(\`Page Actions: \${page.key}\`, () => {
            beforeEach(() => {
                cy.loginAs(page.allowedRoles[0]);
                const baseUrlEnv = page.baseUrlEnv || "ADMIN_BASE_URL";
                cy.visitRoute(baseUrlEnv, page.path);
            });

            page.actions.forEach((action: any) => {
                it(\`Action: \${action.key} triggers correct functional lifecycle\`, () => {
                    if (action.type === "api") {
                        cy.intercept(action.method, "**" + action.endpoint + "**").as("apiCall");
                        
                        cy.log(\`Triggering action: \${action.key}\`);
                        cy.getByCy(action.selector).click();
                        
                        // Lifecycle checks
                        cy.getByCy("state.loading").should("exist").then(() => {
                            cy.wait("@apiCall");
                            if (action.expectedToasts) {
                                action.expectedToasts.forEach((t: string) => cy.getByCy(t).should("be.visible"));
                            } else {
                                cy.getByCy("toast.success").should("be.visible");
                            }
                        });
                    } else if (action.type === "route") {
                        cy.log(\`Triggering navigation: \${action.key}\`);
                        cy.getByCy(action.selector).click();
                        cy.url().should("include", action.target);
                    }
                });

                if (page.integrity === "guard.unsaved" && action.type === "api") {
                    it(\`Action: \${action.key} enforces unsaved changes guard\`, () => {
                        cy.log("Modifying form to trigger dirty state");
                        // Generic input for guard test (simplified)
                        cy.get("input").first().type("Guard Test");
                        
                        cy.log("Attempting to leave page");
                        cy.getByCy("sidebar").find("a").last().click();
                        
                        cy.log("Verifying guard dialog");
                        cy.getByCy("guard.unsaved.dialog").should("be.visible");
                        cy.getByCy("guard.unsaved.stay").click();
                        cy.getByCy("guard.unsaved.dialog").should("not.exist");
                    });
                }
            });
        });
    });
});
`
);
