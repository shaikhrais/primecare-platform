package base;

import java.net.URI;
import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

public abstract class BasePageRedirectTest extends baseRedirect {
    protected VerificationResult currentResult;

    protected abstract PageTestDefinition getPageDefinition();

    protected String getUserEmail() {
        return null;
    }

    protected String getUserPassword() {
        return null;
    }

    protected LoginHandler getLoginHandler() {
        return null;
    }

    protected String buildRequestedUrl() {
        try {
            String configuredUrl =
                    baseDataProviders.ProjectExcelFileData.url();

            URI uri =
                    URI.create(configuredUrl);

            String origin =
                    uri.getScheme()
                            + "://"
                            + uri.getAuthority();

            return origin
                    + normalizeRoute(
                            getPageDefinition().getRoute()
                    );
        } catch (Exception e) {
            throw new RuntimeException("Failed to read URL from Excel", e);
        }
    }

    protected void executeLevel1PageVerification() {

        PageTestDefinition page =
                getPageDefinition();

        String requestedUrl =
                buildRequestedUrl();

        long startTime =
                System.currentTimeMillis();

        VerificationResult result =
                new VerificationResult();
        this.currentResult = result;

        result.setScreenId(
                page.getScreenId()
        );

        result.setTestClass(
                getClass().getName()
        );

        result.setExpectedPage(
                page.getPageName()
        );

        result.setExpectedRoute(
                page.getRoute()
        );

        try {

            /*
             * Self-healing navigation:
             * requested page -> language -> login -> requested page.
             */
            redirectToRequestedPage(
                    requestedUrl,
                    page.getExpectedTitle(),
                    getUserEmail(),
                    getUserPassword(),
                    getLoginHandler()
            );

            waitForPageMarker(
                    page.getPageMarker(),
                    page.getPageName()
            );

            boolean routeMatches =
                    strictRouteMatches(
                            driver.getCurrentUrl(),
                            page.getRoute()
                    );

            boolean pageMarkerVisible =
                    isElementVisible(
                            page.getPageMarker()
                    );

            boolean mainContentVisible =
                    page.getMainContentMarker() == null
                            || isElementVisible(
                                    page.getMainContentMarker()
                            );

            boolean titleMatches =
                    verifyTitle(
                            page.getExpectedTitle()
                    );

            boolean errorPage =
                    detectCurrentPage()
                            .equalsIgnoreCase(
                                    "Error / Placeholder Page"
                            );

            result.setActualPage(
                    detectCurrentPage()
            );

            result.setActualUrl(
                    driver.getCurrentUrl()
            );

            result.setRouteVerified(
                    routeMatches
            );

            result.setPageVerified(
                    pageMarkerVisible
                            && titleMatches
                            && mainContentVisible
            );

            result.setErrorPageFound(
                    errorPage
            );

            boolean passed =
                    routeMatches
                            && pageMarkerVisible
                            && titleMatches
                            && mainContentVisible
                            && !errorPage;

            result.setTestStatus(
                    passed
                            ? "PASSED"
                            : "FAILED"
            );

            System.out.println(
                    "\n========== LEVEL 1 PAGE TEST =========="
            );

            System.out.println(
                    "Screen ID: "
                            + page.getScreenId()
            );

            System.out.println(
                    "Expected page: "
                            + page.getPageName()
            );

            System.out.println(
                    "Expected route: "
                            + page.getRoute()
            );

            System.out.println(
                    "Actual URL: "
                            + driver.getCurrentUrl()
            );

            System.out.println(
                    "Route verified: "
                            + routeMatches
            );

            System.out.println(
                    "Title verified: "
                            + titleMatches
            );

            System.out.println(
                    "Page marker visible: "
                            + pageMarkerVisible
            );

            System.out.println(
                    "Main content visible: "
                            + mainContentVisible
            );

            System.out.println(
                    "Error page detected: "
                            + errorPage
            );

            System.out.println(
                    "Level 1 status: "
                            + result.getTestStatus()
            );

            Assert.assertTrue(
                    passed,
                    "\nLEVEL 1 PAGE VERIFICATION FAILED"
                            + "\nScreen ID: "
                            + page.getScreenId()
                            + "\nExpected page: "
                            + page.getPageName()
                            + "\nExpected route: "
                            + page.getRoute()
                            + "\nActual URL: "
                            + driver.getCurrentUrl()
                            + "\nActual page: "
                            + detectCurrentPage()
                            + "\nRoute verified: "
                            + routeMatches
                            + "\nTitle verified: "
                            + titleMatches
                            + "\nPage marker visible: "
                            + pageMarkerVisible
                            + "\nMain content visible: "
                            + mainContentVisible
                            + "\nError page detected: "
                            + errorPage
            );

            verifyNavigationProtocol(
                    page.getScreenId(),
                    page.getExpectedTitle(),
                    page.getRoute()
            );

        } catch (Throwable throwable) {

            result.setActualPage(
                    detectCurrentPage()
            );

            result.setActualUrl(
                    driver == null
                            ? ""
                            : driver.getCurrentUrl()
            );

            result.setTestStatus(
                    "FAILED"
            );

            result.setFailureMessage(
                    throwable.getMessage()
            );

            throw throwable;

        } finally {

            result.setExecutionTimeMs(
                    System.currentTimeMillis()
                            - startTime
            );

            TestNGExcelReportWriter.addResult(
                    result
            );
        }
    }

    protected void waitForPageMarker(
            By locator,
            String pageName
    ) {

        try {

            new WebDriverWait(
                    driver,
                    Duration.ofSeconds(20)
            ).until(
                    ExpectedConditions
                            .visibilityOfElementLocated(
                                    locator
                            )
            );

        } catch (TimeoutException exception) {

            Assert.fail(
                    "Expected page marker was not visible."
                            + "\nPage: "
                            + pageName
                            + "\nLocator: "
                            + locator
                            + "\nURL: "
                            + driver.getCurrentUrl(),
                    exception
            );
        }
    }

    protected boolean isElementVisible(
            By locator
    ) {

        try {

            return driver
                    .findElements(locator)
                    .stream()
                    .anyMatch(element -> {

                        try {
                            return element.isDisplayed();
                        } catch (Exception ignored) {
                            return false;
                        }
                    });

        } catch (Exception exception) {

            return false;
        }
    }

    protected boolean strictRouteMatches(
            String currentUrl,
            String expectedRoute
    ) {

        try {

            String actualPath =
                    URI.create(
                            currentUrl
                    ).getPath();

            return normalizeRoute(actualPath)
                    .equals(
                            normalizeRoute(
                                    expectedRoute
                            )
                    );

        } catch (Exception exception) {

            return false;
        }
    }

    protected String normalizeRoute(
            String route
    ) {

        if (route == null
                || route.isBlank()) {

            return "/";
        }

        String normalized =
                route.trim()
                        .toLowerCase()
                        .replaceAll("/+$", "");

        return normalized.isEmpty()
                ? "/"
                : normalized;
    }
}
