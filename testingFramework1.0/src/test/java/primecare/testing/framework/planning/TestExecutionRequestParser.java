package primecare.testing.framework.planning;

import primecare.testing.models.TestingLayerCode;

import java.io.InputStream;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

public class TestExecutionRequestParser {

    private static final Properties configProps = new Properties();

    static {
        try (InputStream in = TestExecutionRequestParser.class.getClassLoader()
                .getResourceAsStream("config/application.properties")) {
            if (in != null) {
                configProps.load(in);
            }
        } catch (Exception e) {
            // Ignore
        }
    }

    public static TestExecutionRequest fromSystemProperties() {
        TestExecutionRequest req = new TestExecutionRequest();

        req.applicationKey = getVal("application", "primecare-core");
        req.screenKey = getVal("screen", null);
        
        String screenIdStr = getVal("screenId", null);
        if (screenIdStr != null) {
            req.screenId = Long.parseLong(screenIdStr);
        }

        req.moduleName = getVal("module", null);

        String levelStr = getVal("level", null);
        if (levelStr != null) {
            req.level = parseLevel(levelStr);
        }

        String fromStr = getVal("fromLevel", null);
        if (fromStr != null) {
            req.fromLevel = parseLevel(fromStr);
        }

        String toStr = getVal("toLevel", null);
        if (toStr != null) {
            req.toLevel = parseLevel(toStr);
        }

        String modeStr = getVal("mode", null);
        if (modeStr != null) {
            req.executionMode = ExecutionMode.valueOf(modeStr.toUpperCase().replace("-", "_"));
        }

        req.includeDependencies = Boolean.parseBoolean(getVal("includeDependencies", "true"));
        req.stopOnFailure = Boolean.parseBoolean(getVal("stopOnFailure", "true"));
        req.continueOnFailure = Boolean.parseBoolean(getVal("continueOnFailure", "false"));
        req.globalStopOnFailure = Boolean.parseBoolean(getVal("globalStopOnFailure", "false"));
        req.roleKey = getVal("role", null);
        req.environment = getVal("environment", "test");
        req.dryRun = Boolean.parseBoolean(getVal("dryRun", "false"));

        String strategyStr = getVal("executionStrategy", "screen-first");
        if (strategyStr != null) {
            req.executionStrategy = ExecutionStrategy.valueOf(strategyStr.toUpperCase().replace("-", "_"));
        }

        String layersStr = getVal("layers", null);
        if (layersStr != null) {
            Set<TestingLayerCode> layers = new HashSet<>();
            for (String l : layersStr.split(",")) {
                layers.add(TestingLayerCode.valueOf(l.trim().toUpperCase()));
            }
            req.selectedLayers = layers;
        }

        req.rerunFailedFromExecution = getVal("rerunFailedFromExecution", null);
        req.rerunBlockedFromExecution = getVal("rerunBlockedFromExecution", null);

        // Apply fallback overrides if everything is null
        if (req.screenKey == null && req.screenId == null && req.moduleName == null) {
            req.screenKey = configProps.getProperty("testing.default.screen", "login");
            String defaultLevel = configProps.getProperty("testing.default.level", "1");
            req.level = parseLevel(defaultLevel);
            String defaultMode = configProps.getProperty("testing.default.mode", "exact");
            req.executionMode = ExecutionMode.valueOf(defaultMode.toUpperCase().replace("-", "_"));
        }

        return req;
    }

    private static String getVal(String key, String def) {
        String val = System.getProperty(key);
        if (val == null) {
            val = System.getenv(key);
        }
        if (val == null) {
            val = configProps.getProperty(key);
        }
        return val != null ? val : def;
    }

    private static Integer parseLevel(String val) {
        if (val == null) return null;
        String clean = val.trim().toUpperCase();
        if (clean.startsWith("L")) {
            clean = clean.substring(1);
        }
        return Integer.parseInt(clean);
    }
}
