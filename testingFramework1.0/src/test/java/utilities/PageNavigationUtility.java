package utilities;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

public class PageNavigationUtility {

    private final WebDriver driver;
    private final WebDriverWait wait;

    private final By languagePage =
        By.xpath("//*[contains(@aria-label, 'language-page')]");

    private final By englishButton =
        By.xpath("//*[contains(@aria-label, 'language-english')]");

    private final By loginPage =
        By.xpath("//*[contains(@aria-label, 'login-page')]");

    private final By dashboardPage =
        By.xpath("//*[contains(@aria-label, 'dashboard-page')]");

    public PageNavigationUtility(WebDriver driver) {
        this.driver = driver;
        this.wait = new WebDriverWait(
            driver,
            Duration.ofSeconds(15)
        );
    }

    /**
     * Handles the Language page when it unexpectedly appears.
     */
    public void handleLanguagePageIfPresent() {
        if (!isVisible(languagePage)) {
            return;
        }

        System.out.println(
            "[PAGE UTILITY] Language page detected. Selecting English."
        );

        WebElement english = wait.until(
            ExpectedConditions.elementToBeClickable(
                englishButton
            )
        );

        try {
            ((org.openqa.selenium.JavascriptExecutor) driver).executeScript("arguments[0].click();", english);
            System.out.println("[PAGE UTILITY] Selected English via JS click.");
        } catch (Exception e) {
            english.click();
            System.out.println("[PAGE UTILITY] Selected English via standard click.");
        }

        try {
            wait.until(
                ExpectedConditions.invisibilityOfElementLocated(
                    languagePage
                )
            );

            wait.until(
                ExpectedConditions.visibilityOfElementLocated(
                    loginPage
                )
            );

            System.out.println(
                "[PAGE UTILITY] English selected. Login page opened."
            );

        } catch (TimeoutException exception) {
            Assert.fail(
                "Language selection failed."
                    + "\nExpected page: Login"
                    + "\nActual page: " + detectCurrentPage()
                    + "\nCurrent URL: " + driver.getCurrentUrl()
            );
        }
    }

    /**
     * Verifies that the Login page is currently displayed.
     */
    public void requireLoginPage(String stage) {
        requirePage(
            loginPage,
            "Login",
            stage
        );
    }

    /**
     * Verifies that the Dashboard page is currently displayed.
     */
    public void requireDashboardPage(String stage) {
        requirePage(
            dashboardPage,
            "Dashboard",
            stage
        );
    }

    /**
     * Generic expected-page verification.
     */
    public void requirePage(
        By expectedPageLocator,
        String expectedPageName,
        String stage
    ) {
        try {
            wait.until(
                ExpectedConditions.visibilityOfElementLocated(
                    expectedPageLocator
                )
            );

        } catch (TimeoutException exception) {
            Assert.fail(
                "\nPAGE CHECK FAILED"
                    + "\nStage: " + stage
                    + "\nExpected page: " + expectedPageName
                    + "\nActual page: " + detectCurrentPage()
                    + "\nCurrent URL: " + driver.getCurrentUrl()
                    + "\nRemaining test steps were stopped."
            );
        }
    }

    /**
     * Opens a URL and ensures the Login page is ready.
     */
    public void openLoginPage(String url) {
        driver.get(url);

        waitForDocumentReady();

        handleLanguagePageIfPresent();

        requireLoginPage(
            "Opening Login URL: " + url
        );
    }

    /**
     * Returns a readable current-page name.
     */
    public String detectCurrentPage() {
        if (isVisible(languagePage)) {
            return "Language Selection";
        }

        if (isVisible(loginPage)) {
            return "Login";
        }

        if (isVisible(dashboardPage)) {
            return "Dashboard";
        }

        return "Unknown Page";
    }

    /**
     * Safely checks element visibility without throwing.
     */
    public boolean isVisible(By locator) {
        try {
            return driver.findElement(locator).isDisplayed();
        } catch (Exception exception) {
            return false;
        }
    }

    /**
     * Waits until the browser document is fully loaded.
     */
    private void waitForDocumentReady() {
        wait.until(webDriver ->
            "complete".equals(
                ((org.openqa.selenium.JavascriptExecutor) webDriver)
                    .executeScript(
                        "return document.readyState"
                    )
            )
        );
    }
}
