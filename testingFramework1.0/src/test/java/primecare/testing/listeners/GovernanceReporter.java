package primecare.testing.listeners;

import primecare.testing.base.BaseTest;
import primecare.testing.framework.SQLiteConnectionManager;
import org.testng.IReporter;
import org.testng.ISuite;
import org.testng.xml.XmlSuite;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.Instant;
import java.util.List;

public class GovernanceReporter implements IReporter {

    @Override
    public void generateReport(List<XmlSuite> xmlSuites, List<ISuite> suites, String outputDirectory) {
        System.out.println("[REPORTER] Generating PrimeCare Governance and Certification reports...");
        
        String reportsDir = "evidence/reports";
        File dir = new File(reportsDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        generateHtmlReport(new File(dir, "governance-report.html"));
        generateJsonReport(new File(dir, "execution-report.json"));
        generateCsvReport(new File(dir, "failures-report.csv"));
        
        System.out.println("[REPORTER] Reports successfully saved in: " + dir.getAbsolutePath());
    }

    private void generateHtmlReport(File file) {
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>\n<html>\n<head>\n")
            .append("<title>PrimeCare 10-Layer Testing & Certification Report</title>\n")
            .append("<style>\n")
            .append("body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f3f4f6; color: #1f2937; margin: 0; padding: 20px; }\n")
            .append(".container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }\n")
            .append("h1 { border-bottom: 2px solid #3b82f6; padding-bottom: 10px; color: #1e3a8a; }\n")
            .append("h2 { color: #2563eb; margin-top: 30px; }\n")
            .append("table { width: 100%; border-collapse: collapse; margin-top: 15px; }\n")
            .append("th, td { border: 1px solid #e5e7eb; padding: 12px; text-align: left; }\n")
            .append("th { background-color: #f9fafb; font-weight: 600; color: #4b5563; }\n")
            .append(".badge { display: inline-block; padding: 4px 8px; border-radius: 9999px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; }\n")
            .append(".badge-passed { background-color: #d1fae5; color: #065f46; }\n")
            .append(".badge-failed { background-color: #fee2e2; color: #991b1b; }\n")
            .append(".badge-blocked { background-color: #fef3c7; color: #92400e; }\n")
            .append(".badge-not-tested { background-color: #e5e7eb; color: #374151; }\n")
            .append(".card { background: #eff6ff; border-left: 4px solid #3b82f6; padding: 15px; margin: 15px 0; border-radius: 4px; }\n")
            .append("</style>\n</head>\n<body>\n")
            .append("<div class='container'>\n")
            .append("<h1>PrimeCare Governance & 10-Layer Certification Report</h1>\n")
            .append("<div class='card'>\n")
            .append("<strong>Execution Context:</strong> ID: ").append(BaseTest.executionId)
            .append(" | UUID: ").append(BaseTest.executionUuid).append("<br/>\n")
            .append("<strong>Generated At:</strong> ").append(Instant.now().toString()).append("\n")
            .append("</div>\n");

        // 1. Suite Execution Summary
        html.append("<h2>Test Executions Summary</h2>\n");
        String execSql = "SELECT * FROM test_executions WHERE execution_id = ?";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(execSql)) {
            pstmt.setInt(1, BaseTest.executionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    html.append("<table>\n<tr><th>Metric</th><th>Value</th></tr>\n")
                        .append("<tr><td>Suite Name</td><td>").append(rs.getString("suite_name")).append("</td></tr>\n")
                        .append("<tr><td>Environment</td><td>").append(rs.getString("environment")).append("</td></tr>\n")
                        .append("<tr><td>Total Tests</td><td>").append(rs.getInt("total_tests")).append("</td></tr>\n")
                        .append("<tr><td>Passed Tests</td><td>").append(rs.getInt("passed_tests")).append("</td></tr>\n")
                        .append("<tr><td>Failed Tests</td><td>").append(rs.getInt("failed_tests")).append("</td></tr>\n")
                        .append("<tr><td>Skipped/Blocked Tests</td><td>").append(rs.getInt("skipped_tests")).append("</td></tr>\n")
                        .append("<tr><td>Overall Status</td><td><span class='badge ").append(
                            "PASSED".equals(rs.getString("status")) ? "badge-passed" : "badge-failed"
                        ).append("'>").append(rs.getString("status")).append("</span></td></tr>\n")
                        .append("</table>\n");
                }
            }
        } catch (Exception e) {
            html.append("<p>Error loading execution details: ").append(e.getMessage()).append("</p>\n");
        }

        // 2. Screen Layer Status
        html.append("<h2>Screen 10-Layer Certification Grid</h2>\n");
        String gridSql = "SELECT * FROM screen_layer_status";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(gridSql)) {
            html.append("<table>\n<thead>\n<tr><th>Screen Key</th><th>Route</th><th>Layer</th><th>Required</th><th>Status</th><th>Evidence Count</th><th>Open Defects</th></tr>\n</thead>\n<tbody>\n");
            while (rs.next()) {
                String status = rs.getString("status");
                String badgeClass = "badge-not-tested";
                if ("PASSED".equalsIgnoreCase(status)) badgeClass = "badge-passed";
                else if ("FAILED".equalsIgnoreCase(status)) badgeClass = "badge-failed";
                else if ("BLOCKED".equalsIgnoreCase(status)) badgeClass = "badge-blocked";

                html.append("<tr>\n")
                    .append("<td>").append(rs.getString("screen_key")).append("</td>\n")
                    .append("<td>").append(rs.getString("route")).append("</td>\n")
                    .append("<td>").append(rs.getString("layer_code")).append("</td>\n")
                    .append("<td>").append(rs.getInt("required") == 1 ? "YES" : "NO").append("</td>\n")
                    .append("<td><span class='badge ").append(badgeClass).append("'>").append(status).append("</span></td>\n")
                    .append("<td>").append(rs.getInt("evidence_count")).append("</td>\n")
                    .append("<td>").append(rs.getInt("open_defect_count")).append("</td>\n")
                    .append("</tr>\n");
            }
            html.append("</tbody>\n</table>\n");
        } catch (Exception e) {
            html.append("<p>Error loading grid status: ").append(e.getMessage()).append("</p>\n");
        }

        // 3. Open Defects
        html.append("<h2>Open Defects</h2>\n");
        String defectSql = "SELECT * FROM defects WHERE status = 'OPEN'";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(defectSql)) {
            html.append("<table>\n<thead>\n<tr><th>Defect Key</th><th>Severity</th><th>Title</th><th>Description</th><th>Created At</th></tr>\n</thead>\n<tbody>\n");
            boolean hasDefects = false;
            while (rs.next()) {
                hasDefects = true;
                html.append("<tr>\n")
                    .append("<td>").append(rs.getString("defect_key")).append("</td>\n")
                    .append("<td><span class='badge badge-failed'>").append(rs.getString("severity")).append("</span></td>\n")
                    .append("<td>").append(rs.getString("title")).append("</td>\n")
                    .append("<td>").append(rs.getString("description")).append("</td>\n")
                    .append("<td>").append(rs.getString("created_at")).append("</td>\n")
                    .append("</tr>\n");
            }
            if (!hasDefects) {
                html.append("<tr><td colspan='5'>No open defects reported. Clean suite execution!</td></tr>\n");
            }
            html.append("</tbody>\n</table>\n");
        } catch (Exception e) {
            html.append("<p>Error loading defects: ").append(e.getMessage()).append("</p>\n");
        }

        html.append("</div>\n</body>\n</html>\n");

        try (FileWriter writer = new FileWriter(file)) {
            writer.write(html.toString());
        } catch (IOException e) {
            System.err.println("[REPORTER] Failed to write HTML report: " + e.getMessage());
        }
    }

    private void generateJsonReport(File file) {
        StringBuilder json = new StringBuilder();
        json.append("{\n  \"executionId\": ").append(BaseTest.executionId).append(",\n")
            .append("  \"timestamp\": \"").append(Instant.now().toString()).append("\",\n")
            .append("  \"results\": [\n");

        String sql = "SELECT * FROM test_results WHERE execution_id = ?";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, BaseTest.executionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                boolean first = true;
                while (rs.next()) {
                    if (!first) json.append(",\n");
                    first = false;
                    json.append("    {\n")
                        .append("      \"resultId\": ").append(rs.getInt("result_id")).append(",\n")
                        .append("      \"layerId\": ").append(rs.getInt("layer_id")).append(",\n")
                        .append("      \"testClass\": \"").append(rs.getString("test_class")).append("\",\n")
                        .append("      \"testMethod\": \"").append(rs.getString("test_method")).append("\",\n")
                        .append("      \"testCaseKey\": \"").append(rs.getString("test_case_key")).append("\",\n")
                        .append("      \"status\": \"").append(rs.getString("status")).append("\",\n")
                        .append("      \"durationMs\": ").append(rs.getInt("duration_ms")).append("\n")
                        .append("    }");
                }
            }
        } catch (Exception e) {
            json.append("    // Error reading database: ").append(e.getMessage());
        }

        json.append("\n  ]\n}");

        try (FileWriter writer = new FileWriter(file)) {
            writer.write(json.toString());
        } catch (IOException e) {
            System.err.println("[REPORTER] Failed to write JSON report: " + e.getMessage());
        }
    }

    private void generateCsvReport(File file) {
        StringBuilder csv = new StringBuilder();
        csv.append("ResultID,LayerID,TestClass,TestMethod,TestCaseKey,Status,ErrorMessage\n");

        String sql = "SELECT result_id, layer_id, test_class, test_method, test_case_key, status, error_message FROM test_results WHERE execution_id = ? AND status != 'PASSED'";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, BaseTest.executionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String err = rs.getString("error_message");
                    String escapedErr = err != null ? err.replace("\"", "\"\"").replace("\n", " ") : "";
                    csv.append(rs.getInt("result_id")).append(",")
                       .append(rs.getInt("layer_id")).append(",")
                       .append("\"").append(rs.getString("test_class")).append("\",")
                       .append("\"").append(rs.getString("test_method")).append("\",")
                       .append("\"").append(rs.getString("test_case_key")).append("\",")
                       .append("\"").append(rs.getString("status")).append("\",")
                       .append("\"").append(escapedErr).append("\"\n");
                }
            }
        } catch (Exception e) {
            System.err.println("[REPORTER] Error loading CSV data: " + e.getMessage());
        }

        try (FileWriter writer = new FileWriter(file)) {
            writer.write(csv.toString());
        } catch (IOException e) {
            System.err.println("[REPORTER] Failed to write CSV report: " + e.getMessage());
        }
    }
}

