package primecare.testing.framework.database;

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
        if (url == null) {
            url = System.getenv("db_url");
        }
        if (url == null) {
            url = properties.getProperty("db.url", "jdbc:sqlite:governance.db");
        }
        return url;
    }
}
