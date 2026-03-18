const fs = require('fs');

function extractAndReplacePageSectionRegistry() {
    let content = fs.readFileSync('apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts', 'utf8');
    
    // Auto-replace any occurrence of title: 'Some string' or subtitle: 'Some string'
    let dict = {};
    let varCounter = 1;
    
    // A quick hack to move all titles and subtitles to a variable map
    content = content.replace(/(?:title|subtitle):\s*(['"])(.*?)\1/g, (match, quote, text) => {
        if (!text || text.trim() === '') return match;
        const key = 'V_' + Math.random().toString(36).substr(2, 9).toUpperCase();
        dict[key] = text;
        return match.replace(quote + text + quote, 'TEXT_VARS.' + key);
    });

    let header = `\nexport const TEXT_VARS: Record<string, string> = ${JSON.stringify(dict, null, 4)};\n`;
    
    fs.writeFileSync('apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts', header + content);
    console.log("Extracted " + Object.keys(dict).length + " strings from PageSectionRegistry.");
}

extractAndReplacePageSectionRegistry();
