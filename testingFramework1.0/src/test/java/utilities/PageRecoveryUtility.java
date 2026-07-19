package utilities;

import java.time.Duration;
import java.util.List;
import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import primecare.testing.framework.database.Repositories.ScreenRepository;
import primecare.testing.framework.planning.Models.ScreenDefinition;

public class PageRecoveryUtility {

    private static final int MAX_ATTEMPTS = 3;

    private final WebDriver driver;
    private final WebDriverWait wait;
    private final String loginUrl;

    private final String langPageLabel = "language-continue-button";
    private final String loginPageLabel = "login-email";
    private final String emailLabel = "login-email";
    private final String passwordLabel = "login-password";
    private final String submitLabel = "login-submit";
    private final String logoutLabel = "topbar-logout-button";

    public PageRecoveryUtility(
        WebDriver driver,
        String loginUrl
    ) {
        this.driver = driver;
        this.loginUrl = loginUrl;

        this.wait = new WebDriverWait(
            driver,
            Duration.ofSeconds(15)
        );
    }

    private WebElement findElementByAriaLabel(String label) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            return (WebElement) js.executeScript(
                "var findByAriaLabel = function(root, label) { " +
                "    if (!root) return null; " +
                "    var el = root.querySelector(\"[aria-label*='\" + label + \"']\"); " +
                "    if (el) return el; " +
                "    var all = root.querySelectorAll('*'); " +
                "    for (var i = 0; i < all.length; i++) { " +
                "        var child = all[i]; " +
                "        if (child.shadowRoot) { " +
                "            var found = findByAriaLabel(child.shadowRoot, label); " +
                "            if (found) return found; " +
                "        } " +
                "    } " +
                "    return null; " +
                "}; " +
                "return findByAriaLabel(document, arguments[0]);",
                label
            );
        } catch (Exception e) {
            return null;
        }
    }

    public boolean isElementVisible(String label) {
        WebElement element = findElementByAriaLabel(label);
        if (element == null) return false;
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            Boolean visible = (Boolean) js.executeScript(
                "var el = arguments[0]; " +
                "if (!el) return false; " +
                "var rect = el.getBoundingClientRect(); " +
                "if (rect.width === 0 || rect.height === 0) return false; " +
                "var style = window.getComputedStyle(el); " +
                "if (style.display === 'none' || style.visibility === 'hidden') return false; " +
                "var parent = el.parentElement; " +
                "while (parent) { " +
                "    var pStyle = window.getComputedStyle(parent); " +
                "    if (pStyle.display === 'none' || pStyle.visibility === 'hidden') return false; " +
                "    parent = parent.parentElement; " +
                "} " +
                "return true;", 
                element
            );
            return visible != null && visible;
        } catch (Exception e) {
            return false;
        }
    }

    public void openRequestedPage(
        String requestedUrl,
        By requestedPageMarker,
        String requestedPageName,
        String email,
        String password
    ) {
        for (int attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
            System.out.println(
                "[PAGE RECOVERY] Attempt "
                    + attempt
                    + "/"
                    + MAX_ATTEMPTS
                    + " for "
                    + requestedPageName
            );

            getWithSemantics(requestedUrl);
            waitForDocumentReady();
            enableSemantics();
            
            // Wait up to 15 seconds for any pending SSO/authentication redirects to complete and land on the login page
            if (!requestedUrl.contains("/language")) {
                try {
                    new WebDriverWait(driver, Duration.ofSeconds(3)).until(webDriver -> 
                        driver.getCurrentUrl().contains("/login") && isElementVisible(loginPageLabel)
                    );
                } catch (Exception e) {
                    // Ignore and proceed
                }
            }

            /*
             * If app sends us to Language page,
             * do not test anything there.
             *
             * Go directly to Login.
             */
            if (isElementVisible(langPageLabel)) {
                System.out.println(
                    "[PAGE RECOVERY] Language page detected. "
                        + "Redirecting to Login."
                );

                getWithSemantics(loginUrl);
                waitForDocumentReady();
                enableSemantics();
            }

            /*
             * Login when Login page is displayed
             * or no authenticated user is detected.
             */
            if ((isElementVisible(loginPageLabel) || !isLoggedIn()) && !requestedUrl.contains("/login") && !requestedUrl.contains("/language")) {
                ensureLoginPage();
                performLogin(email, password);
            }

            /*
             * After authentication, open the originally
             * requested page.
             */
            getWithSemantics(requestedUrl);
            waitForDocumentReady();
            try {
                Thread.sleep(3000);
            } catch (InterruptedException ie) {
                Thread.currentThread().interrupt();
            }
            enableSemantics();

            /*
             * App may again redirect to Language or Login.
             */
            if (isElementVisible(langPageLabel) && !requestedUrl.contains("/language")) {
                System.err.println(
                    "[PAGE RECOVERY] Language page appeared again."
                );
                continue;
            }

            if (isElementVisible(loginPageLabel) && !requestedUrl.contains("/login")) {
                System.err.println(
                    "[PAGE RECOVERY] Login page appeared again."
                );
                continue;
            }

            // Check using element visible by xpath helper
            try {
                WebElement markerEl = driver.findElement(requestedPageMarker);
                if (markerEl != null && markerEl.isDisplayed()) {
                    System.out.println(
                        "[PAGE RECOVERY] Correct page opened: "
                            + requestedPageName
                    );
                    return;
                }
            } catch (Exception e) {}

            System.err.println(
                "[PAGE RECOVERY] Wrong page after recovery."
                    + "\nExpected: "
                    + requestedPageName
                    + "\nCurrent URL: "
                    + driver.getCurrentUrl()
            );
        }

        Assert.fail(
            "\nPAGE RECOVERY FAILED"
                + "\nExpected page: "
                + requestedPageName
                + "\nRequested URL: "
                + requestedUrl
                + "\nCurrent URL: "
                + driver.getCurrentUrl()
                + "\nAttempts: "
                + MAX_ATTEMPTS
        );
    }

    private void ensureLoginPage() {
        if (isElementVisible(loginPageLabel)) {
            return;
        }

        getWithSemantics(loginUrl);
        waitForDocumentReady();
        enableSemantics();

        Assert.assertTrue(
            isElementVisible(loginPageLabel),
            "Login page did not open. Current URL: "
                + driver.getCurrentUrl()
        );
    }

    private void performLogin(
        String email,
        String password
    ) {
        wait.until(webDriver -> {
            enableSemantics();
            String url = driver.getCurrentUrl();
            if (url.contains("/language") || url.contains("/clinic/dashboard") || isLoggedIn()) {
                return true;
            }
            WebElement emailInput = findElementByAriaLabel(emailLabel);
            WebElement passwordInput = findElementByAriaLabel(passwordLabel);
            WebElement submit = findElementByAriaLabel(submitLabel);
            if (emailInput != null && passwordInput != null && submit != null) {
                try {
                    try {
                        emailInput.clear();
                    } catch (Exception ignored) {}
                    emailInput.sendKeys(email);
                    
                    try {
                        passwordInput.clear();
                    } catch (Exception ignored) {}
                    passwordInput.sendKeys(password);
                    
                    clickElement(submit);
                    return true;
                } catch (Exception e) {
                    return false;
                }
            }
            return false;
        });

        // Wait for login page to become invisible/inactive, or redirect to occur
        wait.until(webDriver -> {
            checkForMechanicalFix();
            enableSemantics();
            String url = driver.getCurrentUrl();
            return !isElementVisible(loginPageLabel) || isLoggedIn() || url.contains("/language") || url.contains("/clinic/dashboard");
        });
    }

    private boolean isLoggedIn() {
        return isElementVisible(logoutLabel) || isElementVisible("topbar-user-menu");
    }

    public void checkForMechanicalFix() {
        if (isMechanicalFixActive()) {
            throw new AssertionError(
                "Application crashed and entered mechanical self-healing mode (MECHANICAL FIX IN PROGRESS)."
            );
        }
    }

    public boolean isMechanicalFixActive() {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            Boolean active = (Boolean) js.executeScript(
                "var text = 'MECHANICAL FIX IN PROGRESS'; " +
                "var matches = document.evaluate(" +
                "    \"//*[contains(text(), '\" + text + \"') or contains(@aria-label, '\" + text + \"')]\", " +
                "    document, null, XPathResult.BOOLEAN_TYPE, null" +
                "); " +
                "return matches.booleanValue;"
            );
            return active != null && active;
        } catch (Exception e) {
            return false;
        }
    }

    public void waitForDocumentReady() {
        new WebDriverWait(driver, Duration.ofSeconds(5)).until(d -> 
            "complete".equals(((JavascriptExecutor) d).executeScript("return document.readyState")));
    }

    public void enableSemantics() {
        try {
            new WebDriverWait(driver, Duration.ofSeconds(5)).until(webDriver -> {
                try {
                    JavascriptExecutor js = (JavascriptExecutor) driver;
                    Boolean present = (Boolean) js.executeScript(
                        "var findPlaceholder = function(root) { " +
                        "    if (!root) return null; " +
                        "    var el = root.querySelector('flt-semantics-placeholder'); " +
                        "    if (el) return el; " +
                        "    var all = root.querySelectorAll('*'); " +
                        "    for (var i = 0; i < all.length; i++) { " +
                        "        var child = all[i]; " +
                        "        if (child.shadowRoot) { " +
                        "            var found = findPlaceholder(child.shadowRoot); " +
                        "            if (found) return found; " +
                        "        } " +
                        "    } " +
                        "    return null; " +
                        "}; " +
                        "var findActive = function(root) { " +
                        "    if (!root) return null; " +
                        "    var el = root.querySelector('flt-semantics'); " +
                        "    if (el && el.tagName.toLowerCase() !== 'flt-semantics-host' && el.tagName.toLowerCase() !== 'flt-semantics-placeholder') { " +
                        "        return el; " +
                        "    } " +
                        "    var all = root.querySelectorAll('*'); " +
                        "    for (var i = 0; i < all.length; i++) { " +
                        "        var child = all[i]; " +
                        "        if (child.shadowRoot) { " +
                        "            var found = findActive(child.shadowRoot); " +
                        "            if (found) return found; " +
                        "        } " +
                        "    } " +
                        "    return null; " +
                        "}; " +
                        "return findPlaceholder(document) !== null || findActive(document) !== null;"
                    );
                    return present != null && present;
                } catch (Exception e) {
                    return false;
                }
            });

            JavascriptExecutor js = (JavascriptExecutor) driver;
            Object success = js.executeScript(
                "var findPlaceholder = function(root) { " +
                "    if (!root) return null; " +
                "    var el = root.querySelector('flt-semantics-placeholder'); " +
                "    if (el) return el; " +
                "    var all = root.querySelectorAll('*'); " +
                "    for (var i = 0; i < all.length; i++) { " +
                "        var child = all[i]; " +
                "        if (child.shadowRoot) { " +
                "            var found = findPlaceholder(child.shadowRoot); " +
                "            if (found) return found; " +
                "        } " +
                "    } " +
                "    return null; " +
                "}; " +
                "var findActive = function(root) { " +
                "    if (!root) return null; " +
                "    var el = root.querySelector('flt-semantics'); " +
                "    if (el && el.tagName.toLowerCase() !== 'flt-semantics-host' && el.tagName.toLowerCase() !== 'flt-semantics-placeholder') { " +
                "        return el; " +
                "    } " +
                "    var all = root.querySelectorAll('*'); " +
                "    for (var i = 0; i < all.length; i++) { " +
                "        var child = all[i]; " +
                "        if (child.shadowRoot) { " +
                "            var found = findActive(child.shadowRoot); " +
                "            if (found) return found; " +
                "        } " +
                "    } " +
                "    return null; " +
                "}; " +
                "var placeholder = findPlaceholder(document); " +
                "if (placeholder) { " +
                "    placeholder.click(); " +
                "    return 'clicked-placeholder'; " +
                "} " +
                "var active = findActive(document); " +
                "if (active) { " +
                "    return 'already-active'; " +
                "} " +
                "return 'not-found';"
            );
            System.out.println("[SEMANTICS] enableSemantics result: " + success);
            Thread.sleep(1000);
        } catch (Exception e) {
            System.err.println("[SEMANTICS] Failed to enable semantics: " + e.getMessage());
        }
    }

    public enum State {
        APP_START,
        LANGUAGE,
        CLINIC_LOGIN,
        CENTRAL_AUTH_LOGIN,
        AUTHENTICATING,
        SUCCESS,
        TARGET,
        NOT_FOUND,
        SERVICE_UNAVAILABLE,
        RESOURCE_FAILURE,
        UNKNOWN
    }

    private String normalizeUrl(String url) {
        if (url == null) return "";
        String res = url;
        if (res.contains("?")) {
            res = res.split("\\?")[0];
        }
        if (res.endsWith("/")) {
            res = res.substring(0, res.length() - 1);
        }
        return res;
    }

    private String waitForStableUrl() {
        String lastUrl = driver.getCurrentUrl();
        int stableCount = 0;
        int retries = 0;
        while (retries < 25) {
            try {
                Thread.sleep(200);
            } catch (Exception e) {}
            String currentUrl = driver.getCurrentUrl();
            if (currentUrl.equals(lastUrl)) {
                stableCount++;
                if (stableCount >= 2) {
                    try {
                        String state = (String) ((JavascriptExecutor) driver).executeScript("return document.readyState;");
                        if ("complete".equals(state)) {
                            break;
                        }
                    } catch (Exception e) {}
                }
            } else {
                stableCount = 0;
            }
            lastUrl = currentUrl;
            retries++;
        }
        checkForMechanicalFix();
        return lastUrl;
    }

    public void navigateToTargetScreen(
        String requestedUrl,
        String expectedScreenId,
        String email,
        String password
    ) {
        List<String> routeHistory = new ArrayList<>();
        State currentState = State.APP_START;
        int transitionCount = 0;
        
        System.out.println("[ROUTE MANAGER] Starting navigation to target screen: " + expectedScreenId + " at " + requestedUrl);
        
        getWithSemantics(requestedUrl);
        waitForStableUrl();
        
        while (transitionCount < 10) {
            String currentUrl = waitForStableUrl();
            routeHistory.add(currentUrl);
            
            String normalizedUrl = normalizeUrl(currentUrl);
            final String finalNormUrl = normalizedUrl;
            long count = routeHistory.stream().map(this::normalizeUrl).filter(u -> u.equals(finalNormUrl)).count();
            if (count > 2 || transitionCount > 6) {
                throw new AssertionError("SSO_REDIRECT_LOOP: Redirect loop detected on route: " + currentUrl + ". History: " + routeHistory);
            }
            
            currentState = determineState(currentUrl, expectedScreenId);
            System.out.println("[ROUTE MANAGER] State: " + currentState + " | URL: " + currentUrl);
            
            switch (currentState) {
                case LANGUAGE:
                    handleLanguageState();
                    break;
                case CLINIC_LOGIN:
                    System.out.println("[ROUTE MANAGER] On clinic login bridge. Waiting for redirect to Central Auth...");
                    try {
                        new WebDriverWait(driver, Duration.ofSeconds(5)).until(d -> 
                            d.getCurrentUrl().contains("primecare-auth") || d.getCurrentUrl().contains("auth.")
                        );
                    } catch (Exception e) {}
                    break;
                case CENTRAL_AUTH_LOGIN:
                    performLogin(email, password);
                    break;
                case SUCCESS:
                    if (!currentUrl.contains(requestedUrl)) {
                        getWithSemantics(requestedUrl);
                        waitForStableUrl();
                    }
                    break;
                case TARGET:
                    verifyScreenIdentity(expectedScreenId, currentUrl);
                    System.out.println("[ROUTE MANAGER] Target screen reached and verified: " + expectedScreenId);
                    return;
                case NOT_FOUND:
                    throw new AssertionError("ROUTE_FAILED_404: Screen not found (404) at " + currentUrl);
                case SERVICE_UNAVAILABLE:
                    throw new AssertionError("ENVIRONMENT_FAILED_503: Service Unavailable (503) at " + currentUrl);
                case RESOURCE_FAILURE:
                    throw new AssertionError("CRITICAL_RESOURCE_FAILURE: App render failure or mechanical fix page at " + currentUrl);
                case UNKNOWN:
                default:
                    enableSemantics();
                    if (isMechanicalFixActive()) {
                        throw new AssertionError("CRITICAL_RESOURCE_FAILURE: App crashed on route: " + currentUrl);
                    }
                    getWithSemantics(requestedUrl);
                    waitForStableUrl();
                    break;
            }
            
            transitionCount++;
        }
        
        throw new AssertionError("ROUTE_FAILED: Exceeded maximum transitions (10) without reaching target screen: " + expectedScreenId);
    }

    private State determineState(String currentUrl, String expectedScreenId) {
        if (isMechanicalFixActive()) {
            return State.RESOURCE_FAILURE;
        }
        
        System.out.println("[DEBUG] determineState - currentUrl: " + currentUrl + " | expectedScreenId: " + expectedScreenId);
        System.out.println("[DEBUG] isElementVisible(langPageLabel='" + langPageLabel + "'): " + isElementVisible(langPageLabel));
        System.out.println("[DEBUG] isElementVisible(loginPageLabel='" + loginPageLabel + "'): " + isElementVisible(loginPageLabel));
        System.out.println("[DEBUG] isElementVisible(expectedScreenId='" + expectedScreenId + "'): " + isElementVisible(expectedScreenId));
        System.out.println("[DEBUG] isElementVisible(logoutLabel='" + logoutLabel + "'): " + isElementVisible(logoutLabel));
        
        if (currentUrl.contains("/clinic/dashboard") && !isElementVisible("topbar-logout-button")) {
            try {
                new WebDriverWait(driver, Duration.ofSeconds(8)).until(d -> 
                    d.getCurrentUrl().contains("/login") || d.getCurrentUrl().contains("/language") || isElementVisible("topbar-logout-button")
                );
                currentUrl = driver.getCurrentUrl();
            } catch (Exception ignored) {}
        }
        if ((expectedScreenId.equalsIgnoreCase("success") || expectedScreenId.equalsIgnoreCase("dashboard")) && currentUrl.contains("/clinic/dashboard")) {
            if (isElementVisible("topbar-logout-button")) {
                return State.TARGET;
            }
        }
        if (expectedScreenId.equalsIgnoreCase("language") && (currentUrl.contains("/language") || isElementVisible(langPageLabel))) {
            return State.TARGET;
        }
        if (expectedScreenId.equalsIgnoreCase("login") && (currentUrl.contains("/login") || isElementVisible(loginPageLabel))) {
            return State.TARGET;
        }
        if (isElementVisible(expectedScreenId)) {
            return State.TARGET;
        }
        try {
            ScreenDefinition screenDef = ScreenRepository.getScreenByKey(expectedScreenId);
            if (screenDef != null && screenDef.route != null && compareRoutes(currentUrl, screenDef.route)) {
                return State.TARGET;
            }
        } catch (Exception ignored) {}
        if (isElementVisible(langPageLabel) || currentUrl.contains("/language")) {
            return State.LANGUAGE;
        }
        if (currentUrl.contains("/login") || isElementVisible(loginPageLabel)) {
            if (currentUrl.contains("primecare-auth") || currentUrl.contains("auth.")) {
                return State.CENTRAL_AUTH_LOGIN;
            } else {
                return State.CLINIC_LOGIN;
            }
        }
        if (currentUrl.contains("/sso-redirect") || currentUrl.contains("/auth/callback")) {
            return State.AUTHENTICATING;
        }
        if (currentUrl.contains("/invalid-test-path-for-404") || isElementVisible("not-found-screen")) {
            return State.NOT_FOUND;
        }
        if (isElementVisible("service-unavailable-screen")) {
            return State.SERVICE_UNAVAILABLE;
        }
        if (currentUrl.contains("/clinic/dashboard")) {
            return State.SUCCESS;
        }
        String path = currentUrl;
        if (path.contains("?")) path = path.split("\\?")[0];
        if (path.endsWith("/")) path = path.substring(0, path.length() - 1);
        
        return State.UNKNOWN;
    }

    private void handleLanguageState() {
        enableSemantics();
        WebElement langCard = null;
        try {
            langCard = driver.findElement(By.xpath("//*[contains(@aria-label, 'lang-english') or contains(@aria-label, 'language-english') or contains(text(), 'lang-english') or contains(text(), 'language-english')]"));
        } catch (Exception ignored) {}
        
        if (langCard != null) {
            System.out.println("[PAGE RECOVERY] Clicking English language card.");
            clickElement(langCard);
            try {
                Thread.sleep(1000);
            } catch (Exception ignored) {}
        }
        
        if (driver.getCurrentUrl().contains("/language")) {
            WebElement continueBtn = findElementByAriaLabel("language-continue-button");
            if (continueBtn != null) {
                System.out.println("[PAGE RECOVERY] Clicking Continue button.");
                clickElement(continueBtn);
            }
        }
        
        wait.until(webDriver -> {
            enableSemantics();
            return !isElementVisible("language-continue-button") && !driver.getCurrentUrl().contains("/language");
        });
    }

    private void clickElement(WebElement element) {
        if (element == null) return;
        try {
            try {
                JavascriptExecutor js = (JavascriptExecutor) driver;
                js.executeScript(
                    "var el = arguments[0]; " +
                    "var target = el.querySelector('[role=\"button\"], [flt-tappable], [tabindex=\"0\"]') || el; " +
                    "var mousedown = new MouseEvent('mousedown', { bubbles: true, cancelable: true, view: window }); " +
                    "var mouseup = new MouseEvent('mouseup', { bubbles: true, cancelable: true, view: window }); " +
                    "var click = new MouseEvent('click', { bubbles: true, cancelable: true, view: window }); " +
                    "target.dispatchEvent(mousedown); " +
                    "target.dispatchEvent(mouseup); " +
                    "target.dispatchEvent(click);", 
                    element
                );
            } catch (Exception jsEx) {
                System.err.println("[PAGE RECOVERY] JS click failed: " + jsEx.getMessage());
                // Fallback to standard Selenium click
                try {
                    element.click();
                } catch (Exception clickEx) {
                    System.err.println("[PAGE RECOVERY] Fallback click failed: " + clickEx.getMessage());
                }
            }
        } catch (Exception e) {
            System.err.println("[PAGE RECOVERY] clickElement failed: " + e.getMessage());
        }
    }

    private void verifyScreenIdentity(String expectedScreenId, String currentUrl) {
        String title = driver.getTitle();
        System.out.println("[IDENTITY VERIFICATION] Expected Screen ID: " + expectedScreenId + " | Title: " + title + " | URL: " + currentUrl);
        
        Assert.assertNotNull(title, "Screen Identity Check Failed: Title is null");
        Assert.assertTrue(currentUrl.length() > 0, "Screen Identity Check Failed: URL is empty");
        
        if ((expectedScreenId.equalsIgnoreCase("success") || expectedScreenId.equalsIgnoreCase("dashboard")) && currentUrl.contains("/clinic/dashboard")) {
            return;
        }
        if (expectedScreenId.equalsIgnoreCase("login") && currentUrl.contains("/login")) {
            return;
        }
        if (expectedScreenId.equalsIgnoreCase("language") && currentUrl.contains("/language")) {
            return;
        }
        
        if (isElementVisible(expectedScreenId)) {
            return;
        }
        try {
            ScreenDefinition screenDef = ScreenRepository.getScreenByKey(expectedScreenId);
            if (screenDef != null && screenDef.route != null && compareRoutes(currentUrl, screenDef.route)) {
                return;
            }
        } catch (Exception ignored) {}
        
        Assert.assertTrue(isElementVisible(expectedScreenId), 
            "Screen Identity Check Failed: Screen identifier '" + expectedScreenId + "' was not found or visible on the current page. Current URL: " + currentUrl);
    }

    private void getWithSemantics(String url) {
        if (url == null) return;
        String finalUrl = url;
        if (!finalUrl.contains("enable-semantics=true")) {
            finalUrl += (finalUrl.contains("?") ? "&" : "?") + "enable-semantics=true";
        }
        driver.get(finalUrl);
    }

    public boolean compareRoutes(String url1, String url2) {
        try {
            java.net.URI uri1 = new java.net.URI(url1.trim().toLowerCase());
            java.net.URI uri2 = new java.net.URI(url2.trim().toLowerCase());
            String p1 = uri1.getPath();
            String p2 = uri2.getPath();
            if (p1 == null) p1 = "";
            if (p2 == null) p2 = "";
            p1 = p1.replaceAll("/$", "");
            p2 = p2.replaceAll("/$", "");
            if (p1.equalsIgnoreCase(p2)) return true;
            if ((p1.equals("/success") && p2.equals("/dashboard")) ||
                (p1.equals("/dashboard") && p2.equals("/success"))) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return url1.contains(url2) || url2.contains(url1);
        }
    }
}
