const fs = require('fs');
const path = require('path');

const publicDir = path.join(__dirname, 'apps', 'web-admin', 'public', 'knowledge-base');
const docsDir = path.join(__dirname, 'docs', 'knowledge-base');

const references = {
    '02-fractal-saas': {
        route: '/admin/growth-strategy',
        title: 'Growth Strategy Home',
        description: 'Visualize the full architecture of the Fractal SaaS network in your admin portal.',
        imgText: 'Fractal+SaaS+Architecture'
    },
    '06-governance': {
        route: '/admin',
        title: 'Super Admin Command Center',
        description: 'The global view of platform metrics and health from the top of the fractal.',
        imgText: 'Platform+Governance+Home'
    },
    '08-white-labeling': {
        route: '/admin/company',
        title: 'Tenant Branding & Customization',
        description: 'Where Master Franchises customize hex colors and inject their own transparent logos.',
        imgText: 'White-Label+Settings'
    },
    '10-reseller-hub': {
        route: '/admin/reseller',
        title: 'The Reseller Hub',
        description: 'The interface for provisioning and managing subordinate Child Agencies in a Master network.',
        imgText: 'Reseller+Hub+Spawner'
    },
    '13-private-marketplace': {
        route: '/admin/private-marketplace',
        title: 'Private Marketplace Listings',
        description: 'Internal B2B listings where Master Franchises distribute proprietary training and resources to Child Tenants.',
        imgText: 'Private+Marketplace+Wall'
    },
    '15-clinical-autopilot': {
        route: '/admin/automation/clinical-autopilot',
        title: 'Clinical Auto-Pilot Engine',
        description: 'The matchmaking engine that routes unstaffed shifts to optimal providers algorithmically.',
        imgText: 'Auto-Pilot+Dispatch+Screen'
    },
    '21-risk-surveillance': {
        route: '/admin/system/risk-surveillance',
        title: 'Risk Surveillance Engine',
        description: 'The compliance home that throttles rogue tenants or providers that trigger safety thresholds.',
        imgText: 'Risk+Surveillance+Metrics'
    },
    '14-provider-onboarding': {
        route: '/admin/users',
        title: 'User Management & Compliance',
        description: 'The interface for tracking the portable credentials and verified W3C identities of the nursing labor force.',
        imgText: 'Provider+Compliance+Records'
    }
};

for (const [filename, ref] of Object.entries(references)) {
    const appendStr = `\n\n---\n\n## Visual Reference & Application Route\n\n**UI Home Link:** [Access the ${ref.title} Here](${ref.route})\n\n_${ref.description}_\n\n![${ref.title} Screenshot](https://placehold.co/800x400/F3F4F6/1E293B?text=${ref.imgText})\n`;

    // Append to public
    const publicFile = path.join(publicDir, filename + '.md');
    if (fs.existsSync(publicFile)) {
        fs.appendFileSync(publicFile, appendStr);
    }

    // Append to docs
    const docsFilename = filename.replace(/-/g, '_') + '.md';
    const docsFile = path.join(docsDir, docsFilename);
    if (fs.existsSync(docsFile)) {
        fs.appendFileSync(docsFile, appendStr);
    }

    console.log(`Updated ${filename} with visual references.`);
}
