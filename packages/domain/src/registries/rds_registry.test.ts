import { describe, it, expect } from 'vitest';
import { FormRegistry, getFormById } from './01_I_form_registry';
import { PageRegistry } from './01_I_page_registry';
import { ButtonRegistry } from './01_I_button_registry';
import { MASTER_REGISTRY } from './PageRegistry/master-registry';
import { HomeRegistry } from './PageRegistry/homes';

describe('RDS: PrimeCare Registry Integrity Bench', () => {

    it('should have unique IDs across all forms', () => {
        const ids = FormRegistry.map(f => f.id);
        const uniqueIds = new Set(ids);
        
        const duplicates = ids.filter((id, index) => ids.indexOf(id) !== index);
        
        if (duplicates.length > 0) {
            console.error('Duplicate Form IDs found:', [...new Set(duplicates)]);
        }
        
        expect(ids.length).toBe(uniqueIds.size);
    });

    it('should link every form page to a valid form registry entry', () => {
        const formPages = PageRegistry.filter(p => p.type === 'form');
        const brokenLinks: string[] = [];

        formPages.forEach(page => {
            if (!page.formRegistryId) {
                brokenLinks.push(`Page "${page.label}" (${page.id}) is type "form" but has no "formRegistryId"`);
            } else {
                const form = getFormById(page.formRegistryId);
                if (!form) {
                    brokenLinks.push(`Page "${page.label}" (${page.id}) references missing form "${page.formRegistryId}"`);
                }
            }
        });

        if (brokenLinks.length > 0) {
            console.error('Broken Form Links in PageRegistry:', brokenLinks);
        }

        expect(brokenLinks).toHaveLength(0);
    });

    it('should verify that all pages have valid Lucide-compatible icons', () => {
        // Simple regex check for lowercase-kebab-case icon names
        const iconPattern = /^[a-z0-9-]+$/;
        const invalidIcons: string[] = [];

        // Check MASTER_REGISTRY values
        Object.values(MASTER_REGISTRY).forEach((entry: any) => {
            if (entry.icon && !iconPattern.test(entry.icon)) {
                invalidIcons.push(`Master Entry "${entry.label}" has invalid icon name: "${entry.icon}"`);
            }
        });

        // Check HomeRegistry
        HomeRegistry.forEach(home => {
            if (home.icon && !iconPattern.test(home.icon)) {
                invalidIcons.push(`Home Site "${home.label}" has invalid icon name: "${home.icon}"`);
            }
        });

        // Check PageRegistry
        PageRegistry.forEach(page => {
            if (page.icon && !iconPattern.test(page.icon)) {
                invalidIcons.push(`Page "${page.label}" has invalid icon name: "${page.icon}"`);
            }
        });

        if (invalidIcons.length > 0) {
            console.error('Invalid Icon Names:', invalidIcons);
        }

        expect(invalidIcons).toHaveLength(0);
    });

    it('should ensure all associates in PageRegistry actually exist', () => {
        const missingAssociates: string[] = [];

        PageRegistry.forEach(page => {
            if (page.associates) {
                page.associates.forEach(assocCode => {
                    const exists = PageRegistry.some(p => p.categoryCode === assocCode);
                    if (!exists) {
                        missingAssociates.push(`Page "${page.label}" references missing associate code: "${assocCode}"`);
                    }
                });
            }
        });

        if (missingAssociates.length > 0) {
            console.error('Missing Page Associates:', missingAssociates);
        }

        expect(missingAssociates).toHaveLength(0);
    });
});
