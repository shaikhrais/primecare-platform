const fs = require('fs');
const path = require('path');

const sectionsDir = path.join(__dirname, 'sectionhtml');
const showcaseFile = path.join(__dirname, 'section-showcase.html');

if (!fs.existsSync(sectionsDir)) {
    console.error('Section HTML directory not found.');
    process.exit(1);
}

const files = fs.readdirSync(sectionsDir).filter(f => f.endsWith('.html'));

const groups = {
  "Auth & Identity": [],
  "Marketing & Public Site": [],
  "Daily Work & Operations": [],
  "Reports & Analytics": [],
  "RN & Medical": [],
  "PSW & Caregivers": [],
  "Manager & Coordinator": [],
  "Admin & Finance": [],
  "Client & Family": [],
  "Platform & Developers": [],
  "General": []
};

files.forEach(file => {
    const plainName = file.replace('.html', '').replace(/([A-Z])/g, ' $1').trim();
    const lcName = file.toLowerCase();
    
    if (lcName.includes('login') || lcName.includes('register') || lcName.includes('password') || lcName.includes('auth') || lcName.includes('identity')) {
        groups["Auth & Identity"].push({file, plainName});
    } else if (lcName.includes('hero') || lcName.includes('social') || lcName.includes('faq') || lcName.includes('pricing') || lcName.includes('cta') || lcName.includes('footer') || lcName.includes('marketing') || lcName.includes('team') || lcName.includes('contact') || lcName.includes('howitworks') || lcName.includes('feature')) {
        groups["Marketing & Public Site"].push({file, plainName});
    } else if (lcName.includes('daily') || lcName.includes('visit') || lcName.includes('task') || lcName.includes('entry') || lcName.includes('shift') || lcName.includes('checkin') || lcName.includes('booking')) {
        groups["Daily Work & Operations"].push({file, plainName});
    } else if (lcName.includes('report') || lcName.includes('analytic') || lcName.includes('audit') || lcName.includes('insight') || lcName.includes('stats') || lcName.includes('matrix')) {
        groups["Reports & Analytics"].push({file, plainName});
    } else if (lcName.includes('rn') || lcName.includes('mar') || lcName.includes('wound') || lcName.includes('rai') || lcName.includes('medical') || lcName.includes('treatment') || lcName.includes('clinical') || lcName.includes('physician') || lcName.includes('pharmacy') || lcName.includes('careplan') || lcName.includes('assessment')) {
        groups["RN & Medical"].push({file, plainName});
    } else if (lcName.includes('psw') || lcName.includes('caregiver')) {
        groups["PSW & Caregivers"].push({file, plainName});
    } else if (lcName.includes('manager') || lcName.includes('coordinator') || lcName.includes('dispatch') || lcName.includes('schedule') || lcName.includes('logistics') || lcName.includes('waitlist') || lcName.includes('fleet') || lcName.includes('operations')) {
        groups["Manager & Coordinator"].push({file, plainName});
    } else if (lcName.includes('admin') || lcName.includes('payroll') || lcName.includes('finance') || lcName.includes('compliance') || lcName.includes('policy') || lcName.includes('revenue') || lcName.includes('security') || lcName.includes('system') || lcName.includes('settings') || lcName.includes('billing') || lcName.includes('invoice') || lcName.includes('tax') || lcName.includes('franchise') || lcName.includes('governance')) {
        groups["Admin & Finance"].push({file, plainName});
    } else if (lcName.includes('client') || lcName.includes('family') || lcName.includes('customer')) {
        groups["Client & Family"].push({file, plainName});
    } else if (lcName.includes('dev') || lcName.includes('api') || lcName.includes('webhook') || lcName.includes('scrum') || lcName.includes('registry') || lcName.includes('test') || lcName.includes('ab') || lcName.includes('script') || lcName.includes('bot') || lcName.includes('error')) {
        groups["Platform & Developers"].push({file, plainName});
    } else {
        groups["General"].push({file, plainName});
    }
});

function getIconData(name, group) {
    const l = name.toLowerCase();
    
    // Default blue
    let icon = 'ph-codesandbox-logo';
    let color = '#0ea5e9'; 
    let bg = '#f0f9ff';

    // Group Color Taxonomy
    if (group.includes('RN')) { color = '#ef4444'; bg = '#fef2f2'; } // Red
    else if (group.includes('PSW')) { color = '#f97316'; bg = '#fff7ed'; } // Orange
    else if (group.includes('Manager')) { color = '#d946ef'; bg = '#fdf4ff'; } // Fuchsia
    else if (group.includes('Admin')) { color = '#10b981'; bg = '#ecfdf5'; } // Emerald
    else if (group.includes('Marketing')) { color = '#8b5cf6'; bg = '#f5f3ff'; } // Violet
    else if (group.includes('Auth')) { color = '#f43f5e'; bg = '#fff1f2'; } // Rose
    
    // Icon Semantics
    if (l.includes('home')) icon = 'ph-squares-four';
    else if (l.includes('social') || l.includes('facebook') || l.includes('insta')) icon = 'ph-share-network';
    else if (l.includes('report') || l.includes('analytic') || l.includes('metric') || l.includes('insight')) icon = 'ph-chart-bar';
    else if (l.includes('setting') || l.includes('config') || l.includes('preference')) icon = 'ph-gear-six';
    else if (l.includes('user') || l.includes('profile') || l.includes('client') || l.includes('patient')) icon = 'ph-user-circle';
    else if (l.includes('list') || l.includes('table') || l.includes('log')) icon = 'ph-list-dashes';
    else if (l.includes('form') || l.includes('entry') || l.includes('create') || l.includes('edit')) icon = 'ph-pencil-line';
    else if (l.includes('login') || l.includes('auth') || l.includes('password') || l.includes('security')) icon = 'ph-lock-key';
    else if (l.includes('calendar') || l.includes('schedule') || l.includes('shift') || l.includes('visit') || l.includes('booking')) icon = 'ph-calendar-blank';
    else if (l.includes('message') || l.includes('chat') || l.includes('mail') || l.includes('inbox')) icon = 'ph-chats';
    else if (l.includes('file') || l.includes('document') || l.includes('policy')) icon = 'ph-file-text';
    else if (l.includes('invoice') || l.includes('billing') || l.includes('payroll') || l.includes('finance') || l.includes('tax')) icon = 'ph-receipt';
    else if (l.includes('map') || l.includes('location') || l.includes('fleet') || l.includes('dispatch')) icon = 'ph-map-pin';
    else if (group.includes('RN')) icon = 'ph-heartbeat';
    else if (group.includes('PSW')) icon = 'ph-users';
    else if (group.includes('Manager')) icon = 'ph-briefcase';
    else if (group.includes('Admin')) icon = 'ph-bank';
    else if (group.includes('Marketing')) icon = 'ph-megaphone';

    return { icon, color, bg };
}

let sidebarHtml = '';
let contentHtml = '';
let groupIndex = 0;

Object.entries(groups).forEach(([groupName, items]) => {
    if (items.length > 0) {
        const groupId = `group-${groupIndex}`;
        sidebarHtml += `        <a href="#${groupId}" class="sidebar-item"><span>${groupName}</span> <span class="badge">${items.length}</span></a>\n`;

        contentHtml += `\n        <div id="${groupId}" class="role-section" style="scroll-margin-top: 3rem;">\n            <h2 class="role-title">${groupName}</h2>\n            <div class="tile-grid">\n`;
        items.sort((a, b) => a.plainName.localeCompare(b.plainName)).forEach(item => {
            const iconData = getIconData(item.plainName, groupName);
            contentHtml += `                <a href="sectionhtml/${item.file}" class="tile">
                    <div class="tile-icon" style="color: ${iconData.color}; background-color: ${iconData.bg};"><i class="ph ${iconData.icon}"></i></div>
                    <div class="tile-content">
                        <div class="tile-title">${item.plainName}</div>
                        <div class="tile-subtitle">UI Sub-Layer Module</div>
                    </div>
                </a>\n`;
        });
        contentHtml += `            </div>\n        </div>\n`;
        groupIndex++;
    }
});

const htmlContent = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrimeCare Component Showcase</title>
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        :root {
            --bg-color: #f8fafc;
            --surface-color: #ffffff;
            --border-color: #e2e8f0;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --accent-primary: #0ea5e9;
        }
        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-primary);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .sidebar {
            width: 300px;
            background-color: var(--surface-color);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            padding-top: 2rem;
            flex-shrink: 0;
        }
        .sidebar-header {
            padding: 0 1.5rem 2rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: 1rem;
        }
        .sidebar-header h1 {
            color: var(--accent-primary);
            font-size: 1.5rem;
            margin: 0 0 0.5rem 0;
        }
        .sidebar-header p {
            color: var(--text-secondary);
            font-size: 0.9rem;
            margin: 0;
        }
        .sidebar-item {
            padding: 0.85rem 1.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }
        .sidebar-item:hover {
            background-color: rgba(56, 189, 248, 0.05);
            color: var(--text-primary);
            border-left-color: var(--accent-primary);
        }
        .badge {
            background-color: var(--border-color);
            color: var(--text-primary);
            padding: 0.15rem 0.6rem;
            border-radius: 99px;
            font-size: 0.75rem;
            font-weight: 700;
        }
        .main-content {
            flex: 1;
            overflow-y: auto;
            padding: 3rem 4rem;
            scroll-behavior: smooth;
        }
        .home-header {
            margin-bottom: 4rem;
        }
        .home-header h1 {
            font-size: 2.5rem;
            margin: 0 0 0.5rem 0;
        }
        .home-header p {
            margin: 0;
            color: var(--text-secondary);
            font-size: 1.125rem;
        }
        .role-section {
            margin-bottom: 4rem;
        }
        .role-title {
            font-size: 1.5rem;
            color: var(--accent-primary);
            margin-bottom: 2rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.75rem;
        }
        .tile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }
        .tile {
            background-color: var(--surface-color);
            border: 1px solid #cbd5e1;
            padding: 1.25rem 1.5rem;
            border-radius: 0.75rem;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
        }
        .tile-icon {
            width: 48px;
            height: 48px;
            background-color: #f0f9ff;
            color: var(--accent-primary);
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            flex-shrink: 0;
            transition: all 0.2s;
        }
        .tile-content {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        .tile:hover {
            transform: translateY(-4px);
            border-color: var(--accent-primary);
            box-shadow: 0 15px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .tile:hover .tile-icon {
            background-color: var(--accent-primary);
            color: #ffffff;
            transform: scale(1.05);
        }
        .tile-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
        }
        .tile-subtitle {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h1>Platform Registry</h1>
            <p>${files.length} UI Modules Decoupled</p>
        </div>
        ${sidebarHtml}
    </div>
    <div class="main-content">
        <div class="home-header" id="top">
            <h1>Categorized Hub</h1>
            <p>Browse isolated structural layouts separated by their operational domain.</p>
        </div>
        ${contentHtml}
    </div>
</body>
</html>`;

fs.writeFileSync(showcaseFile, htmlContent, 'utf8');
console.log('✅ Successfully compiled interactive generic showcase gallery.');
