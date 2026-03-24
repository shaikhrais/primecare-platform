/**
 * Registry Seed Script — Reads ContentRegistry and seeds the `registries` table.
 * Run via: POST /v1/debug/seed-registries (deployed endpoint)
 */

/** Flatten a nested object into dot-path keys */
function flattenObject(obj: Record<string, any>, prefix = ''): Array<{ key: string; value: string }> {
    const entries: Array<{ key: string; value: string }> = [];
    for (const [k, v] of Object.entries(obj)) {
        const fullKey = prefix ? `${prefix}.${k}` : k;
        if (typeof v === 'string') {
            entries.push({ key: fullKey, value: v });
        } else if (typeof v === 'object' && v !== null && !Array.isArray(v)) {
            entries.push(...flattenObject(v, fullKey));
        } else if (Array.isArray(v)) {
            entries.push({ key: fullKey, value: JSON.stringify(v) });
        } else {
            entries.push({ key: fullKey, value: String(v) });
        }
    }
    return entries;
}

/** Detect section from the top-level key */
function detectSection(key: string): string {
    const top = key.split('.')[0]!.toLowerCase();
    if (top.includes('home')) return 'homes';
    if (top.includes('nav') || top.includes('sidebar')) return 'nav';
    if (top.includes('admin')) return 'admin';
    if (top.includes('wizard') || top.includes('setup')) return 'wizards';
    if (top.includes('user') || top.includes('staff') || top.includes('psw') || top.includes('rn')) return 'users';
    if (top.includes('client') || top.includes('family')) return 'clients';
    if (top.includes('operation') || top.includes('service') || top.includes('incident')) return 'operations';
    if (top.includes('common') || top.includes('general')) return 'common';
    if (top.includes('scrum') || top.includes('monitor')) return 'scrum-master';
    if (top.includes('financial') || top.includes('billing') || top.includes('accounting')) return 'finance';
    return 'general';
}

export { flattenObject, detectSection };
