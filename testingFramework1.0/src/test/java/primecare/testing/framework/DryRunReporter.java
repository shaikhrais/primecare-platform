package primecare.testing.framework;


import java.sql.Connection;
import java.sql.PreparedStatement;

public class DryRunReporter {
    public static void recordDryRun(TestPlan plan) {
        System.out.println("[DRY RUN] Recording dry-run plan status as PREVIEWED...");
        String sql = "UPDATE test_execution_plans SET status = 'PREVIEWED' WHERE plan_uuid = ?";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, plan.planUuid);
            pstmt.executeUpdate();
        } catch (Exception e) {
            System.err.println("[DRY RUN] Failed to update plan status: " + e.getMessage());
        }
        TestPlanConsoleReporter.printPlan(plan);
    }
}

