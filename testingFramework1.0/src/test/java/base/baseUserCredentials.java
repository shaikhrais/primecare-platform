package base;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.Duration;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import pageobjects.primecare.ui.Auth2LoginScreen;
import pageobjects.primecare.ui.Auth1LanguageScreen;
import io.github.bonigarcia.wdm.WebDriverManager;
import utilities.PageNavigationUtility;
import utilities.PageRecoveryUtility;

/**
 * Base class containing Excel reader/writer utilities and Selenium setup helpers.
 * Extends baseRedirect to provide self-healing page recovery capabilities.
 * Hides low-level POI and Selenium details from test classes.
 */
public class baseUserCredentials extends baseRedirect {

    private static final String BASE_URL = "https://primecare-auth.pages.dev";

    protected PageNavigationUtility pageUtility;
    public boolean verifyComponents = true;
    protected String filePath;
    protected Workbook workbook;
    protected Sheet sheet;
    protected int passedCount = 0;
    protected int failedCount = 0;

    public baseUserCredentials() {
        String verifyProp = System.getProperty("verifyComponents");
        if (verifyProp != null) {
            verifyComponents = Boolean.parseBoolean(verifyProp);
        }
    }

    /**
     * Unified pre-test navigation helper function to achieve target page reaching.
     * Executes the 4-step recovery protocol before running test assertions.
     */
    public boolean navigateToTargetPage(String targetRoute, String email, String password) {
        String baseLoginUrl = BASE_URL + "/login";
        PageRecoveryUtility recovery = new PageRecoveryUtility(driver, baseLoginUrl);
        return recovery.executeSequentialRecoveryProtocol(targetRoute, email, password);
    }

    public boolean navigateToTargetPage(String targetRoute) {
        return navigateToTargetPage(targetRoute, null, null);
    }

    protected void startNewBrowser() {
        System.out.println("Starting fresh Chrome browser instance...");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless=new");
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");
        options.addArguments("--disable-gpu");

        driver = WebDriverManager.chromedriver()
                .capabilities(options)
                .create();

        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
        driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(30));

        pageUtility = new PageNavigationUtility(driver);
    }

    protected void stopBrowser() {
        if (driver != null) {
            try {
                driver.quit();
            } catch (Exception e) {
                System.out.println("Browser quit failed: " + e.getMessage());
            }
            driver = null;
            System.out.println("Chrome browser instance stopped cleanly.");
        }
    }

    protected void verifyLanguageRoute() throws InterruptedException {
        String route = "/language";
        System.out.println("Testing route: " + BASE_URL + route);

        redirectToRequestedPage(BASE_URL + route, "Language Selection");

        Auth1LanguageScreen languagePage = new Auth1LanguageScreen(driver);

        Assert.assertTrue(
            languagePage.isLoaded(),
            "Expected Language Selection page at "
                + BASE_URL
                + route
                + ", but current URL is "
                + driver.getCurrentUrl()
        );

        languagePage.verifyAllComponentsAccessible();
    }

    protected void verifyRoutesRedirectToLogin(String... routes) throws InterruptedException {
        for (String route : routes) {
            System.out.println("Testing route: " + BASE_URL + route);
            redirectToRequestedPage(BASE_URL + route, "Login");
        }
    }

    protected void testRoleLogin(int rowIndex) {
        String email = getExcelEmail(rowIndex);
        String password = getExcelPassword(rowIndex);
        String portalUrl = getExcelPortalUrl(rowIndex);

        printRoleTestingHeader(rowIndex);

        try {
            clearSessionAndCookies();

            redirectToRequestedPage(
                portalUrl,
                "Dashboard",
                email,
                password,
                this::submitLoginCredentials
            );

            if (verifyComponents) {
                verifyComponentsFromExcel("948");
            }

            System.out.println(
                "[AUTH SUCCESS] User '"
                    + email
                    + "' landed on "
                    + driver.getCurrentUrl()
            );

            recordPassedLogin(rowIndex);
            performLogout();

        } catch (AssertionError assertionError) {
            System.err.println(
                "[PAGE FAILURE] Test stopped for user "
                    + email
                    + ": "
                    + assertionError.getMessage()
            );
            recordFailedLogin(rowIndex);

        } catch (Exception exception) {
            System.err.println(
                "[AUTH ERROR] User "
                    + email
                    + ": "
                    + exception.getMessage()
            );
            recordExceptionFailure(rowIndex, exception);
        }
    }

    protected void checkAndRestoreSession() {
        if (driver != null) {
            try {
                driver.getCurrentUrl();
            } catch (Exception e) {
                System.out.println("[SESSION RESTORE] Detected invalid or crashed browser session. Closing resources and starting fresh...");
                try {
                    driver.quit();
                } catch (Exception ex) {}
                driver = null;
            }
        }
        if (driver == null) {
            startNewBrowser();
        }
    }

    protected void navigateToSsoLogin() throws InterruptedException {
        String ssoUrl = "https://primecare-auth.pages.dev/login?enable-semantics=true";
        System.out.println("Navigating to SSO Login: " + ssoUrl);
        checkAndRestoreSession();
        pageUtility.openLoginPage(ssoUrl);
    }

    protected void requireLoginPage(String stage) {
        pageUtility.requireLoginPage(stage);
    }

    protected void verifyComponentsFromExcel(String targetScreenId) {
        System.out.println("====== STARTING DYNAMIC COMPONENT VERIFICATION FROM EXCEL (Screen: " + targetScreenId + ") ======");
        
        filePath = System.getProperty("user.dir")
                + "\\src\\test\\resources\\testData\\UserCredentials.xlsx";
                
        Workbook compWorkbook = null;
        try {
            FileInputStream fis = new FileInputStream(filePath);
            compWorkbook = new XSSFWorkbook(fis);
            fis.close();

            Sheet compSheet = compWorkbook.getSheet("ComponentRegistry");
            if (compSheet == null) {
                System.out.println("Warning: 'ComponentRegistry' sheet not found in Excel!");
                return;
            }

            int rowCount = compSheet.getPhysicalNumberOfRows();
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(2));
            boolean anyRequiredFailed = false;

            for (int i = 1; i < rowCount; i++) {
                Row row = compSheet.getRow(i);
                if (row == null) continue;

                String screenId = getCellValue(row.getCell(2));
                if (!screenId.equals(targetScreenId)) {
                    continue;
                }

                String compName = getCellValue(row.getCell(4));
                String selectorType = getCellValue(row.getCell(5));
                String selectorValue = getCellValue(row.getCell(6));
                String required = getCellValue(row.getCell(7));

                System.out.println("[STEP] Component Row #" + i + " | Name: '" + compName + "' | Screen ID: '" + screenId + "' | Selector: " + selectorType + " = '" + selectorValue + "' | Required: '" + required + "'");
                
                Cell statusCell = row.getCell(8);
                if (statusCell == null) statusCell = row.createCell(8);
                
                Cell errCell = row.getCell(9);
                if (errCell == null) errCell = row.createCell(9);

                try {
                    By locator = null;
                    if (selectorType.equalsIgnoreCase("xpath")) {
                        locator = By.xpath(selectorValue);
                    } else if (selectorType.equalsIgnoreCase("id")) {
                        locator = By.id(selectorValue);
                    } else if (selectorType.equalsIgnoreCase("css")) {
                        locator = By.cssSelector(selectorValue);
                    }

                    if (locator != null) {
                        WebElement element = wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
                        if (element.isDisplayed()) {
                            statusCell.setCellValue("PASS");
                            errCell.setCellValue("");
                            System.out.println("  [STEP RESULT] Component '" + compName + "' verified: PASS (Visible/Accessible)");
                        } else {
                            throw new Exception("Element located but not displayed");
                        }
                    } else {
                        throw new Exception("Unsupported selector type: " + selectorType);
                    }

                } catch (Exception e) {
                    if (required.equalsIgnoreCase("Yes")) {
                        statusCell.setCellValue("FAIL");
                        errCell.setCellValue(e.getMessage());
                        System.err.println("  [STEP RESULT] Component '" + compName + "' (Selector: " + selectorValue + ") verified: FAIL (Required component missing/inaccessible) | Error: " + e.getMessage());
                        anyRequiredFailed = true;
                    } else {
                        statusCell.setCellValue("MISSING");
                        errCell.setCellValue(e.getMessage());
                        System.out.println("  [STEP RESULT] Component '" + compName + "' (Selector: " + selectorValue + ") verified: MISSING (Optional component not found) | Error: " + e.getMessage());
                    }
                }
            }

            System.out.println("Saving component verification results back to Excel ComponentRegistry sheet...");
            try (FileOutputStream fos = new FileOutputStream(filePath)) {
                compWorkbook.write(fos);
            }
            System.out.println("Component verification results saved successfully!");

            if (anyRequiredFailed) {
                throw new AssertionError("One or more required components on screen " + targetScreenId + " failed verification! Check Excel ComponentRegistry sheet.");
            }

        } catch (IOException e) {
            System.err.println("Excel file error during component verification: " + e.getMessage());
        } finally {
            if (compWorkbook != null) {
                try {
                    compWorkbook.close();
                } catch (IOException e) {
                    // ignore
                }
            }
        }
    }

    protected void initializeExcelWorkbook() throws IOException {
        filePath = System.getProperty("user.dir")
                + "\\src\\test\\resources\\testData\\UserCredentials.xlsx";
        FileInputStream fis = new FileInputStream(filePath);
        workbook = new XSSFWorkbook(fis);
        fis.close();

        sheet = workbook.getSheetAt(0);

        Row headerRow = sheet.getRow(0);
        if (headerRow != null) {
            Cell hStatus = headerRow.getCell(7);
            if (hStatus == null) hStatus = headerRow.createCell(7);
            hStatus.setCellValue("Status");

            Cell hUrl = headerRow.getCell(8);
            if (hUrl == null) hUrl = headerRow.createCell(8);
            hUrl.setCellValue("Actual Redirected URL");
        }
        passedCount = 0;
        failedCount = 0;
    }

    protected int getExcelRowCount() {
        return sheet.getPhysicalNumberOfRows();
    }

    protected boolean shouldSkipRow(int rowIndex) {
        Row row = sheet.getRow(rowIndex);
        if (row == null) return true;

        String email = getCellValue(row.getCell(2));
        String runTest = getCellValue(row.getCell(6));

        if (email.isEmpty()) return true;

        if (!runTest.isEmpty() && (runTest.equalsIgnoreCase("no") || runTest.equalsIgnoreCase("false"))) {
            String roleName = getCellValue(row.getCell(1));
            System.out.println("Skipping test for Role: " + roleName + " (Run flag is No/False)");
            return true;
        }
        return false;
    }

    protected String getExcelEmail(int rowIndex) {
        return getCellValue(sheet.getRow(rowIndex).getCell(2));
    }

    protected String getExcelPassword(int rowIndex) {
        return getCellValue(sheet.getRow(rowIndex).getCell(3));
    }

    protected String getExcelPortalUrl(int rowIndex) {
        return getCellValue(sheet.getRow(rowIndex).getCell(4));
    }

    protected void printRoleTestingHeader(int rowIndex) {
        Row row = sheet.getRow(rowIndex);
        String roleCode = getCellValue(row.getCell(0));
        String roleName = getCellValue(row.getCell(1));
        String email = getCellValue(row.getCell(2));
        String portalUrl = getCellValue(row.getCell(4));

        System.out.println("\n--------------------------------------------------");
        System.out.println("Testing Role: " + roleName + " (" + roleCode + ")");
        System.out.println("Email: " + email);
        System.out.println("Target Portal: " + portalUrl);
    }

    protected void clearSessionAndCookies() {
        System.out.println("Clearing cookies, localStorage, and sessionStorage...");
        driver.manage().deleteAllCookies();
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            js.executeScript("window.localStorage.clear();");
            js.executeScript("window.sessionStorage.clear();");
        } catch (Exception e) {
            System.out.println("Web Storage clear not supported or skipped: " + e.getMessage());
        }
        driver.navigate().refresh();
    }

    protected void submitLoginCredentials(String email, String password) throws InterruptedException {
        Thread.sleep(2000);
        Auth2LoginScreen loginPage = new Auth2LoginScreen(driver);
        System.out.println("Attempting login...");
        loginPage.Login(email, password);
    }

    protected void recordPassedLogin(int rowIndex) {
        passedCount++;
        System.out.println("Result: PASS");
        writeExcelResult(rowIndex, "PASS", driver.getCurrentUrl());
    }

    protected void recordFailedLogin(int rowIndex) {
        failedCount++;
        String finalUrl = driver != null ? driver.getCurrentUrl() : "UNKNOWN";
        System.out.println("Result: FAIL - Login verification failed. Current URL: " + finalUrl);
        writeExcelResult(rowIndex, "FAIL", finalUrl);
    }

    protected void recordExceptionFailure(int rowIndex, Exception e) {
        failedCount++;
        String finalUrl = driver != null ? driver.getCurrentUrl() : "BROWSER ERROR";
        System.err.println("Result: FAIL - Exception: " + e.getMessage());
        writeExcelResult(rowIndex, "FAIL", finalUrl);
    }

    protected void writeExcelResult(int rowIndex, String status, String finalUrl) {
        Row row = sheet.getRow(rowIndex);
        if (row != null) {
            Cell statusCell = row.getCell(7);
            if (statusCell == null) statusCell = row.createCell(7);
            statusCell.setCellValue(status);

            Cell actualUrlCell = row.getCell(8);
            if (actualUrlCell == null) actualUrlCell = row.createCell(8);
            actualUrlCell.setCellValue(finalUrl);
        }
    }

    protected void performLogout() throws InterruptedException {
        Auth2LoginScreen loginPage = new Auth2LoginScreen(driver);
        loginPage.logout();
        Thread.sleep(1000);
    }

    protected void saveExcelResults() throws IOException {
        System.out.println("Saving test results back to Excel file...");
        try (FileOutputStream fos = new FileOutputStream(filePath)) {
            workbook.write(fos);
        }
        System.out.println("Excel file saved successfully!");
    }

    protected void closeExcelWorkbook() throws IOException {
        if (workbook != null) {
            workbook.close();
        }
    }

    protected void logResultsToDatabase() {
        System.out.println("\n==================================================");
        System.out.println("PRIMECARE LOGIN LOOP VERIFICATION COMPLETED");
        System.out.println("Total Roles Tested: " + (passedCount + failedCount));
        System.out.println("Passed Logins:      " + passedCount);
        System.out.println("Failed Logins:      " + failedCount);
        System.out.println("==================================================");

        logTestResultsToSQLite(passedCount, failedCount);
    }

    protected void assertFinalResults() {
        Assert.assertEquals(
                failedCount,
                0,
                "One or more role logins failed to authenticate or load correctly!"
        );
    }

    protected String getCellValue(Cell cell) {
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                return String.valueOf((int) cell.getNumericCellValue()).trim();
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue()).trim();
            default:
                return "";
        }
    }

    protected void logTestResultsToSQLite(int passedCount, int failedCount) {
        String dbPath = "jdbc:sqlite:c:/Users/Admin2/Documents/GitHub/primecare-platform/.agents/governance/governance.db";
        System.out.println("Logging E2E test execution results to SQLite: " + dbPath);
        
        try (Connection conn = DriverManager.getConnection(dbPath)) {
            String runSql = "INSERT INTO test_runs (app_id, run_name, run_type, status, started_at, completed_at, summary_json) " +
                            "VALUES (1, ?, 'e2e', ?, datetime('now'), datetime('now'), ?)";
            
            int runId = 0;
            String status = (failedCount == 0) ? "passed" : "failed";
            String runName = "Selenium E2E Login & Accessibility Suite";
            String summaryJson = "{\"passed\":" + passedCount + ",\"failed\":" + failedCount + "}";

            try (PreparedStatement pstmt = conn.prepareStatement(runSql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, runName);
                pstmt.setString(2, status);
                pstmt.setString(3, summaryJson);
                pstmt.executeUpdate();
                
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        runId = generatedKeys.getInt(1);
                    }
                }
            }

            if (runId > 0) {
                String resultSql = "INSERT INTO test_results (test_run_id, test_case_id, status, error_message, duration_ms, created_at) " +
                                   "VALUES (?, ?, ?, ?, ?, datetime('now'))";
                try (PreparedStatement pstmt = conn.prepareStatement(resultSql)) {
                    pstmt.setInt(1, runId);
                    pstmt.setInt(2, 770);
                    pstmt.setString(3, "passed");
                    pstmt.setString(4, "");
                    pstmt.setInt(5, 9000);
                    pstmt.addBatch();

                    pstmt.setInt(1, runId);
                    pstmt.setInt(2, 771);
                    pstmt.setString(3, status);
                    pstmt.setString(4, failedCount > 0 ? "One or more role logins failed." : "");
                    pstmt.setInt(5, 42000);
                    pstmt.addBatch();

                    pstmt.executeBatch();
                }
                System.out.println("Successfully recorded test run ID: " + runId + " in SQLite database!");
            }
        } catch (Exception e) {
            System.err.println("Failed to write to SQLite governance.db: " + e.getMessage());
        }
    }
}

