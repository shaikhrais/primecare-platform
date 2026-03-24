import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const localesDir = path.join(__dirname, '../src/locales');
const enPath = path.join(localesDir, 'en.json');
const frPath = path.join(localesDir, 'fr.json');

// Extract all string values from the registry, maintaining a flat structure for Natural Language Keys
function extractFlatStrings(obj: any, isFr: boolean = false, result: Record<string, string> = {}): Record<string, string> {
    for (const [key, value] of Object.entries(obj)) {
        if (typeof value === 'string') {
            result[value] = isFr ? `[FR] ${value}` : value;
        } else if (Array.isArray(value)) {
            value.forEach(item => {
                if (typeof item === 'string') {
                    result[item] = isFr ? `[FR] ${item}` : item;
                }
            });
        } else if (typeof value === 'object' && value !== null) {
            extractFlatStrings(value, isFr, result);
        }
    }
    return result;
}

const enTranslations = extractFlatStrings(ContentRegistry, false);
const frTranslations = extractFlatStrings(ContentRegistry, true);

// Add missing keys used in NavBar manually as Natural Language Keys too
const commonKeys = [
    "Home", "Staff", "Clients", "Visits", "Services", "Reports", "Settings", "Insights",
    "Welcome back", "Log out", "Search...", "Tableau de bord", "Personnel", "Visites", "Paramètres", "Analyses", "Bon retour", "Se déconnecter", "Recherche..."
];

const manuallyTranslatedFr: Record<string, string> = {
    "Home": "Tableau de bord",
    "Staff": "Personnel",
    "Clients": "Clients",
    "Visits": "Visites",
    "Services": "Services",
    "Reports": "Rapports",
    "Settings": "Paramètres",
    "Insights": "Analyses",
    "Welcome back": "Bon retour",
    "Log out": "Se déconnecter",
    "Search...": "Recherche..."
};

commonKeys.forEach(k => {
    enTranslations[k] = k;
    if (manuallyTranslatedFr[k]) {
        frTranslations[k] = manuallyTranslatedFr[k];
    } else {
        if (!frTranslations[k]) frTranslations[k] = `[FR] ${k}`;
    }
});

fs.writeFileSync(enPath, JSON.stringify(enTranslations, null, 4), 'utf-8');
fs.writeFileSync(frPath, JSON.stringify(frTranslations, null, 4), 'utf-8');

console.log('Successfully generated i18n translation files from ContentRegistry.');
