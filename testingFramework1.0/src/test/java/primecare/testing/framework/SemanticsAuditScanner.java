package primecare.testing.framework;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;

public class SemanticsAuditScanner {

    public static class SemanticsAuditResult {
        public String screenKey;
        public String route;
        public int totalElements;
        public int semanticElements;
        public int dataCyElements;
        public double complianceScore;
        public List<String> missingElements;

        public SemanticsAuditResult(String screenKey, String route) {
            this.screenKey = screenKey;
            this.route = route;
            this.missingElements = new ArrayList<>();
        }
    }

    public static SemanticsAuditResult auditCurrentScreen(WebDriver driver, String screenKey, String route) {
        SemanticsAuditResult result = new SemanticsAuditResult(screenKey, route);
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            
            Long total = (Long) js.executeScript(
                "return document.querySelectorAll('button, input, select, textarea, a, [role=\"button\"]').length;"
            );
            Long semantics = (Long) js.executeScript(
                "return document.querySelectorAll('[aria-label]').length;"
            );
            Long dataCy = (Long) js.executeScript(
                "return document.querySelectorAll('[data-cy]').length;"
            );

            result.totalElements = total != null ? total.intValue() : 0;
            result.semanticElements = semantics != null ? semantics.intValue() : 0;
            result.dataCyElements = dataCy != null ? dataCy.intValue() : 0;

            int compliant = Math.max(result.semanticElements, result.dataCyElements);
            result.complianceScore = result.totalElements > 0 ? ((double) compliant / result.totalElements) * 100.0 : 100.0;

        } catch (Exception e) {
            result.complianceScore = 0.0;
        }
        return result;
    }

    public static void generateAuditReport(List<SemanticsAuditResult> results, String outputFilePath) {
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'><title>Semantics & Accessibility Audit Report</title>")
            .append("<style>body{font-family:sans-serif;background:#0f172a;color:#f8fafc;padding:2rem;} h1{color:#38bdf8;} table{width:100%;border-collapse:collapse;margin-top:1rem;} th,td{padding:0.75rem;border:1px solid #334155;text-align:left;} th{background:#1e293b;}</style></head><body>")
            .append("<h1>PrimeCare Platform - Semantics & WCAG 2.2 Compliance Audit</h1>")
            .append("<p>Enforces Rule 21 & Rule 22 Accessibility standards across all screens.</p>")
            .append("<table><thead><tr><th>Screen</th><th>Route</th><th>Total Interactive</th><th>ARIA Labels</th><th>data-cy Tags</th><th>Compliance %</th></tr></thead><tbody>");

        for (SemanticsAuditResult r : results) {
            String color = r.complianceScore >= 80 ? "#22c55e" : (r.complianceScore >= 50 ? "#f59e0b" : "#ef4444");
            html.append("<tr><td><strong>").append(r.screenKey).append("</strong></td>")
                .append("<td><code>").append(r.route).append("</code></td>")
                .append("<td>").append(r.totalElements).append("</td>")
                .append("<td>").append(r.semanticElements).append("</td>")
                .append("<td>").append(r.dataCyElements).append("</td>")
                .append("<td style='color:").append(color).append(";font-weight:bold;'>").append(String.format("%.1f", r.complianceScore)).append("%</td></tr>");
        }
        html.append("</tbody></table></body></html>");

        try {
            File outFile = new File(outputFilePath);
            if (outFile.getParentFile() != null) outFile.getParentFile().mkdirs();
            try (FileWriter w = new FileWriter(outFile)) {
                w.write(html.toString());
                System.out.println("[AUDIT] Generated Semantics Compliance Report: " + outFile.getAbsolutePath());
            }
        } catch (Exception e) {
            System.err.println("[AUDIT] Failed to write report: " + e.getMessage());
        }
    }
}
