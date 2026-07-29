package primecare.testing.framework;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

public class DeploymentConfig {
    private static String deploymentId = null;
    private static String deploymentUrl = null;

    public static synchronized String getDeploymentId() {
        if (deploymentId == null) {
            loadProperties();
        }
        return deploymentId;
    }

    public static synchronized String getDeploymentUrl() {
        if (deploymentUrl == null) {
            loadProperties();
        }
        return deploymentUrl;
    }

    private static void loadProperties() {
        Properties props = new Properties();
        try (InputStream in = new FileInputStream("deployment_info.properties")) {
            props.load(in);
            deploymentId = props.getProperty("deployment.id", "unknown");
            deploymentUrl = props.getProperty("deployment.url", "");
        } catch (Exception e) {
            deploymentId = "unknown";
            deploymentUrl = "";
        }
    }
}

