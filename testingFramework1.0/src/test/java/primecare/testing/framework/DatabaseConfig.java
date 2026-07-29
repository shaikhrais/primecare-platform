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
        if (url != null && !url.trim().isEmpty()) return url;

        url = System.getenv("db_url");
        if (url != null && !url.trim().isEmpty()) return url;

        url = properties.getProperty("db.url");
        if (url != null && !url.trim().isEmpty()) return url;

        String[] candidates = new String[]{
            "c:/Users/Admin2/Documents/GitHub/primecare-platform/.agents/governance/governance.db",
            "H:/My Drive/eclipse-workspace/testingFramework1.0/governance.db",
            "testingFramework1.0/governance.db",
            ".agents/governance/governance.db",
            "../.agents/governance/governance.db",
            "governance.db"
        };

        for (String path : candidates) {
            java.io.File file = new java.io.File(path);
            if (file.exists() && file.length() > 100000) {
                return "jdbc:sqlite:" + file.getAbsolutePath();
            }
        }

        return "jdbc:sqlite:governance.db";
    }
}

