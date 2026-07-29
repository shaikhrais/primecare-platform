package primecare.testing.listeners;

import primecare.testing.base.BaseTest;
import primecare.testing.framework.Models.TestExecution;
import primecare.testing.framework.Repositories.ExecutionRepository;
import primecare.testing.framework.SQLiteConnectionManager;
import org.testng.IExecutionListener;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.Instant;

public class ExecutionListener implements IExecutionListener {

    @Override
    public void onExecutionStart() {
        System.out.println("[EXECUTION LISTENER] Suite execution started.");
    }

    @Override
    public void onExecutionFinish() {
        System.out.println("[EXECUTION LISTENER] Suite execution finished. Finalizing results in DB...");
        if (BaseTest.executionId == -1) return;

        // Query database to aggregate counts for the current execution
        int total = 0, passed = 0, failed = 0, skipped = 0;
        String sql = "SELECT status, COUNT(*) FROM test_results WHERE execution_id = ? GROUP BY status";

        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, BaseTest.executionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String status = rs.getString(1);
                    int count = rs.getInt(2);
                    switch (status.toUpperCase()) {
                        case "PASSED":
                            passed += count;
                            break;
                        case "FAILED":
                        case "ERROR":
                            failed += count;
                            break;
                        case "SKIPPED":
                        case "BLOCKED":
                            skipped += count;
                            break;
                    }
                    total += count;
                }
            }
        } catch (Exception e) {
            System.err.println("[EXECUTION LISTENER] Error aggregating execution totals: " + e.getMessage());
        }

        TestExecution exec = new TestExecution();
        exec.executionId = BaseTest.executionId;
        exec.completedAt = Instant.now().toString();
        exec.status = (failed > 0) ? "FAILED" : "PASSED";
        exec.totalTests = total;
        exec.passedTests = passed;
        exec.failedTests = failed;
        exec.skippedTests = skipped;

        ExecutionRepository.updateExecution(exec);
        System.out.println("[EXECUTION LISTENER] Execution final status written to DB: " + exec.status + " (" + passed + "/" + total + " passed)");
    }
}

