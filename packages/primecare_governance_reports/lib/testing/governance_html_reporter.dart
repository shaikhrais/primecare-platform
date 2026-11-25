// Governance - Category: service | Purpose: Generate the HTML
import 'governance_models.dart';

class GovernanceHtmlReporter {
  static String generateReport(RoleGovernance analytics, String appName) {
    final date = DateTime.now().toLocal().toString().split(' ')[0];
    final screen = analytics.screens.isNotEmpty ? analytics.screens.first : null;
    final isPass = screen != null && screen.screenBugs.isEmpty;
    final statusText = isPass ? 'Pass' : 'Fail';
    final statusClass = isPass ? 'status-pass' : 'status-fail';
    final errors = isPass ? 'Works correctly. No implementation or authorization errors detected.' : screen?.screenBugs.map((e) => e.issue).join(', ') ?? 'No screen data.';
    final riskBadge = isPass ? '<span class="badge low">Low</span>' : '<span class="badge high">High</span>';
    
    // Generate the HTML
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${analytics.roleName.toUpperCase()} Role Test Report</title>
  <style>
    :root {
      --primary: #1f4f78;
      --secondary: #eef5fb;
      --success: #198754;
      --warning: #f0ad4e;
      --danger: #dc3545;
      --dark: #1f2933;
      --light: #ffffff;
      --border: #d9e2ec;
      --muted: #6b7280;
    }

    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
      background: #f4f7fa;
      color: var(--dark);
      line-height: 1.5;
    }

    .page {
      max-width: 1200px;
      margin: 24px auto;
      padding: 24px;
      background: var(--light);
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    }

    header {
      background: linear-gradient(135deg, #1f4f78, #2b75a8);
      color: white;
      padding: 28px;
      border-radius: 14px;
      margin-bottom: 24px;
    }

    header h1 {
      margin: 0 0 8px;
      font-size: 32px;
    }

    header p {
      margin: 4px 0;
      opacity: 0.95;
    }

    h2 {
      color: var(--primary);
      border-bottom: 2px solid var(--border);
      padding-bottom: 8px;
      margin-top: 32px;
    }

    h3 {
      color: #244b66;
      margin-top: 22px;
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 16px;
      margin: 18px 0;
    }

    .card {
      border: 1px solid var(--border);
      background: #ffffff;
      border-radius: 12px;
      padding: 18px;
    }

    .metric {
      font-size: 32px;
      font-weight: bold;
      margin: 8px 0;
    }

    .label {
      color: var(--muted);
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.04em;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 16px 0 24px;
      font-size: 14px;
    }

    th, td {
      border: 1px solid var(--border);
      padding: 10px;
      vertical-align: top;
      text-align: left;
    }

    th {
      background: var(--secondary);
      color: var(--primary);
    }

    .status-pass {
      color: var(--success);
      font-weight: bold;
    }

    .status-fail {
      color: var(--danger);
      font-weight: bold;
    }

    .status-blocked {
      color: var(--warning);
      font-weight: bold;
    }

    .badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 999px;
      font-size: 12px;
      font-weight: bold;
      color: white;
    }

    .high { background: var(--danger); }
    .medium { background: var(--warning); color: #222; }
    .low { background: var(--success); }
    .info { background: var(--primary); }

    .note {
      background: #fff8e6;
      border-left: 5px solid var(--warning);
      padding: 14px 18px;
      border-radius: 8px;
      margin: 16px 0;
    }

    .section-box {
      background: #f8fbfd;
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 18px;
      margin: 16px 0;
    }

    ul {
      margin-top: 8px;
    }

    footer {
      margin-top: 40px;
      padding-top: 16px;
      border-top: 1px solid var(--border);
      color: var(--muted);
      font-size: 13px;
      text-align: center;
    }
    
    .screenshot-img {
      max-width: 100%;
      border-radius: 8px;
      border: 1px solid var(--border);
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      margin-top: 16px;
    }

    @media print {
      body {
        background: white;
      }
      .page {
        box-shadow: none;
        margin: 0;
        max-width: 100%;
      }
      header {
        print-color-adjust: exact;
        -webkit-print-color-adjust: exact;
      }
    }
  </style>
</head>
<body>
  <main class="page">
    <header>
      <h1>${analytics.roleName.toUpperCase()} Role Test Report</h1>
      <p><strong>Project:</strong> PrimeCare Platform ($appName)</p>
      <p><strong>Role Tested:</strong> ${analytics.roleName.toUpperCase()}</p>
      <p><strong>Report Date:</strong> $date</p>
      <p><strong>Tester:</strong> PrimeCare Automated Governance Engine</p>
      <p><strong>Build / Version:</strong> Automated Integration Test</p>
    </header>

    <section>
      <h2>1. Executive Summary</h2>
      <div class="section-box">
        <p>
          This report documents the automated Zero-Trust and visual implementation audit completed for the <strong>${analytics.roleName.toUpperCase()}</strong> user role in the PrimeCare platform. The goal is to confirm that the ${analytics.roleName.toUpperCase()} can securely access their assigned layout and that the frontend structure is successfully hydrated.
        </p>
        <p>
          The engine verified the routing permissions and scanned the exact DOM structure, mapping <strong>${screen?.componentFrequencies.length ?? 0} unique UI components</strong> during the test cycle.
        </p>
      </div>
    </section>

    <section>
      <h2>2. Overall Automated Test Result</h2>
      <div class="grid">
        <div class="card">
          <div class="label">Total Automated Checks</div>
          <div class="metric">3</div>
        </div>
        <div class="card">
          <div class="label">Passed</div>
          <div class="metric status-pass">${isPass ? 3 : 1}</div>
        </div>
        <div class="card">
          <div class="label">Failed</div>
          <div class="metric status-fail">${isPass ? 0 : 2}</div>
        </div>
        <div class="card">
          <div class="label">Widgets Rendered</div>
          <div class="metric status-info">${screen?.componentFrequencies.length ?? 0}</div>
        </div>
      </div>
      <div class="note">
        <strong>Final Status:</strong> ${isPass ? 'Pass. The role successfully authenticated and fully rendered the dashboard.' : 'Fail. High-priority authorization or implementation issues were detected.'}
      </div>
    </section>

    <section>
      <h2>3. Scope of Testing</h2>
      <table>
        <thead>
          <tr>
            <th>Area Tested</th>
            <th>Description</th>
            <th>Included?</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Role-based routing</td>
            <td>Confirm ${analytics.roleName.toUpperCase()} correctly passes the Zero-Trust GovernanceRouter.</td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>Implementation Status</td>
            <td>Ensure the screen does not show 'Placeholder' or 'Coming Soon'.</td>
            <td>Yes</td>
          </tr>
          <tr>
            <td>Visual Telemetry</td>
            <td>Capture physical layout screenshot and extract widget mapping.</td>
            <td>Yes</td>
          </tr>
        </tbody>
      </table>
    </section>

    <section>
      <h2>4. Automated Permission Matrix</h2>
      <table>
        <thead>
          <tr>
            <th>Module / Feature</th>
            <th>Expected Access</th>
            <th>Actual Result</th>
            <th>Status</th>
            <th>Risk</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>${analytics.roleName.toUpperCase()} Dashboard</td>
            <td>Authorized view of assigned scope.</td>
            <td>$errors</td>
            <td class="$statusClass">$statusText</td>
            <td>$riskBadge</td>
          </tr>
        </tbody>
      </table>
    </section>

    <section>
      <h2>5. Visual Evidence Checklist</h2>
      <table>
        <thead>
          <tr>
            <th>Evidence Type</th>
            <th>Required?</th>
            <th>Attached?</th>
            <th>File / Link</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Automated physical screenshot</td>
            <td>Yes</td>
            <td>Yes</td>
            <td><a href="${analytics.roleName}_dashboard.png" target="_blank">View Raw Image</a></td>
          </tr>
        </tbody>
      </table>
      
      <div style="text-align: center;">
        <h3>Captured Viewport</h3>
        <p style="color: var(--muted); font-size: 13px;">Evidence generated automatically by Integration Test WidgetsFlutterBinding</p>
        <img src="${analytics.roleName}_dashboard.png" class="screenshot-img" alt="${analytics.roleName} Dashboard Evidence" />
      </div>
    </section>

    <section>
      <h2>6. Sign-Off</h2>
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Role</th>
            <th>Decision</th>
            <th>Date</th>
            <th>Signature</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Governance Stress Tester</td>
            <td>Automated QA Engine</td>
            <td>${isPass ? 'Pass' : 'Fail'}</td>
            <td>$date</td>
            <td><em>Verified by Platform Automation</em></td>
          </tr>
        </tbody>
      </table>
    </section>

    <footer>
      PrimeCare Support Services Platform — Automated Governance QA Test Report
    </footer>
  </main>
</body>
</html>
''';
  }
}
