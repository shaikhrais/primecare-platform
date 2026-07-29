package primecare.testing.framework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class SQLiteConnectionManager {

    public static Connection getConnection() throws SQLException {
        String url = DatabaseConfig.getDbUrl();
        Connection connection = DriverManager.getConnection(url);
        
        // Enforce SQLite Foreign Key constraints
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("PRAGMA foreign_keys = ON;");
        }
        return connection;
    }

    public static void closeConnection() {
        // No-op. Connections are managed and closed by callers using try-with-resources.
    }
}

