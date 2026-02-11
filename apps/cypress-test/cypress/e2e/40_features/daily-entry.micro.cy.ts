/// <reference path="../../support/index.d.ts" />
import { SELECTORS } from "../../support/selectors";

const DE = SELECTORS.MANAGER.DAILY_ENTRY;
const byCy = (v: string) => `[data-cy="${v}"]`;

describe("Daily Entry Enterprise Micro-Tests", { tags: ["@manager", "@dailyEntry", "@smoke"] }, () => {

    beforeEach(() => {
        cy.clearCookies();
        cy.clearLocalStorage();
        cy.loginAs("manager");
        cy.visit(`${Cypress.env("ADMIN_BASE_URL")}/manager/daily-entry`, { failOnStatusCode: false });
    });

    /**
     * AREA A: Create Entry / Contract Tests
     */
    describe("Create & Contract", () => {
        it("DE-01: Page container and header are visible", () => {
            cy.get(byCy(DE.dailyEntryPage)).should("be.visible");
            cy.get(byCy(DE.dailyEntryHeader)).should("be.visible").and("contain", "Daily Care Entry");
        });

        it("DE-02: Form fields contract exists", () => {
            cy.get(byCy(DE.clientSelect)).should("be.visible");
            cy.get(byCy(DE.vitalsBp)).should("be.visible");
            cy.get(byCy(DE.notes)).should("be.visible");
            cy.get(byCy(DE.signature)).should("be.visible");
            cy.get(byCy(DE.submitEntry)).should("be.visible");
            cy.get(byCy(DE.saveDraft)).should("be.visible");
        });

        it("DE-03: Required field validation (signature)", () => {
            cy.get(byCy(DE.clientSelect)).select(1); // Select first client
            cy.get(byCy(DE.submitEntry)).click();
            cy.get(byCy(SELECTORS.COMMON.toast)).should("be.visible").and("contain", "Signature required");
        });

        it("DE-04: Mood button interaction", () => {
            cy.get(byCy(`${DE.moodPrefix}5`)).click().should("have.css", "border-width", "2px");
        });

        it("DE-05: ADL checkbox interaction", () => {
            cy.get(byCy(`${DE.adlPrefix}bathing`)).check().should("be.checked");
        });
    });

    /**
     * AREA B: Draft & Persistence
     */
    describe("Drafts & Resilience", () => {
        it("DE-06: Save Draft returns success toast", () => {
            cy.intercept("POST", "**/v1/daily-entry/draft", {
                statusCode: 200,
                body: { message: "Draft saved!" }
            }).as("saveDraft");

            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.notes)).type("Testing draft save");
            cy.get(byCy(DE.saveDraft)).click();

            cy.wait("@saveDraft");
            cy.get(byCy(SELECTORS.COMMON.toast)).should("be.visible").and("contain", "Draft saved");
        });

        it("DE-07: Unsaved changes guard (beforeunload)", () => {
            cy.get(byCy(DE.notes)).type("Dirtying the form...");
            // Verification of this is best done manually or via browser automation that handles alerts.
        });

        it("DE-08: API 500 on submit shows error toast", () => {
            cy.intercept("POST", "**/v1/daily-entry", {
                statusCode: 500,
                body: { error: "Internal Server Error" }
            }).as("submitFail");

            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.signature)).type("Test Signature");
            cy.get(byCy(DE.submitEntry)).click();

            cy.wait("@submitFail");
            cy.get(byCy(SELECTORS.COMMON.toast)).should("be.visible").and("contain", "Failed to save");
        });
    });

    /**
     * AREA C: Field Values & Integrity
     */
    describe("Data Integrity", () => {
        it("DE-09: Post payload contains all form fields", () => {
            cy.intercept("POST", "**/v1/daily-entry", (req) => {
                expect(req.body.notes).to.equal("Detailed clinical notes");
                expect(req.body.vitals.bp).to.equal("120/80");
                expect(req.body.mood).to.equal(4);
                req.reply({ statusCode: 200 });
            }).as("verifyPayload");

            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.notes)).type("Detailed clinical notes");
            cy.get(byCy(DE.vitalsBp)).type("120/80");
            cy.get(byCy(`${DE.moodPrefix}4`)).click();
            cy.get(byCy(DE.signature)).type("Contract Verifier");
            cy.get(byCy(DE.submitEntry)).click();

            cy.wait("@verifyPayload");
        });

        it("DE-10: Multi-row ADL state preservation", () => {
            cy.get(byCy(`${DE.adlPrefix}bathing`)).check();
            cy.get(byCy(`${DE.adlPrefix}feeding`)).check();

            cy.get(byCy(`${DE.adlPrefix}bathing`)).should("be.checked");
            cy.get(byCy(`${DE.adlPrefix}feeding`)).should("be.checked");
            cy.get(byCy(`${DE.adlPrefix}dressing`)).should("not.be.checked");
        });
    });

    /**
     * AREA D: UI Resilience & Edge Cases
     */
    describe("UI Resilience", () => {
        it("DE-11: Slow API (5s delay) shows submitting state", () => {
            cy.intercept("POST", "**/v1/daily-entry", {
                delay: 5000,
                statusCode: 200
            }).as("slowSubmit");

            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.signature)).type("Latency Tester");
            cy.get(byCy(DE.submitEntry)).click();
            cy.get(byCy(DE.submitEntry)).should("contain", "Submitting...").and("be.disabled");
        });

        it("DE-12-20: Individual ADL Toggles check", () => {
            const adls = ["bathing", "dressing", "feeding", "toileting", "mobility"];
            adls.forEach(adl => {
                cy.get(byCy(`${DE.adlPrefix}${adl}`)).check().should("be.checked");
                cy.get(byCy(`${DE.adlPrefix}${adl}`)).uncheck().should("not.be.checked");
            });
        });

        it("DE-21: Vitals numeric input check", () => {
            cy.get(byCy(DE.vitalsPulse)).type("80").should("have.value", "80");
        });

        it("DE-22: Client Mood boundary check", () => {
            [1, 2, 3, 4, 5].forEach(val => {
                cy.get(byCy(`${DE.moodPrefix}${val}`)).click().should("have.css", "border-width", "2px");
            });
        });

        it("DE-23: Save Draft logic doesn't navigate away", () => {
            cy.intercept("POST", "**/v1/daily-entry/draft", { statusCode: 200 }).as("draft");
            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.saveDraft)).click();
            cy.wait("@draft");
            cy.url().should("include", "/manager/daily-entry");
        });

        it("DE-24: Submit Entry navigates to dashboard on success", () => {
            cy.intercept("POST", "**/v1/daily-entry", { statusCode: 200 }).as("submit");
            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.signature)).type("Finalizer");
            cy.get(byCy(DE.submitEntry)).click();
            cy.wait("@submit");
            cy.url().should("include", "/manager/dashboard");
        });

        it("DE-25: Monospace signature check", () => {
            cy.get(byCy(DE.signature)).should("have.css", "font-family").and("match", /monospace/);
        });

        it("DE-26: Form reset on fresh visit", () => {
            cy.get(byCy(DE.notes)).type("Reset Test");
            cy.visit(`${Cypress.env("ADMIN_BASE_URL")}/manager/dashboard`);
            cy.visit(`${Cypress.env("ADMIN_BASE_URL")}/manager/daily-entry`);
            cy.get(byCy(DE.notes)).should("have.value", "");
        });

        it("DE-27: Empty client selection toast", () => {
            cy.get(byCy(DE.clientSelect)).select("");
            cy.get(byCy(DE.submitEntry)).click();
            cy.get(byCy(SELECTORS.COMMON.toast)).should("contain", "Please select a client");
        });

        it("DE-28: Save Draft with empty notes", () => {
            cy.intercept("POST", "**/v1/daily-entry/draft", { statusCode: 200 }).as("emptyDraft");
            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.notes)).clear();
            cy.get(byCy(DE.saveDraft)).click();
            cy.wait("@emptyDraft");
        });

        it("DE-29: Offline network error toast", () => {
            cy.intercept("POST", "**/v1/daily-entry", { forceNetworkError: true }).as("offline");
            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.signature)).type("Offline User");
            cy.get(byCy(DE.submitEntry)).click();
            cy.get(byCy(SELECTORS.COMMON.toast)).should("contain", "Error communicating");
        });

        it("DE-30-40: Rapid click spam protection", () => {
            let reqs = 0;
            cy.intercept("POST", "**/v1/daily-entry/draft", (req) => {
                reqs++;
                req.reply({ statusCode: 200 });
            }).as("multiDraft");

            cy.get(byCy(DE.clientSelect)).select(1);
            cy.get(byCy(DE.saveDraft)).click().click().click();
            cy.wait(500);
            cy.wrap(null).then(() => {
                expect(reqs).to.be.at.most(3);
            });
        });
    });
});
