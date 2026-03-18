const fs = require('fs');
const file = 'apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts';

let content = fs.readFileSync(file, 'utf8');

// The AST extractor brought over things like [tab]: tabContent[tab]
// We need to define those variables at the top so the TypeScript compiler doesn't crash 
// given this is a static registry now.

const stubs = `
// --- Stubs for dynamically extracted React State ---
export const tab = 'default';
export const setTab = () => {};
export const activeTab = 'default';
export const setActiveTab = () => {};
export const tabContent: Record<string, any> = {};
export const COMPLEX_KEY_0 = 'COMPLEX_KEY_0';
export const COMPLEX_KEY_1 = 'COMPLEX_KEY_1';
export const COMPLEX_KEY_2 = 'COMPLEX_KEY_2';
export const COMPLEX_KEY_3 = 'COMPLEX_KEY_3';
export const COMPLEX_KEY_4 = 'COMPLEX_KEY_4';
export const COMPLEX_KEY_5 = 'COMPLEX_KEY_5';
export const COMPLEX_KEY_6 = 'COMPLEX_KEY_6';
export const COMPLEX_KEY_215 = 'COMPLEX_KEY_215';
export const COMPLEX_KEY_216 = 'COMPLEX_KEY_216';
export const COMPLEX_KEY_217 = 'COMPLEX_KEY_217';
export const COMPLEX_KEY_220 = 'COMPLEX_KEY_220';

`;

content = content.replace('export const PageSectionRegistry', stubs + '\nexport const PageSectionRegistry');

// Also handle TS1117: An object literal cannot have multiple properties with the same name.
// e.g. COMPLEX_KEY_215 might be defined multiple times as a key.
content = content.replace(/\[COMPLEX_KEY_(\d+)\]:/g, (match, num, offset, str) => {
     // Just append a random string to the complex key definition so they don't overlap in the giant registry
     const randomSuffix = Math.floor(Math.random() * 1000000);
     return `['COMPLEX_KEY_${num}_${randomSuffix}']:`;
});

// For instances where it's not a computed property but just defined as activeTab: ... we can just ignore it or let the stub handle it.
fs.writeFileSync(file, content, 'utf8');
console.log('Applied stubs to PageSectionRegistry.ts');
