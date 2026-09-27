package primecare.testing.base;

import primecare.testing.framework.*;
import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import primecare.testing.framework.DatabaseMigrationRunner;
import primecare.testing.framework.DatabaseHealthCheck;
import primecare.testing.framework.Models.TestExecution;
import primecare.testing.framework.Repositories.ExecutionRepository;
import org.testng.annotations.BeforeSuite;

import java.io.InputStream;
import java.time.Instant;
import java.util.Properties;
import java.util.UUID;

public class BaseTest {
    public static final Properties appProps = new Properties();
    protected static final ObjectMapper objectMapper = new ObjectMapper();
    public static int executionId = -1;
    public static String executionUuid;

    @BeforeSuite(alwaysRun = true)
    public void setupSuite() {
        System.out.println("[BASE SUITE] Starting framework initialization...");
        loadProperties();
        
        // Run database migrations
        DatabaseMigrationRunner.runMigrations();
        
        // Hydrate TestDataLayer from database
        primecare.testing.framework.TestDataLayer.initialize();
        
        // Verify database state health
        DatabaseHealthCheck.verifyDatabaseState();

        // Initialize execution log
        executionUuid = UUID.randomUUID().toString();
        TestExecution exec = new TestExecution();
        exec.executionUuid = executionUuid;
        exec.suiteName = "PrimeCare 10-Layer Regression Suite";
        exec.environment = appProps.getProperty("environment", "dev");
        exec.startedAt = Instant.now().toString();
        exec.status = "RUNNING";
        exec.triggeredBy = System.getProperty("user.name", "AI_AGENT");
        exec.gitBranch = System.getProperty("git.branch", "main");
        exec.gitCommit = System.getProperty("git.commit", "HEAD");
        exec.javaVersion = System.getProperty("java.version");
        exec.browserName = appProps.getProperty("browser", "chrome");
        exec.operatingSystem = System.getProperty("os.name");

        ExecutionRepository.insertExecution(exec);
        executionId = exec.executionId;
        System.out.println("[BASE SUITE] Suite Execution Log initialized in DB. Execution ID: " + executionId);
    }

    private void loadProperties() {
        // Load application.properties
        boolean loadedApp = false;
        try (InputStream appInput = BaseTest.class.getClassLoader().getResourceAsStream("config/application.properties")) {
            if (appInput != null) {
                appProps.load(appInput);
                loadedApp = true;
            }
        } catch (Exception e) {}
        if (!loadedApp) {
            java.io.File file = new java.io.File("src/test/resources/config/application.properties");
            if (!file.exists()) {
                file = new java.io.File("testingFramework1.0/src/test/resources/config/application.properties");
            }
            if (file.exists()) {
                try (InputStream in = new java.io.FileInputStream(file)) {
                    appProps.load(in);
                } catch (Exception e) {}
            }
        }

        // Load test.properties
        boolean loadedTest = false;
        try (InputStream testInput = BaseTest.class.getClassLoader().getResourceAsStream("config/test.properties")) {
            if (testInput != null) {
                appProps.load(testInput);
                loadedTest = true;
            }
        } catch (Exception e) {}
        if (!loadedTest) {
            java.io.File file = new java.io.File("src/test/resources/config/test.properties");
            if (!file.exists()) {
                file = new java.io.File("testingFramework1.0/src/test/resources/config/test.properties");
            }
            if (file.exists()) {
                try (InputStream in = new java.io.FileInputStream(file)) {
                    appProps.load(in);
                } catch (Exception e) {}
            }
        }

        // Overwrite properties dynamically via System properties if specified on command line
        for (String key : appProps.stringPropertyNames()) {
            String sysVal = System.getProperty(key);
            if (sysVal != null) {
                appProps.setProperty(key, sysVal);
            }
        }
        
        // Dynamically override login.url if APP_BASE_URL is set as system property
        String baseVal = System.getProperty("APP_BASE_URL");
        if (baseVal != null) {
            appProps.setProperty("login.url", baseVal + "/login");
            appProps.setProperty("APP_BASE_URL", baseVal);
        }
    }
}

