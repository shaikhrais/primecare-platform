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

    public static String mapAppCodeToBaseUrl(String appCode) {
        if (appCode == null) return "https://primecare-clinic.pages.dev";
        String code = appCode.toLowerCase();
        if (code.equals("au") || code.contains("auth")) {
            return "https://primecare-auth.pages.dev";
        }
        if (code.equals("wa") || code.contains("admin")) {
            return "https://primecare-admin.pages.dev";
        }
        if (code.equals("cl") || code.equals("ca") || code.contains("client")) {
            return "https://primecare-client.pages.dev";
        }
        return "https://primecare-clinic.pages.dev";
    }

    public static String getBaseUrlForRoute(String route) {
        String dbUrl = getDbUrl();
        String cleanRoute = route != null ? route.split("\\?")[0] : "";
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(dbUrl)) {
            String sql = "SELECT a.app_code FROM screens s JOIN apps a ON s.app_id = a.id WHERE s.route_path = ? OR s.route_path = ? LIMIT 1";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, route);
                pstmt.setString(2, cleanRoute);
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String appCode = rs.getString("app_code");
                        return mapAppCodeToBaseUrl(appCode);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[DB BASE URL RESOLVER] Error querying governance.db: " + e.getMessage());
        }
        return "https://primecare-clinic.pages.dev";
    }

    public static String getAuthUrl() {
        String dbUrl = getDbUrl();
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(dbUrl)) {
            String sql = "SELECT app_code FROM apps WHERE app_code = 'au' OR app_name LIKE '%auth%' LIMIT 1";
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery(sql)) {
                if (rs.next()) {
                    String appCode = rs.getString("app_code");
                    return mapAppCodeToBaseUrl(appCode);
                }
            }
        } catch (Exception e) {
            System.err.println("[DB AUTH URL RESOLVER] Error querying governance.db: " + e.getMessage());
        }
        return "https://primecare-auth.pages.dev";
    }

    public static String ensureSemanticsUrl(String url) {
        if (url == null || url.trim().isEmpty()) return url;
        if (url.contains("enable-semantics=true")) return url;
        return url + (url.contains("?") ? "&" : "?") + "enable-semantics=true";
    }
}

