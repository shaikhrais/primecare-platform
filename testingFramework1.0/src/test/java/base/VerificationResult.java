package base;

public class VerificationResult {

    private int screenId;
    private String testClass;
    private String testMethod;

    private String expectedPage;
    private String actualPage;

    private String expectedRoute;
    private String actualUrl;

    private boolean routeVerified;
    private boolean pageVerified;
    private boolean componentVerified;
    private boolean errorPageFound;

    private String testStatus;
    private String failureMessage;

    private long executionTimeMs;

    public int getScreenId() {
        return screenId;
    }

    public void setScreenId(int screenId) {
        this.screenId = screenId;
    }

    public String getTestClass() {
        return testClass;
    }

    public void setTestClass(String testClass) {
        this.testClass = testClass;
    }

    public String getTestMethod() {
        return testMethod;
    }

    public void setTestMethod(String testMethod) {
        this.testMethod = testMethod;
    }

    public String getExpectedPage() {
        return expectedPage;
    }

    public void setExpectedPage(String expectedPage) {
        this.expectedPage = expectedPage;
    }

    public String getActualPage() {
        return actualPage;
    }

    public void setActualPage(String actualPage) {
        this.actualPage = actualPage;
    }

    public String getExpectedRoute() {
        return expectedRoute;
    }

    public void setExpectedRoute(String expectedRoute) {
        this.expectedRoute = expectedRoute;
    }

    public String getActualUrl() {
        return actualUrl;
    }

    public void setActualUrl(String actualUrl) {
        this.actualUrl = actualUrl;
    }

    public boolean isRouteVerified() {
        return routeVerified;
    }

    public void setRouteVerified(boolean routeVerified) {
        this.routeVerified = routeVerified;
    }

    public boolean isPageVerified() {
        return pageVerified;
    }

    public void setPageVerified(boolean pageVerified) {
        this.pageVerified = pageVerified;
    }

    public boolean isComponentVerified() {
        return componentVerified;
    }

    public void setComponentVerified(boolean componentVerified) {
        this.componentVerified = componentVerified;
    }

    public boolean isErrorPageFound() {
        return errorPageFound;
    }

    public void setErrorPageFound(boolean errorPageFound) {
        this.errorPageFound = errorPageFound;
    }

    public String getTestStatus() {
        return testStatus;
    }

    public void setTestStatus(String testStatus) {
        this.testStatus = testStatus;
    }

    public String getFailureMessage() {
        return failureMessage;
    }

    public void setFailureMessage(String failureMessage) {
        this.failureMessage = failureMessage;
    }

    public long getExecutionTimeMs() {
        return executionTimeMs;
    }

    public void setExecutionTimeMs(long executionTimeMs) {
        this.executionTimeMs = executionTimeMs;
    }
}
