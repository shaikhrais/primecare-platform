package base;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

public abstract class BasePageComponentTest
        extends BasePageRedirectTest {

    protected final List<ComponentVerificationResult>
            componentResults =
                    new ArrayList<>();

    protected void executeLevel2ComponentVerification() {

        /*
         * Level 2 always begins by ensuring Level 1 is valid.
         */
        executeLevel1PageVerification();

        PageTestDefinition page =
                getPageDefinition();

        Assert.assertFalse(
                page.getComponents().isEmpty(),
                "No component definitions were supplied for page: "
                        + page.getPageName()
        );

        enableSemantics();

        boolean allPassed = true;

        System.out.println(
                "\n========== LEVEL 2 COMPONENT TEST =========="
        );

        for (
                ComponentDefinition component :
                page.getComponents()
        ) {

            ComponentVerificationResult result =
                    verifyComponent(
                            page,
                            component
                    );

            componentResults.add(
                    result
            );

            TestNGExcelReportWriter
                    .addComponentResult(
                            result
                    );

            saveComponentResultToSQLite(
                    result
            );

            if (!result.isPassed()) {
                allPassed = false;
            }

            printComponentResult(
                    result
            );
        }

        Assert.assertTrue(
                allPassed,
                buildComponentFailureMessage(
                        page
                )
        );

        if (this.currentResult != null) {
            this.currentResult.setComponentVerified(allPassed);
        }

        System.out.println(
                "[LEVEL 2 PASSED] All required components "
                        + "were verified for "
                        + page.getPageName()
        );
    }

    private ComponentVerificationResult verifyComponent(
            PageTestDefinition page,
            ComponentDefinition component
    ) {

        ComponentVerificationResult result =
                new ComponentVerificationResult();

        result.setScreenId(
                page.getScreenId()
        );

        result.setPageName(
                page.getPageName()
        );

        result.setComponentName(
                component.getComponentName()
        );

        result.setComponentType(
                component.getComponentType()
        );

        result.setLocator(
                component.getLocator().toString()
        );

        boolean found =
                !driver.findElements(
                        component.getLocator()
                ).isEmpty();

        boolean visible = false;
        boolean enabled = false;
        boolean clickable = false;

        if (found) {

            try {

                WebElement element =
                        driver.findElement(
                                component.getLocator()
                        );

                visible =
                        element.isDisplayed();

                enabled =
                        element.isEnabled();

                if (component.isMustBeClickable()) {

                    clickable =
                            waitForClickable(
                                    component
                                            .getLocator()
                            );

                } else {

                    clickable = true;
                }

            } catch (Exception ignored) {
            }
        }

        boolean passed = true;

        StringBuilder failure =
                new StringBuilder();

        if (component.isRequired()
                && !found) {

            passed = false;

            failure.append(
                    "Required component not found. "
            );
        }

        if (component.isMustBeVisible()
                && !visible) {

            passed = false;

            failure.append(
                    "Component is not visible. "
            );
        }

        if (component.isMustBeEnabled()
                && !enabled) {

            passed = false;

            failure.append(
                    "Component is not enabled. "
            );
        }

        if (component.isMustBeClickable()
                && !clickable) {

            passed = false;

            failure.append(
                    "Component is not clickable. "
            );
        }

        result.setFound(found);
        result.setVisible(visible);
        result.setEnabled(enabled);
        result.setClickable(clickable);
        result.setPassed(passed);

        result.setStatus(
                passed
                        ? "PASSED"
                        : "FAILED"
        );

        result.setFailureMessage(
                failure.toString().trim()
        );

        return result;
    }

    private boolean waitForClickable(
            org.openqa.selenium.By locator
    ) {

        try {

            new WebDriverWait(
                    driver,
                    Duration.ofSeconds(5)
            ).until(
                    ExpectedConditions
                            .elementToBeClickable(
                                    locator
                            )
            );

            return true;

        } catch (TimeoutException exception) {

            return false;
        }
    }

    private void printComponentResult(
            ComponentVerificationResult result
    ) {

        System.out.println(
                "\nComponent: "
                        + result.getComponentName()
        );

        System.out.println(
                "Type: "
                        + result.getComponentType()
        );

        System.out.println(
                "Locator: "
                        + result.getLocator()
        );

        System.out.println(
                "Found: "
                        + result.isFound()
        );

        System.out.println(
                "Visible: "
                        + result.isVisible()
        );

        System.out.println(
                "Enabled: "
                        + result.isEnabled()
        );

        System.out.println(
                "Clickable: "
                        + result.isClickable()
        );

        System.out.println(
                "Status: "
                        + result.getStatus()
        );
    }

    private String buildComponentFailureMessage(
            PageTestDefinition page
    ) {

        StringBuilder message =
                new StringBuilder();

        message.append(
                "\nLEVEL 2 COMPONENT VERIFICATION FAILED"
        );

        message.append(
                "\nPage: "
        ).append(
                page.getPageName()
        );

        message.append(
                "\nURL: "
        ).append(
                driver.getCurrentUrl()
        );

        for (
                ComponentVerificationResult result :
                componentResults
        ) {

            if (!result.isPassed()) {

                message.append(
                        "\n- "
                ).append(
                        result.getComponentName()
                ).append(
                        ": "
                ).append(
                        result.getFailureMessage()
                );
            }
        }

        return message.toString();
    }

    protected void saveComponentResultToSQLite(
            ComponentVerificationResult result
    ) {

        SQLiteComponentResultRepository
                .save(result);
    }
}
