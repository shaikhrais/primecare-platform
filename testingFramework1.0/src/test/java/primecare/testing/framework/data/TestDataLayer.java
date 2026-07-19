package primecare.testing.framework.data;

import primecare.testing.framework.database.SQLiteConnectionManager;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class TestDataLayer {
    private static final Map<String, String> cache = new HashMap<>();

    public static synchronized void initialize() {
        System.out.println("[DATA-LAYER] Hydrating test parameters from SQLite database...");
        String sql = "SELECT screen_key, parameter_key, parameter_value FROM screen_test_parameters";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String compositeKey = rs.getString("screen_key") + "." + rs.getString("parameter_key");
                cache.put(compositeKey.toLowerCase(), rs.getString("parameter_value"));
            }
            System.out.println("[DATA-LAYER] Hydrated " + cache.size() + " parameters successfully.");
        } catch (SQLException e) {
            System.err.println("[DATA-LAYER] Error loading test parameters: " + e.getMessage());
        }
    }

    public static String getParameter(String screenKey, String parameterKey, String defaultValue) {
        String val = cache.get((screenKey + "." + parameterKey).toLowerCase());
        return val != null ? val : defaultValue;
    }

    public static String getParameter(String screenKey, String parameterKey) {
        return getParameter(screenKey, parameterKey, null);
    }
}
