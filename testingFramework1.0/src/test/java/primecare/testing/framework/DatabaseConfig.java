package primecare.testing.framework;

import java.io.InputStream;
import java.util.Properties;

public class DatabaseConfig {
    private static final Properties properties = new Properties();

    static {
        try (InputStream in = DatabaseConfig.class.getClassLoader()
                .getResourceAsStream("config/database.properties")) {
            if (in != null) {
                properties.load(in);
            }
        } catch (Exception e) {
            System.err.println("[CONFIG] Failed to load database properties: " + e.getMessage());
        }
    }

    public static String getDbUrl() {
        String url = System.getProperty("db.url");
        if (url == null || url.trim().isEmpty()) {
            url = System.getenv("db_url");
        }
        if (url == null || url.trim().isEmpty()) {
            url = properties.getProperty("db.url");
        }
        if (url == null || url.trim().isEmpty()) {
            java.io.File primaryDb = new java.io.File("c:/Users/Admin2/Documents/GitHub/primecare-platform/.agents/governance/governance.db");
            if (primaryDb.exists()) {
                url = "jdbc:sqlite:" + primaryDb.getAbsolutePath();
            } else {
                java.io.File localDb = new java.io.File("governance.db");
                url = "jdbc:sqlite:" + localDb.getAbsolutePath();
            }
        }
        return url;
    }
}

