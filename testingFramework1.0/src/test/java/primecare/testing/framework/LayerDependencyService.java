package primecare.testing.framework;

import primecare.testing.models.TestingLayerCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LayerDependencyService {

    public static class DependencyResult {
        public final boolean isExecutable;
        public final Integer blockingResultId;
        public final String reason;

        public DependencyResult(boolean isExecutable, Integer blockingResultId, String reason) {
            this.isExecutable = isExecutable;
            this.blockingResultId = blockingResultId;
            this.reason = reason;
        }
    }

    public static DependencyResult checkDependency(int executionId, int layerId, Integer screenId, Integer endpointId, Integer workflowId) {
        if (layerId == 1) {
            return new DependencyResult(true, null, "L1 has no dependencies.");
        }

        int predecessorLayerId = layerId - 1;

        String sql = "SELECT result_id, status FROM test_results WHERE execution_id = ? AND layer_id = ? " +
                     "AND (screen_id = ? OR (? IS NULL AND screen_id IS NULL)) " +
                     "AND (endpoint_id = ? OR (? IS NULL AND endpoint_id IS NULL)) " +
                     "AND (workflow_id = ? OR (? IS NULL AND workflow_id IS NULL)) " +
                     "ORDER BY result_id DESC LIMIT 1";

        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, executionId);
            pstmt.setInt(2, predecessorLayerId);
            if (screenId != null) {
                pstmt.setInt(3, screenId);
                pstmt.setInt(4, screenId);
            } else {
                pstmt.setNull(3, java.sql.Types.INTEGER);
                pstmt.setNull(4, java.sql.Types.INTEGER);
            }
            if (endpointId != null) {
                pstmt.setInt(5, endpointId);
                pstmt.setInt(6, endpointId);
            } else {
                pstmt.setNull(5, java.sql.Types.INTEGER);
                pstmt.setNull(6, java.sql.Types.INTEGER);
            }
            if (workflowId != null) {
                pstmt.setInt(7, workflowId);
                pstmt.setInt(8, workflowId);
            } else {
                pstmt.setNull(7, java.sql.Types.INTEGER);
                pstmt.setNull(8, java.sql.Types.INTEGER);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int resultId = rs.getInt("result_id");
                    String status = rs.getString("status");
                    if ("PASSED".equalsIgnoreCase(status)) {
                        return new DependencyResult(true, null, "Predecessor layer passed.");
                    } else {
                        return new DependencyResult(false, resultId, "Predecessor layer status is " + status + " (Result ID: " + resultId + ")");
                    }
                } else {
                    if (screenId != null && isLayerRequiredForScreen(screenId, predecessorLayerId)) {
                        return new DependencyResult(false, null, "Required predecessor layer L" + predecessorLayerId + " has not been executed yet.");
                    }
                    return new DependencyResult(true, null, "Predecessor layer is not executed but not strictly required.");
                }
            }
        } catch (SQLException e) {
            System.err.println("[DEPENDENCY] Error checking dependency: " + e.getMessage());
            return new DependencyResult(false, null, "Database error checking dependencies: " + e.getMessage());
        }
    }

    private static boolean isLayerRequiredForScreen(int screenId, int layerId) {
        String sql = "SELECT required FROM screen_layer_requirements WHERE screen_id = ? AND layer_id = ?";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, screenId);
            pstmt.setInt(2, layerId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("required") == 1;
                }
            }
        } catch (SQLException e) {
            System.err.println("[DEPENDENCY] Error checking requirement: " + e.getMessage());
        }
        return false;
    }

    public static boolean checkPredecessors(int screenId, TestingLayerCode targetLayer) {
        if (targetLayer == TestingLayerCode.L1) {
            return true;
        }

        String sql = "SELECT tl.layer_code, vs.status FROM screen_layer_requirements req " +
                     "JOIN testing_layers tl ON tl.layer_id = req.layer_id " +
                     "LEFT JOIN verification_summary vs ON vs.layer_id = req.layer_id AND vs.screen_id = req.screen_id " +
                     "WHERE req.screen_id = ? AND tl.layer_order < ? AND req.required = 1";
        
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, screenId);
            pstmt.setInt(2, targetLayer.ordinal() + 1);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String status = rs.getString("status");
                    if (status == null || !"PASSED".equalsIgnoreCase(status)) {
                        System.out.println("[DEPENDENCY] Blocking execution. Predecessor " + rs.getString("layer_code") + " status is: " + status);
                        return false;
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[DEPENDENCY] Error checking predecessors: " + e.getMessage());
            return false;
        }

        return true;
    }
}

