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

    public static String getBaseUrlForRoute(String route) {
        String dbUrl = getDbUrl();
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(dbUrl)) {
            String sql = "SELECT a.base_url FROM screens s JOIN apps a ON s.app_id = a.app_id WHERE s.route = ? LIMIT 1";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, route);
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String url = rs.getString("base_url");
                        if (url != null && !url.trim().isEmpty()) {
                            return url.endsWith("/") ? url.substring(0, url.length() - 1) : url;
                        }
                    }
                }
            }
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery("SELECT base_url FROM apps WHERE base_url IS NOT NULL AND base_url != '' LIMIT 1")) {
                if (rs.next()) {
                    String url = rs.getString("base_url");
                    if (url != null && !url.trim().isEmpty()) {
                        return url.endsWith("/") ? url.substring(0, url.length() - 1) : url;
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[DB BASE URL RESOLVER] Failed to fetch base_url for route: " + e.getMessage());
        }
        return "https://primecare-clinic.pages.dev";
    }

    public static String getAuthUrl() {
        String dbUrl = getDbUrl();
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(dbUrl)) {
            String sql = "SELECT base_url FROM apps WHERE app_code LIKE '%auth%' OR app_name LIKE '%auth%' OR base_url LIKE '%auth%' LIMIT 1";
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery(sql)) {
                if (rs.next()) {
                    String url = rs.getString("base_url");
                    if (url != null && !url.trim().isEmpty()) {
                        return url.endsWith("/") ? url.substring(0, url.length() - 1) : url;
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[DB AUTH URL RESOLVER] Failed to fetch auth base_url: " + e.getMessage());
        }
        return "https://primecare-auth.pages.dev";
    }
}

