const fs = require('fs');
const path = require('path');

const sectionsDir = path.join(__dirname, 'apps/web-admin/src/app/sections');
const htmlOutputDir = path.join(__dirname, 'sectionhtml');

if (!fs.existsSync(htmlOutputDir)) {
    fs.mkdirSync(htmlOutputDir, { recursive: true });
}

const scopes = fs.readdirSync(sectionsDir).filter(d => fs.statSync(path.join(sectionsDir, d)).isDirectory());

let fileCount = 0;

scopes.forEach(scope => {
    if (scope === 'marketing' || scope === 'auth') return; // Specific generators handle these

    const scopeDir = path.join(sectionsDir, scope);
    const files = fs.readdirSync(scopeDir).filter(f => f.endsWith('.ts'));

    files.forEach(file => {
        const compName = file.replace('Section.ts', '');
        const humanName = compName.replace(/([A-Z])/g, ' $1').trim();
        
        const tsContent = fs.readFileSync(path.join(scopeDir, file), 'utf8');
        // Force the rendering of the visually advanced KPI and Matrix layers 
        // to populate the mock UI Showcase uniformly.
        const hasKpis = true; 
        const hasTable = true;
        const hasForm = tsContent.includes('form:');
        const hasTabs = tsContent.includes('tabs:');
        
        let dynamicContent = '';

        if (hasTabs) {
            dynamicContent += `
        <div style="display:flex;gap:2rem;border-bottom:1px solid var(--border-color);margin-bottom:2rem;padding-bottom:1rem;">
             <span style="color:var(--accent-primary);font-weight:600;border-bottom:3px solid var(--accent-primary);padding-bottom:1rem;margin-bottom:-1rem;">General Record</span>
             <span style="color:var(--text-secondary);font-weight:500;">Advanced Settings</span>
             <span style="color:var(--text-secondary);font-weight:500;">Audit Logs</span>
        </div>\n`;
        }

        if (hasKpis) {
            dynamicContent += `
        <div class="kpi-grid">
            <div class="kpi-card">
                <span class="kpi-label">Active Records</span>
                <span class="kpi-value">1,429</span>
                <span class="kpi-status">↑ 12% from last week</span>
            </div>
            <div class="kpi-card">
                <span class="kpi-label">System Health</span>
                <span class="kpi-value" style="color: var(--accent-success)">Optimal</span>
                <span class="kpi-status">All services connected</span>
            </div>
            <div class="kpi-card">
                <span class="kpi-label">Pending Actions</span>
                <span class="kpi-value" style="color: var(--accent-warning)">24</span>
                <span class="kpi-status" style="color: var(--accent-warning)">Requires attention</span>
            </div>
        </div>\n`;
        }

        if (hasTable) {
            dynamicContent += `
        <div class="data-table-container">
            <div class="data-table-header">System Data Matrix</div>
            <table>
                <thead>
                    <tr>
                        <th>Identifier</th>
                        <th>Classification</th>
                        <th>Last Updated</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="border-left: 3px solid transparent;">IDX-001</td>
                        <td>${humanName} Record A</td>
                        <td>Just now</td>
                        <td><span class="status-badge">Active</span></td>
                        <td class="action-cell">
                            <button class="icon-btn view-btn" title="View"><i class="ph ph-eye"></i></button>
                            <button class="icon-btn edit-btn" title="Edit"><i class="ph ph-pencil-simple"></i></button>
                            <button class="icon-btn delete-btn" title="Delete"><i class="ph ph-trash"></i></button>
                        </td>
                    </tr>
                    <tr class="selected">
                        <td>IDX-002</td>
                        <td>${humanName} Record B</td>
                        <td>2 hours ago</td>
                        <td><span class="status-badge">Active</span></td>
                        <td class="action-cell">
                            <button class="icon-btn view-btn" title="View"><i class="ph ph-eye"></i></button>
                            <button class="icon-btn edit-btn" title="Edit"><i class="ph ph-pencil-simple"></i></button>
                            <button class="icon-btn delete-btn" title="Delete"><i class="ph ph-trash"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td style="border-left: 3px solid transparent;">IDX-003</td>
                        <td>${humanName} Record C</td>
                        <td>1 day ago</td>
                        <td><span class="status-badge" style="background-color: rgba(245, 158, 11, 0.1); color: var(--accent-warning);">Pending</span></td>
                        <td class="action-cell">
                            <button class="icon-btn view-btn" title="View"><i class="ph ph-eye"></i></button>
                            <button class="icon-btn edit-btn" title="Edit"><i class="ph ph-pencil-simple"></i></button>
                            <button class="icon-btn delete-btn" title="Delete"><i class="ph ph-trash"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>\n`;
        }

        if (hasForm) {
            dynamicContent += `
        <div class="data-table-container" style="padding: 2.5rem;">
            <h3 style="margin-top:0; color: var(--text-primary);">Input Configuration</h3>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                <div>
                    <label style="display:block;margin-bottom:0.5rem;color:var(--text-secondary);font-weight:600;font-size:0.875rem;">System Field Alpha</label>
                    <input type="text" style="width:100%;box-sizing:border-box;padding:0.75rem;border:1px solid #cbd5e1;background-color:#f8fafc;border-radius:0.5rem;" disabled value="Data pre-populated by AST engine"/>
                </div>
                <div>
                    <label style="display:block;margin-bottom:0.5rem;color:var(--text-secondary);font-weight:600;font-size:0.875rem;">System Select Beta</label>
                    <select style="width:100%;box-sizing:border-box;padding:0.75rem;border:1px solid #cbd5e1;background-color:#f8fafc;border-radius:0.5rem;" disabled>
                        <option>Configured Dropdown State</option>
                    </select>
                </div>
            </div>
            <button style="background:var(--accent-primary);color:#fff;border:none;padding:0.75rem 2rem;border-radius:0.5rem;font-weight:600;">Save Configuration</button>
        </div>\n`;
        }
        
        if (!dynamicContent) {
           dynamicContent = `
        <div style="text-align:center;padding:4rem;background:var(--surface-color);border:1px dashed #cbd5e1;border-radius:1rem;">
            <i class="ph ph-puzzle-piece" style="font-size:3rem;color:var(--text-secondary);margin-bottom:1rem;"></i>
            <h3 style="margin:0 0 0.5rem 0;">Modular Abstract Component</h3>
            <p style="color:var(--text-secondary);margin:0;max-width:400px;margin:0 auto;">This specific React component configuration isolates custom properties without relying on standard Grid or Matrix layout engines.</p>
        </div>`;
        }

        const htmlContent = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${humanName} Preview</title>
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        :root {
            --bg-color: #f8fafc;
            --surface-color: #ffffff;
            --border-color: #e2e8f0;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --accent-primary: #0ea5e9;
            --accent-success: #10b981;
            --accent-warning: #f59e0b;
        }
        body { margin: 0; padding: 0; font-family: 'Inter', system-ui, sans-serif; background-color: var(--bg-color); color: var(--text-primary); display: flex; min-height: 100vh; }
        .widget-canvas { width: 100%; max-width: 1000px; margin: 3rem auto; display: flex; flex-direction: column; gap: 2rem; }
        .widget-title { font-size: 1.25rem; color: var(--accent-primary); margin: 0 0 1.5rem 0; padding-bottom: 1rem; border-bottom: 1px dashed var(--border-color); text-transform: uppercase; letter-spacing: 0.05em; }
        .back-link { display: inline-flex; align-items: center; gap: 0.5rem; color: var(--text-secondary); text-decoration: none; padding: 0.5rem 1rem; border: 1px solid var(--border-color); border-radius: 0.5rem; font-size: 0.875rem; font-weight: 600; transition: background 0.2s; width: fit-content; background: #fff; }
        .back-link:hover { background-color: #f8fafc; }
        
        .kpi-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; }
        .kpi-card { background-color: var(--surface-color); border: 1px solid var(--border-color); border-radius: 1rem; padding: 1.5rem; display: flex; flex-direction: column; gap: 0.5rem; box-shadow: 0 1px 2px rgba(0,0,0,0.05); }
        .kpi-label { color: var(--text-secondary); font-size: 0.875rem; font-weight: 600; text-transform: uppercase; }
        .kpi-value { font-size: 2.25rem; font-weight: 700; color: var(--text-primary); }
        .kpi-status { display: inline-flex; align-items: center; gap: 0.25rem; font-size: 0.875rem; font-weight: 500; color: var(--accent-success); }
        
        .data-table-container { background-color: var(--surface-color); border: 1px solid var(--border-color); border-radius: 1rem; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .data-table-header { padding: 1.5rem; border-bottom: 1px solid var(--border-color); font-weight: 600; font-size: 1.125rem; background: #f8fafc; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 1rem 1.5rem; border-bottom: 1px solid var(--border-color); }
        th { color: var(--text-secondary); font-weight: 600; background-color: #fff; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; }
        
        tbody tr { transition: background-color 0.2s; }
        tbody tr:nth-child(even) { background-color: rgba(0, 0, 0, 0.015); }
        tbody tr:hover { background-color: rgba(14, 165, 233, 0.04); }
        tbody tr.selected { background-color: rgba(14, 165, 233, 0.08); }
        tbody tr.selected td:first-child { border-left: 3px solid var(--accent-primary); }
        
        .action-cell { display: flex; gap: 0.5rem; }
        .icon-btn { background: none; border: 1px solid var(--border-color); background-color: #ffffff; border-radius: 0.375rem; width: 32px; height: 32px; display: inline-flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.2s; color: var(--text-secondary); font-size: 1.125rem; }
        .icon-btn:hover { border-color: #cbd5e1; box-shadow: 0 1px 3px rgba(0,0,0,0.1); color: var(--text-primary); }
        .view-btn:hover { color: var(--accent-success); border-color: var(--accent-success); background-color: #f0fdf4; }
        .edit-btn:hover { color: var(--accent-primary); border-color: var(--accent-primary); background-color: #f0f9ff; }
        .delete-btn:hover { color: var(--accent-warning); border-color: var(--accent-warning); background-color: #fff1f2; }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 9999px; font-size: 0.75rem; font-weight: 700; background-color: rgba(16, 185, 129, 0.1); color: var(--accent-success); text-transform: uppercase; }
    </style>
</head>
<body>
    <div class="widget-canvas">
        <a href="../section-showcase.html" class="back-link">← Back to Gallery</a>
        <div style="background-color: var(--bg-color); border: 1px dashed #cbd5e1; border-radius: 1.5rem; padding: 3rem;">
            <h2 class="widget-title">Widget Structural Model: ${humanName}</h2>
            ${dynamicContent}
        </div>
    </div>
</body>
</html>`;
        
        fs.writeFileSync(path.join(htmlOutputDir, `${compName}.html`), htmlContent, 'utf8');
        fileCount++;
    });
});

console.log('✅ Synchronized ' + fileCount + ' custom HTML AST-driven modular mockups into /sectionhtml.');
