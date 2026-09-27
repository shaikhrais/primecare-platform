package base;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public final class TestNGHtmlReportWriter {

    private static final List<VerificationResult> RESULTS = new ArrayList<>();
    private static final List<ComponentVerificationResult> COMPONENT_RESULTS = new ArrayList<>();

    private TestNGHtmlReportWriter() {}

    public static synchronized void addResult(VerificationResult result) {
        RESULTS.add(result);
    }

    public static synchronized void addComponentResult(ComponentVerificationResult result) {
        COMPONENT_RESULTS.add(result);
    }

    public static synchronized String generateDashboardReport(String outputDirectory) {
        File dir = new File(outputDirectory);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        int total = RESULTS.size();
        int passed = 0;
        int failed = 0;
        int skipped = 0;
        long totalDurationMs = 0;

        for (VerificationResult r : RESULTS) {
            String status = r.getTestStatus() != null ? r.getTestStatus().toUpperCase() : "FAILED";
            if (status.contains("PASS") || status.contains("SUCCESS")) {
                passed++;
            } else if (status.contains("SKIP")) {
                skipped++;
            } else {
                failed++;
            }
            totalDurationMs += r.getExecutionTimeMs();
        }

        double passRate = total > 0 ? ((double) passed / total) * 100.0 : 0.0;
        String formattedPassRate = String.format("%.1f", passRate);
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>\n")
            .append("<html lang=\"en\">\n")
            .append("<head>\n")
            .append("  <meta charset=\"UTF-8\">\n")
            .append("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n")
            .append("  <title>PrimeCare - Executive Test Verification Dashboard</title>\n")
            .append("  <link href=\"https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap\" rel=\"stylesheet\">\n")
            .append("  <style>\n")
            .append("    :root { --bg-dark: #0f172a; --card-bg: #1e293b; --accent-blue: #38bdf8; --success-green: #22c55e; --fail-red: #ef4444; --warn-amber: #f59e0b; --text-light: #f8fafc; --text-muted: #94a3b8; --border-color: #334155; }\n")
            .append("    * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }\n")
            .append("    body { background-color: var(--bg-dark); color: var(--text-light); padding: 2rem; }\n")
            .append("    .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid var(--border-color); padding-bottom: 1rem; }\n")
            .append("    .header h1 { font-size: 1.75rem; font-weight: 700; background: linear-gradient(90deg, #38bdf8, #818cf8); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }\n")
            .append("    .header .timestamp { color: var(--text-muted); font-size: 0.875rem; }\n")
            .append("    .kpi-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.25rem; margin-bottom: 2rem; }\n")
            .append("    .kpi-card { background: var(--card-bg); padding: 1.25rem; border-radius: 0.75rem; border: 1px solid var(--border-color); display: flex; flex-direction: column; justify-content: space-between; }\n")
            .append("    .kpi-title { font-size: 0.875rem; color: var(--text-muted); font-weight: 500; margin-bottom: 0.5rem; }\n")
            .append("    .kpi-value { font-size: 2rem; font-weight: 700; }\n")
            .append("    .kpi-card.passed .kpi-value { color: var(--success-green); }\n")
            .append("    .kpi-card.failed .kpi-value { color: var(--fail-red); }\n")
            .append("    .kpi-card.skipped .kpi-value { color: var(--warn-amber); }\n")
            .append("    .kpi-card.rate .kpi-value { color: var(--accent-blue); }\n")
            .append("    .controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; gap: 1rem; }\n")
            .append("    .btn-group { display: flex; gap: 0.5rem; }\n")
            .append("    .btn { background: var(--card-bg); border: 1px solid var(--border-color); color: var(--text-light); padding: 0.5rem 1rem; border-radius: 0.5rem; cursor: pointer; font-size: 0.875rem; font-weight: 500; transition: all 0.2s; }\n")
            .append("    .btn:hover, .btn.active { background: var(--accent-blue); color: #000; border-color: var(--accent-blue); }\n")
            .append("    .search-input { background: var(--card-bg); border: 1px solid var(--border-color); color: var(--text-light); padding: 0.5rem 1rem; border-radius: 0.5rem; font-size: 0.875rem; width: 300px; }\n")
            .append("    .search-input:focus { outline: none; border-color: var(--accent-blue); }\n")
            .append("    .table-container { background: var(--card-bg); border-radius: 0.75rem; border: 1px solid var(--border-color); overflow: hidden; }\n")
            .append("    table { width: 100%; border-collapse: collapse; text-align: left; font-size: 0.875rem; }\n")
            .append("    th { background-color: #0f172a; color: var(--text-muted); padding: 0.875rem 1rem; font-weight: 600; border-bottom: 1px solid var(--border-color); }\n")
            .append("    td { padding: 0.875rem 1rem; border-bottom: 1px solid var(--border-color); color: var(--text-light); }\n")
            .append("    tr:last-child td { border-bottom: none; }\n")
            .append("    tr:hover { background-color: rgba(255, 255, 255, 0.02); }\n")
            .append("    .badge { padding: 0.25rem 0.625rem; border-radius: 9999px; font-size: 0.75rem; font-weight: 600; display: inline-block; }\n")
            .append("    .badge.pass { background: rgba(34, 197, 94, 0.15); color: var(--success-green); border: 1px solid var(--success-green); }\n")
            .append("    .badge.fail { background: rgba(239, 68, 68, 0.15); color: var(--fail-red); border: 1px solid var(--fail-red); }\n")
            .append("    .badge.skip { background: rgba(245, 158, 11, 0.15); color: var(--warn-amber); border: 1px solid var(--warn-amber); }\n")
            .append("  </style>\n")
            .append("</head>\n")
            .append("<body>\n")
            .append("  <div class=\"header\">\n")
            .append("    <div>\n")
            .append("      <h1>PrimeCare Platform - Executive Verification Dashboard</h1>\n")
            .append("      <p style=\"color:var(--text-muted); font-size:0.875rem; margin-top:0.25rem;\">Automated Test Execution & DOM Compliance Verification Report</p>\n")
            .append("    </div>\n")
            .append("    <div class=\"timestamp\">Generated: ").append(timestamp).append("</div>\n")
            .append("  </div>\n")
            .append("  <div class=\"kpi-grid\">\n")
            .append("    <div class=\"kpi-card\">\n")
            .append("      <div class=\"kpi-title\">TOTAL VERIFIED</div>\n")
            .append("      <div class=\"kpi-value\">").append(total).append("</div>\n")
            .append("    </div>\n")
            .append("    <div class=\"kpi-card passed\">\n")
            .append("      <div class=\"kpi-title\">PASSED</div>\n")
            .append("      <div class=\"kpi-value\">").append(passed).append("</div>\n")
            .append("    </div>\n")
            .append("    <div class=\"kpi-card failed\">\n")
            .append("      <div class=\"kpi-title\">FAILED</div>\n")
            .append("      <div class=\"kpi-value\">").append(failed).append("</div>\n")
            .append("    </div>\n")
            .append("    <div class=\"kpi-card skipped\">\n")
            .append("      <div class=\"kpi-title\">SKIPPED</div>\n")
            .append("      <div class=\"kpi-value\">").append(skipped).append("</div>\n")
            .append("    </div>\n")
            .append("    <div class=\"kpi-card rate\">\n")
            .append("      <div class=\"kpi-title\">PASS RATE</div>\n")
            .append("      <div class=\"kpi-value\">").append(formattedPassRate).append("%</div>\n")
            .append("    </div>\n")
            .append("  </div>\n")
            .append("  <div class=\"controls\">\n")
            .append("    <div class=\"btn-group\">\n")
            .append("      <button class=\"btn active\" onclick=\"filterStatus('all')\">All (").append(total).append(")</button>\n")
            .append("      <button class=\"btn\" onclick=\"filterStatus('PASS')\">Passed (").append(passed).append(")</button>\n")
            .append("      <button class=\"btn\" onclick=\"filterStatus('FAIL')\">Failed (").append(failed).append(")</button>\n")
            .append("    </div>\n")
            .append("    <input type=\"text\" id=\"searchInput\" class=\"search-input\" placeholder=\"Search by screen or route...\" onkeyup=\"searchTable()\">\n")
            .append("  </div>\n")
            .append("  <div class=\"table-container\">\n")
            .append("    <table id=\"resultsTable\">\n")
            .append("      <thead>\n")
            .append("        <tr>\n")
            .append("          <th>Screen ID</th>\n")
            .append("          <th>Test Method</th>\n")
            .append("          <th>Expected Page</th>\n")
            .append("          <th>Route</th>\n")
            .append("          <th>Duration</th>\n")
            .append("          <th>Status</th>\n")
            .append("          <th>Details / Message</th>\n")
            .append("        </tr>\n")
            .append("      </thead>\n")
            .append("      <tbody>\n");

        for (VerificationResult r : RESULTS) {
            String statusStr = r.getTestStatus() != null ? r.getTestStatus().toUpperCase() : "FAIL";
            String badgeClass = statusStr.contains("PASS") ? "pass" : (statusStr.contains("SKIP") ? "skip" : "fail");
            String failureMsg = r.getFailureMessage() != null ? r.getFailureMessage().replace("<", "&lt;").replace(">", "&gt;") : "OK";

            html.append("        <tr class=\"test-row\" data-status=\"").append(badgeClass.toUpperCase()).append("\">\n")
                .append("          <td>").append(r.getScreenId()).append("</td>\n")
                .append("          <td><strong>").append(r.getTestMethod() != null ? r.getTestMethod() : "verifyScreen").append("</strong></td>\n")
                .append("          <td>").append(r.getExpectedPage() != null ? r.getExpectedPage() : "-").append("</td>\n")
                .append("          <td><code>").append(r.getExpectedRoute() != null ? r.getExpectedRoute() : "/").append("</code></td>\n")
                .append("          <td>").append(r.getExecutionTimeMs()).append(" ms</td>\n")
                .append("          <td><span class=\"badge ").append(badgeClass).append("\">").append(statusStr).append("</span></td>\n")
                .append("          <td style=\"color:var(--text-muted);\">").append(failureMsg).append("</td>\n")
                .append("        </tr>\n");
        }

        html.append("      </tbody>\n")
            .append("    </table>\n")
            .append("  </div>\n")
            .append("  <script>\n")
            .append("    function filterStatus(status) {\n")
            .append("      const rows = document.querySelectorAll('.test-row');\n")
            .append("      rows.forEach(row => {\n")
            .append("        if (status === 'all' || row.getAttribute('data-status').includes(status)) {\n")
            .append("          row.style.display = '';\n")
            .append("        } else {\n")
            .append("          row.style.display = 'none';\n")
            .append("        }\n")
            .append("      });\n")
            .append("    }\n")
            .append("    function searchTable() {\n")
            .append("      const query = document.getElementById('searchInput').value.toLowerCase();\n")
            .append("      const rows = document.querySelectorAll('.test-row');\n")
            .append("      rows.forEach(row => {\n")
            .append("        const text = row.innerText.toLowerCase();\n")
            .append("        row.style.display = text.includes(query) ? '' : 'none';\n")
            .append("      });\n")
            .append("    }\n")
            .append("  </script>\n")
            .append("</body>\n")
            .append("</html>\n");

        File reportFile = new File(dir, "PrimeCare_Executive_Dashboard.html");
        try (FileWriter writer = new FileWriter(reportFile)) {
            writer.write(html.toString());
            System.out.println("[HTML DASHBOARD] Generated Executive Report: " + reportFile.getAbsolutePath());
            return reportFile.getAbsolutePath();
        } catch (IOException e) {
            System.err.println("[HTML DASHBOARD] Error writing dashboard: " + e.getMessage());
            return null;
        }
    }
}
