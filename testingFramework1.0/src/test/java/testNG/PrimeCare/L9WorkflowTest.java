package testNG.PrimeCare;

import primecare.testing.framework.*;
import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import primecare.testing.base.BaseWorkflowTest;
import primecare.testing.framework.Models.WorkflowDefinition;
import primecare.testing.framework.Models.WorkflowStepDefinition;
import primecare.testing.pages.DynamicScreen;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.Repositories.WorkflowRepository;
import primecare.testing.validation.TestLayer;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.List;

@TestLayer(TestingLayerCode.L9)
public class L9WorkflowTest extends BaseWorkflowTest {

    DynamicScreen page;

    @Test(groups = {"l9", "workflow"})
    public void verifyWorkflowSteps() {
        System.out.println("[L9] Running workflow steps verification...");
        
        WorkflowDefinition workflow = WorkflowRepository.getWorkflowByKey("login_verification_flow");
        Assert.assertNotNull(workflow, "Workflow 'login_verification_flow' not found in database.");

        List<WorkflowStepDefinition> steps = WorkflowRepository.getWorkflowSteps(workflow.workflowId);
        Assert.assertFalse(steps.isEmpty(), "Workflow steps must be registered in SQLite.");

        for (WorkflowStepDefinition step : steps) {
            System.out.println("  * Executing step " + step.stepOrder + ": " + step.stepKey);

            if ("NAVIGATE".equalsIgnoreCase(step.actionType)) {
                String targetUrl = appProps.getProperty("APP_BASE_URL", "http://localhost:8080") + "/" + step.screenKey;
                String email = appProps.getProperty("username.admin", "clinic@primecare.com");
                String password = appProps.getProperty("password.admin", "Password123");
                org.openqa.selenium.By marker = org.openqa.selenium.By.xpath("//*[@data-cy='" + step.screenKey + "' or @aria-label='" + step.screenKey + "']");
                utilities.PageRecoveryUtility recovery = new utilities.PageRecoveryUtility(driver, appProps.getProperty("login.url"));
                recovery.openRequestedPage(targetUrl, marker, step.screenKey, email, password);
            
            } else if ("EXECUTE_FUNCTION".equalsIgnoreCase(step.actionType)) {
                page = new DynamicScreen(driver, "login");
                String email = appProps.getProperty("username.admin", "clinic@primecare.com");
                String password = appProps.getProperty("password.admin", "Password123");

                page.type("email_field", email);
                page.type("password_field", password);
                page.click("submit_button");

                boolean redirected = false;
                try {
                    org.openqa.selenium.support.ui.WebDriverWait shortWait = new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(10));
                    shortWait.until(webDriver -> webDriver.getCurrentUrl().contains("/success") 
                            || webDriver.getCurrentUrl().contains("/settings") 
                            || webDriver.getCurrentUrl().contains("/common")
                            || page.isVisible("logout_button"));
                    redirected = true;
                } catch (Exception e) {
                    // Ignore
                }
                Assert.assertTrue(redirected, "Workflow function submit_login failed to redirect user. Current URL: " + driver.getCurrentUrl());
            }
        }
        System.out.println("[L9] Workflow execution complete and successful.");
    }
}

