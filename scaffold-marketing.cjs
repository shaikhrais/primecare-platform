const fs = require('fs');
const path = require('path');

const sections = [
    { name: 'Hero', title: 'Marketing Hero Header' },
    { name: 'FeatureCards', title: 'Product Features Grid' },
    { name: 'SocialProof', title: 'Client Testimonial Marquee' },
    { name: 'HowItWorks', title: 'Step-by-Step Onboarding' },
    { name: 'PricingTiers', title: 'Subscription Pricing Cards' },
    { name: 'FinalCta', title: 'Bottom Call-to-Action Banner' },
    { name: 'GlobalFooter', title: 'Standard Site Footer' },
    { name: 'TeamMembers', title: 'Executive Team Roster' },
    { name: 'ContactForm', title: 'Inquiry Matrix Form' },
    { name: 'FaqAccordion', title: 'Collapsible QA System' },
    { name: 'MarkdownDocument', title: 'Legal Terminology Engine' },
];

const tsDir = path.join(__dirname, 'apps/web-admin/src/app/sections/marketing');
const htmlDir = path.join(__dirname, 'sectionhtml');

if (!fs.existsSync(tsDir)) fs.mkdirSync(tsDir, { recursive: true });

let exportList = [];

sections.forEach(sec => {
    // 1. TS Generation
    const tsContent = `export const ${sec.name}Section = {
    title: "${sec.title}",
    componentType: "MarketingWidget",
    display: "block",
    kpiCards: [],
    emptyState: { icon: "pi pi-globe", message: "Placeholder for ${sec.name} content." }
};`;
    fs.writeFileSync(path.join(tsDir, `${sec.name}Section.ts`), tsContent, 'utf8');
    exportList.push(`export { ${sec.name}Section } from './marketing/${sec.name}Section';`);
    
    // 2. HTML Generation
    const htmlContent = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${sec.title} Preview</title>
    <style>
        :root { --bg-color: #f8fafc; --surface-color: #ffffff; --border-color: #e2e8f0; --text-primary: #0f172a; --text-secondary: #64748b; --accent-primary: #0ea5e9; }
        body { margin: 0; padding: 3rem; font-family: 'Inter', system-ui, sans-serif; background-color: var(--bg-color); color: var(--text-primary); }
        .widget-canvas { width: 100%; max-width: 1000px; margin: 3rem auto; background-color: var(--bg-color); display: flex; flex-direction: column; gap: 2rem; }
        .back-link { display: inline-flex; align-items: center; gap: 0.5rem; color: var(--text-secondary); text-decoration: none; padding: 0.5rem 1rem; border: 1px solid var(--border-color); border-radius: 0.5rem; font-size: 0.875rem; font-weight: 600; margin-bottom: 2rem; width: fit-content; transition: background 0.2s; }
        .back-link:hover { background-color: rgba(255,255,255,0.05); }
        .widget-title { font-size: 1.25rem; color: var(--accent-primary); margin: 0 0 1.5rem 0; padding-bottom: 1rem; border-bottom: 1px dashed var(--border-color); text-transform: uppercase; letter-spacing: 0.05em; }
        .mock-block { background-color: var(--surface-color); border: 1px solid var(--border-color); border-radius: 1rem; padding: 4rem 2rem; text-align: center; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.5); }
        .mock-title { font-size: 2.5rem; margin: 0 0 1rem 0; color: var(--text-primary); }
        .mock-subtitle { color: var(--text-secondary); max-width: 600px; margin: 0 auto; line-height: 1.6; }
    </style>
</head>
<body>
    <div class="widget-canvas">
        <a href="../section-showcase.html" class="back-link">← Back to Gallery</a>
        <div style="background-color: var(--surface-color); border: 1px solid var(--border-color); border-radius: 1rem; padding: 2.5rem;">
            <h2 class="widget-title">Sub-Layer Widget: ${sec.name}</h2>
            <div class="mock-block">
                <h3 class="mock-title">${sec.title}</h3>
                <p class="mock-subtitle">Marketing component layout configuration structure. This module will be dynamically injected into the public router as an isolated <code>&lt;div&gt;</code> component without global application dependencies.</p>
            </div>
        </div>
    </div>
</body>
</html>`;
    fs.writeFileSync(path.join(htmlDir, `${sec.name}.html`), htmlContent, 'utf8');
});

// Append to index.ts
const indexPath = path.join(__dirname, 'apps/web-admin/src/app/sections/index.ts');
let indexContent = fs.readFileSync(indexPath, 'utf8');
const registryMatch = indexContent.match(/export const PageSectionRegistry = {/);

if (registryMatch) {
    const splitIndex = registryMatch.index;
    let newIndexContent = indexContent.substring(0, splitIndex) + '\n// Marketing Modules\n' + exportList.join('\n') + '\n\n' + indexContent.substring(splitIndex);
    
    // Inject into the actual PageSectionRegistry dictionary map natively
    let registryInjections = sections.map(sec => `    ${sec.name}: ${sec.name}Section,`).join('\n');
    newIndexContent = newIndexContent.replace(/export const PageSectionRegistry = {/, `export const PageSectionRegistry = {\n${registryInjections}`);
    fs.writeFileSync(indexPath, newIndexContent, 'utf8');
}

console.log('✅ Rapidly scaffolded 11 Marketing Sub-Layer widgets cleanly into TS and HTML.');
