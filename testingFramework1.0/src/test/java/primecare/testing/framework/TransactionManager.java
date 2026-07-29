package primecare.testing.framework;

import java.sql.Connection;
import java.sql.SQLException;

public class TransactionManager {

    public interface TransactionCallback<T> {
        T doInTransaction(Connection conn) throws SQLException;
    }

    public static <T> T execute(TransactionCallback<T> callback) {
        Connection conn = null;
        boolean originalAutoCommit = true;
        try {
            conn = SQLiteConnectionManager.getConnection();
            originalAutoCommit = conn.getAutoCommit();
            conn.setAutoCommit(false);
            
            T result = callback.doInTransaction(conn);
            
            conn.commit();
            return result;
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.err.println("[DB] Rollback failed: " + ex.getMessage());
                }
            }
            throw new RuntimeException("Transaction failed and was rolled back: " + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(originalAutoCommit);
                } catch (SQLException ex) {
                    // Ignore
                }
            }
        }
    }
}

