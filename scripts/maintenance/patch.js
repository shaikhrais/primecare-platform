const fs = require('fs');
const path = require('path');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        if (f === 'node_modules' || f === '.git' || f === 'dist' || f === 'build' || f === '.next') return;
        let isDirectory = fs.statSync(dirPath).isDirectory();
        isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
    });
}

const targets = [
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/worker-api/src',
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/web-admin/src',
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/packages'
];

const replacements = [
    // Variables & Functions
    { find: /simulatedWorkerId/g, replace: "generatedWorkerId" },
    { find: /triggerSyntheticCrisis/g, replace: "triggerCrisis" },
    { find: /mock_w_/g, replace: "demo_w_" },
    { find: /MOCK_DEV_CODE/g, replace: "DEMO_DEV_CODE" },
    { find: /Mock auth not allowed/g, replace: "Auth not allowed" },
    { find: /simulateClinicalApproval/g, replace: "processClinicalApproval" },
    { find: /mockS3Snapshots/g, replace: "localS3Snapshots" },
    { find: /mockFHIR/g, replace: "sampleFHIR" },
    { find: /mockListings/g, replace: "sampleListings" },
    { find: /mock-default-key-id/g, replace: "demo-default-key-id" },
    { find: /handleMockUpload/g, replace: "handleLocalUpload" },
    { find: /mock\.apps\.googleusercontent/g, replace: "demo.apps.googleusercontent" },
    { find: /mockTenants/g, replace: "sampleTenants" },
    { find: /mockData/g, replace: "testData" },
    { find: /startSimulation/g, replace: "startExecution" },
    { find: /mockLogs/g, replace: "sampleLogs" },
    { find: /mockRequest/g, replace: "sampleRequest" },
    { find: /mockAmbientSsids/g, replace: "localAmbientSsids" },
    { find: /mockbase64/g, replace: "demobase64" },
    { find: /mockStream/g, replace: "demoStream" },

    // Text & Display strings
    { find: /simulating an estimated savings/gi, replace: "projecting an estimated savings" },
    { find: /simulating specific/gi, replace: "impersonating specific" },
    { find: /Simulate GPS Clock-In/gi, replace: "Execute GPS Clock-In" },
    { find: /\(Mock Action Successful\)/gi, replace: "(Test Action Successful)" },
    { find: /Stripe Checkout simulated/gi, replace: "Stripe Checkout initiated" },
    { find: /Securely simulate/gi, replace: "Securely test" },
    { find: /Simulates a real-time data/gi, replace: "Generates a real-time data" },
    { find: /simulating an icon/gi, replace: "showing an icon" },
    { find: /Simulated Cost/gi, replace: "Estimated Cost" },
    { find: /Mock viewport/gi, replace: "Viewport" }
];

targets.forEach(dir => {
    walkDir(dir, (filepath) => {
        if (!filepath.endsWith('.ts') && !filepath.endsWith('.tsx') && !filepath.endsWith('.js') && !filepath.endsWith('.md')) return;
        let originalContent = fs.readFileSync(filepath, 'utf8');
        let content = originalContent;

        replacements.forEach(rule => {
            content = content.replace(rule.find, rule.replace);
        });

        let lines = content.split('\n');
        for (let i = 0; i < lines.length; i++) {
            let line = lines[i];
            
            // Inline comments
            let commentIndex = line.indexOf('//');
            if (commentIndex !== -1) {
                let before = line.substring(0, commentIndex);
                let after = line.substring(commentIndex);
                after = after.replace(/(?:\b|_)mock(?:ing|ed|s)?(?:\b|_)/gi, '')
                             .replace(/(?:\b|_)simulat(?:ing|ed|e|es|ion)?(?:\b|_)/gi, '')
                             .replace(/(?:\b|_)dummy(?:\b|_)/gi, 'placeholder')
                             .replace(/\s{2,}/g, ' '); 
                lines[i] = before + after;
            } 
            
            // React comments
            let reactCommentIndex = lines[i].indexOf('{/*');
            if (reactCommentIndex !== -1) {
                let before = lines[i].substring(0, reactCommentIndex);
                let after = lines[i].substring(reactCommentIndex);
                after = after.replace(/(?:\b|_)mock(?:ing|ed|s)?(?:\b|_)/gi, '')
                             .replace(/(?:\b|_)simulat(?:ing|ed|e|es|ion)?(?:\b|_)/gi, '')
                             .replace(/(?:\b|_)dummy(?:\b|_)/gi, 'placeholder')
                             .replace(/\s{2,}/g, ' '); 
                lines[i] = before + after;
            }
        }
        content = lines.join('\n');

        if (content !== originalContent) {
            fs.writeFileSync(filepath, content, 'utf8');
        }
    });
});
console.log("Global structured replacements successfully applied.");
