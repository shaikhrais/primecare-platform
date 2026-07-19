package base;

public class NavigationRecoveryResult {

    private boolean successful;
    private int attempts;

    private String requestedUrl;
    private String expectedRoute;
    private String expectedPage;

    private String actualUrl;
    private String actualPage;
    private String browserTitle;

    private boolean languagePageDetected;
    private boolean languageSelectionSucceeded;

    private boolean loginPageDetected;
    private boolean loginSucceeded;

    private boolean routeVerified;
    private boolean titleVerified;
    private boolean pageMarkerVerified;
    private boolean mainContentVerified;

    private boolean errorPageDetected;
    private boolean accessDenied;
    private boolean resourceBusy;
    private boolean resourceNotFound;

    private String failureType;
    private String failureMessage;
    private String screenshotPath;

    public boolean isSuccessful() {
        return successful;
    }

    public void setSuccessful(boolean successful) {
        this.successful = successful;
    }

    public int getAttempts() {
        return attempts;
    }

    public void setAttempts(int attempts) {
        this.attempts = attempts;
    }

    public String getRequestedUrl() {
        return requestedUrl;
    }

    public void setRequestedUrl(String requestedUrl) {
        this.requestedUrl = requestedUrl;
    }

    public String getExpectedRoute() {
        return expectedRoute;
    }

    public void setExpectedRoute(String expectedRoute) {
        this.expectedRoute = expectedRoute;
    }

    public String getExpectedPage() {
        return expectedPage;
    }

    public void setExpectedPage(String expectedPage) {
        this.expectedPage = expectedPage;
    }

    public String getActualUrl() {
        return actualUrl;
    }

    public void setActualUrl(String actualUrl) {
        this.actualUrl = actualUrl;
    }

    public String getActualPage() {
        return actualPage;
    }

    public void setActualPage(String actualPage) {
        this.actualPage = actualPage;
    }

    public String getBrowserTitle() {
        return browserTitle;
    }

    public void setBrowserTitle(String browserTitle) {
        this.browserTitle = browserTitle;
    }

    public boolean isLanguagePageDetected() {
        return languagePageDetected;
    }

    public void setLanguagePageDetected(boolean languagePageDetected) {
        this.languagePageDetected = languagePageDetected;
    }

    public boolean isLanguageSelectionSucceeded() {
        return languageSelectionSucceeded;
    }

    public void setLanguageSelectionSucceeded(boolean languageSelectionSucceeded) {
        this.languageSelectionSucceeded = languageSelectionSucceeded;
    }

    public boolean isLoginPageDetected() {
        return loginPageDetected;
    }

    public void setLoginPageDetected(boolean loginPageDetected) {
        this.loginPageDetected = loginPageDetected;
    }

    public boolean isLoginSucceeded() {
        return loginSucceeded;
    }

    public void setLoginSucceeded(boolean loginSucceeded) {
        this.loginSucceeded = loginSucceeded;
    }

    public boolean isRouteVerified() {
        return routeVerified;
    }

    public void setRouteVerified(boolean routeVerified) {
        this.routeVerified = routeVerified;
    }

    public boolean isTitleVerified() {
        return titleVerified;
    }

    public void setTitleVerified(boolean titleVerified) {
        this.titleVerified = titleVerified;
    }

    public boolean isPageMarkerVerified() {
        return pageMarkerVerified;
    }

    public void setPageMarkerVerified(boolean pageMarkerVerified) {
        this.pageMarkerVerified = pageMarkerVerified;
    }

    public boolean isMainContentVerified() {
        return mainContentVerified;
    }

    public void setMainContentVerified(boolean mainContentVerified) {
        this.mainContentVerified = mainContentVerified;
    }

    public boolean isErrorPageDetected() {
        return errorPageDetected;
    }

    public void setErrorPageDetected(boolean errorPageDetected) {
        this.errorPageDetected = errorPageDetected;
    }

    public boolean isAccessDenied() {
        return accessDenied;
    }

    public void setAccessDenied(boolean accessDenied) {
        this.accessDenied = accessDenied;
    }

    public boolean isResourceBusy() {
        return resourceBusy;
    }

    public void setResourceBusy(boolean resourceBusy) {
        this.resourceBusy = resourceBusy;
    }

    public boolean isResourceNotFound() {
        return resourceNotFound;
    }

    public void setResourceNotFound(boolean resourceNotFound) {
        this.resourceNotFound = resourceNotFound;
    }

    public String getFailureType() {
        return failureType;
    }

    public void setFailureType(String failureType) {
        this.failureType = failureType;
    }

    public String getFailureMessage() {
        return failureMessage;
    }

    public void setFailureMessage(String failureMessage) {
        this.failureMessage = failureMessage;
    }

    public String getScreenshotPath() {
        return screenshotPath;
    }

    public void setScreenshotPath(String screenshotPath) {
        this.screenshotPath = screenshotPath;
    }
}
