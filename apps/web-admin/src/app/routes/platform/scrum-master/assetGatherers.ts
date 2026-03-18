// Digital Property Manager: gatherer functions for all registry asset types
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry, ApiRegistry, ButtonRegistry, ContentRegistry, ThemeRegistry } = AdminRegistry;

export interface DigitalAsset {
    name: string;
    type: 'route' | 'api' | 'button' | 'content' | 'theme' | 'click';
    section: string;
    path?: string;
    method?: string;
    detail?: string;
    visits?: number;
    lastUsed?: number;
    status: 'active' | 'unused' | 'hot';
}

const flattenObj = (obj: any, section: string, type: DigitalAsset['type'], prefix = ''): DigitalAsset[] => {
    const items: DigitalAsset[] = [];
    for (const [key, val] of Object.entries(obj)) {
        if (typeof val === 'string') {
            items.push({ name: `${prefix}${key}`.replace(/_/g, ' '), type, section, path: val, status: 'unused' });
        } else if (typeof val === 'function') {
            items.push({ name: `${prefix}${key}(...)`, type, section, path: `[dynamic]`, detail: 'parameterized', status: 'unused' });
        } else if (typeof val === 'object' && val !== null) {
            items.push(...flattenObj(val, section, type, `${key} › `));
        }
    }
    return items;
};

export const gatherRoutes = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    const sections: [string, any][] = [
        ['Admin', RouteRegistry.ADMIN], ['Scrum Master', RouteRegistry.SCRUM_MASTER],
        ['Superuser', RouteRegistry.SUPERUSER], ['Manager', RouteRegistry.MANAGER],
        ['Staff', RouteRegistry.STAFF], ['PSW', RouteRegistry.PSW],
        ['RN', RouteRegistry.RN], ['Client', RouteRegistry.CLIENT],
        ['Coordinator', RouteRegistry.COORDINATOR], ['Allied', RouteRegistry.ALLIED],
    ];
    for (const [sec, obj] of sections) {
        if (obj && typeof obj === 'object') a.push(...flattenObj(obj, sec, 'route'));
        else if (typeof obj === 'string') a.push({ name: sec, type: 'route', section: sec, path: obj, status: 'unused' });
    }
    for (const key of ['LOGIN', 'REGISTER', 'FORGOT_PASSWORD', 'RESET_PASSWORD', 'PROFILE', 'SUPPORT', 'LEARN', 'KNOWLEDGE_BASE'] as const) {
        if ((RouteRegistry as any)[key]) a.push({ name: key.replace(/_/g, ' '), type: 'route', section: 'Shared', path: (RouteRegistry as any)[key], status: 'unused' });
    }
    return a;
};

export const gatherApis = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    const sections: [string, any][] = [];
    for (const [key, val] of Object.entries(ApiRegistry)) {
        if (typeof val === 'object' && val !== null) sections.push([key, val]);
        else if (typeof val === 'string') a.push({ name: key, type: 'api', section: 'Root', path: val, status: 'unused' });
    }
    for (const [sec, obj] of sections) a.push(...flattenObj(obj, sec, 'api'));
    return a;
};

export const gatherButtons = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        const allButtons = (ButtonRegistry as any).ALL || [];
        if (Array.isArray(allButtons)) {
            for (const btn of allButtons) {
                a.push({ name: btn.label || btn.id, type: 'button', section: btn.role || btn.module || 'General', path: btn.apiPath, detail: `${btn.type || ''} · ${btn.action || ''}`, status: 'unused' });
            }
        }
        for (const [key, val] of Object.entries(ButtonRegistry)) {
            if (key === 'ALL') continue;
            if (typeof val === 'object' && val !== null && !Array.isArray(val)) a.push(...flattenObj(val, key, 'button'));
        }
    } catch { }
    return a;
};

export const gatherContent = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        for (const [key, val] of Object.entries(ContentRegistry)) {
            if (typeof val === 'string') {
                a.push({ name: key.replace(/_/g, ' '), type: 'content', section: 'Content', path: undefined, detail: String(val).slice(0, 60), status: 'active' });
            } else if (typeof val === 'object' && val !== null) {
                a.push(...flattenObj(val, key, 'content'));
            }
        }
    } catch { }
    return a;
};

export const gatherTheme = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        for (const [key, val] of Object.entries(ThemeRegistry.COLORS)) {
            if (typeof val === 'string') {
                a.push({ name: key.replace(/_/g, ' '), type: 'theme', section: 'CSS Variables', path: val, status: 'active' });
            } else if (typeof val === 'object') {
                for (const [k2, v2] of Object.entries(val)) {
                    a.push({ name: `${key} › ${k2}`.replace(/_/g, ' '), type: 'theme', section: 'CSS Variables', path: v2 as string, status: 'active' });
                }
            }
        }
        for (const key of Object.keys(ThemeRegistry.PRESETS)) {
            a.push({ name: key.replace(/_/g, ' '), type: 'theme', section: 'Presets', status: 'active' });
        }
    } catch { }
    return a;
};
