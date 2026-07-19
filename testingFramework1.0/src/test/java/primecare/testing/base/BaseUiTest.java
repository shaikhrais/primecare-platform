package primecare.testing.base;

import utilities.PageRecoveryUtility;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import primecare.testing.framework.database.DeploymentConfig;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.Duration;

public class BaseUiTest extends BaseTest {
    protected WebDriver driver;
    protected PageRecoveryUtility pageRecovery;

    public WebDriver getDriver() {
        return driver;
    }

    @BeforeMethod(alwaysRun = true)
    public void setupDriver() {
        String browser = appProps.getProperty("browser", "chrome").toLowerCase();
        String headlessSystemProp = System.getProperty("headless");
        boolean headless = headlessSystemProp != null ? Boolean.parseBoolean(headlessSystemProp) : Boolean.parseBoolean(appProps.getProperty("headless", "true"));

        switch (browser) {
            case "firefox":
                FirefoxOptions ffOptions = new FirefoxOptions();
                if (headless) {
                    ffOptions.addArguments("-headless");
                }
                driver = new FirefoxDriver(ffOptions);
                driver.manage().window().setSize(new org.openqa.selenium.Dimension(1920, 1080));
                break;
            case "edge":
                EdgeOptions edgeOptions = new EdgeOptions();
                if (headless) {
                    edgeOptions.addArguments("--headless=new");
                }
                edgeOptions.addArguments("--window-size=1920,1080");
                driver = new EdgeDriver(edgeOptions);
                driver.manage().window().setSize(new org.openqa.selenium.Dimension(1920, 1080));
                break;
            case "chrome":
            default:
                ChromeOptions options = new ChromeOptions();
                org.openqa.selenium.logging.LoggingPreferences logPrefs = new org.openqa.selenium.logging.LoggingPreferences();
                logPrefs.enable(org.openqa.selenium.logging.LogType.BROWSER, java.util.logging.Level.ALL);
                options.setCapability("goog:loggingPrefs", logPrefs);
                
                if (headless) {
                    options.addArguments("--headless=new");
                }
                options.addArguments("--disable-gpu");
                options.addArguments("--window-size=1920,1080");
                options.addArguments("--no-sandbox");
                options.addArguments("--disable-dev-shm-usage");
                driver = new ChromeDriver(options);
                driver.manage().window().setSize(new org.openqa.selenium.Dimension(1920, 1080));
                break;
        }

        driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(
            Integer.parseInt(appProps.getProperty("page.load.timeout", "30"))
        ));
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(
            Integer.parseInt(appProps.getProperty("element.timeout", "5"))
        ));

        String base = System.getProperty("APP_BASE_URL");
        String loginUrl;
        if (base != null) {
            loginUrl = base + "/login";
        } else {
            loginUrl = System.getProperty("login.url", appProps.getProperty("login.url", "http://localhost:8080/login"));
        }
        pageRecovery = new PageRecoveryUtility(driver, loginUrl);
    }

    @AfterMethod(alwaysRun = true)
    public void tearDownDriver() {
        if (driver != null) {
            driver.quit();
        }
    }

    public void dumpDom(String screenKey) {
        try {
            if (driver == null) {
                System.err.println("[DOM DUMP] Driver is null, cannot dump DOM.");
                return;
            }
            String pageSource = driver.getPageSource();
            String evidenceDir = appProps.getProperty("evidence.directory", "evidence");
            File domDir = new File(evidenceDir, "dom");
            if (!domDir.exists()) {
                domDir.mkdirs();
            }
            File domFile = new File(domDir, screenKey + "_dom.html");
            java.nio.file.Files.writeString(domFile.toPath(), pageSource);
            System.out.println("[DOM DUMP] Saved page source to: " + domFile.getAbsolutePath());
        } catch (Exception e) {
            System.err.println("[DOM DUMP] Failed to save page source: " + e.getMessage());
        }
    }

    public File captureScreenshot(String name) {
        if (driver instanceof TakesScreenshot) {
            File srcFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
            String screenshotDir = appProps.getProperty("screenshot.directory", "evidence/screenshots");
            File dir = new File(screenshotDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File destFile = new File(dir, name + "_" + System.currentTimeMillis() + ".png");
            try {
                Files.copy(srcFile.toPath(), destFile.toPath());
                return destFile;
            } catch (IOException e) {
                System.err.println("[SCREENSHOT] Failed to save screenshot: " + e.getMessage());
            }
        }
        return null;
    }

    public File captureClassifiedScreenshot(String screenName, String stage, String status) {
        String deploymentId = DeploymentConfig.getDeploymentId();
        
        String cleanDeployId = deploymentId.replaceAll("[^a-zA-Z0-9\\-]", "");
        String name = cleanDeployId + "_" + screenName + "_" + stage + "_" + status;
        
        if (driver instanceof TakesScreenshot) {
            File srcFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
            String screenshotDir = appProps.getProperty("screenshot.directory", "evidence/screenshots");
            File dir = new File(screenshotDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File destFile = new File(dir, name + "_" + System.currentTimeMillis() + ".png");
            try {
                java.nio.file.Files.copy(srcFile.toPath(), destFile.toPath());
                System.out.println("[SCREENSHOT] Saved classified screenshot to: " + destFile.getAbsolutePath());
                return destFile;
            } catch (Exception e) {
                System.err.println("[SCREENSHOT] Failed to save classified screenshot: " + e.getMessage());
            }
        }
        return null;
    }
}
